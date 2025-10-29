import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/AppBarWidget.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

// 🎯 ÉCRAN PARAMÈTRES
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const LoadSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBarWidget(),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is SettingsSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is SettingsLoaded && state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: Colors.blue,
              ),
            );
            // Effacer le message après affichage
            context.read<SettingsBloc>().add(const ClearSettingsError());
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading || state is SettingsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SettingsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur de chargement',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.error,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<SettingsBloc>().add(const LoadSettings());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Réessayer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1CBF3F),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SettingsLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Container(
                  width: 800,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🎯 TITRE
                      const Text(
                        'Paramètres',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Personnalisez votre expérience sur SDeals.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 🔔 NOTIFICATIONS
                      _buildSectionTitle('Notifications'),
                      const SizedBox(height: 16),
                      _buildSwitchTile(
                        title: 'Notifications',
                        subtitle: 'Recevoir des notifications générales',
                        value: state.notificationsEnabled,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                ToggleNotifications(enabled: value),
                              );
                        },
                        icon: Icons.notifications_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildSwitchTile(
                        title: 'Notifications Email',
                        subtitle: 'Recevoir des notifications par email',
                        value: state.emailNotificationsEnabled,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                ToggleEmailNotifications(enabled: value),
                              );
                        },
                        icon: Icons.email_outlined,
                        enabled: state.notificationsEnabled,
                      ),
                      const SizedBox(height: 12),
                      _buildSwitchTile(
                        title: 'Notifications Push',
                        subtitle: 'Recevoir des notifications push',
                        value: state.pushNotificationsEnabled,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                TogglePushNotifications(enabled: value),
                              );
                        },
                        icon: Icons.phone_android_outlined,
                        enabled: state.notificationsEnabled,
                      ),
                      const SizedBox(height: 32),

                      // 🌍 LANGUE ET RÉGION
                      _buildSectionTitle('Langue et Région'),
                      const SizedBox(height: 16),
                      _buildDropdownTile(
                        title: 'Langue',
                        subtitle: 'Choisissez votre langue préférée',
                        value: state.language,
                        items: const [
                          DropdownMenuItem(
                              value: 'fr', child: Text('Français')),
                          DropdownMenuItem(value: 'en', child: Text('English')),
                          DropdownMenuItem(value: 'es', child: Text('Español')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsBloc>().add(
                                  ChangeLanguage(language: value),
                                );
                          }
                        },
                        icon: Icons.language_outlined,
                      ),
                      const SizedBox(height: 32),

                      // 🎨 APPARENCE
                      _buildSectionTitle('Apparence'),
                      const SizedBox(height: 16),
                      _buildDropdownTile(
                        title: 'Thème',
                        subtitle: 'Choisissez votre thème préféré',
                        value: state.theme,
                        items: const [
                          DropdownMenuItem(
                              value: 'light', child: Text('Clair')),
                          DropdownMenuItem(
                              value: 'dark', child: Text('Sombre')),
                          DropdownMenuItem(
                              value: 'system', child: Text('Système')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsBloc>().add(
                                  ChangeTheme(theme: value),
                                );
                          }
                        },
                        icon: Icons.palette_outlined,
                      ),
                      const SizedBox(height: 32),

                      // 🔒 CONFIDENTIALITÉ
                      _buildSectionTitle('Confidentialité et Sécurité'),
                      const SizedBox(height: 16),
                      _buildSwitchTile(
                        title: 'Partage de données',
                        subtitle: 'Autoriser le partage de données anonymes',
                        value: state.dataSharingEnabled,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                ToggleDataSharing(enabled: value),
                              );
                        },
                        icon: Icons.share_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildSwitchTile(
                        title: 'Analytics',
                        subtitle: 'Autoriser la collecte de données d\'usage',
                        value: state.analyticsEnabled,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                ToggleAnalytics(enabled: value),
                              );
                        },
                        icon: Icons.analytics_outlined,
                      ),
                      const SizedBox(height: 32),

                      // 💾 ACTIONS
                      _buildSectionTitle('Actions'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<SettingsBloc>()
                                    .add(const SaveSettings());
                              },
                              icon: const Icon(Icons.save_outlined),
                              label: const Text('Sauvegarder'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _showResetDialog(context);
                              },
                              icon: const Icon(Icons.restore_outlined),
                              label: const Text('Réinitialiser'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.orange,
                                side: const BorderSide(color: Colors.orange),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // ℹ️ INFORMATIONS
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.blue.shade600,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Vos paramètres sont sauvegardés localement et synchronisés automatiquement.',
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const Center(
            child: Text('État inconnu'),
          );
        },
      ),
    );
  }

  // 🎯 TITRE DE SECTION
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1E293B),
      ),
    );
  }

  // 🔄 TILE AVEC SWITCH
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    bool enabled = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled ? Colors.grey.shade300 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: enabled ? const Color(0xFF1CBF3F) : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: enabled
                        ? const Color(0xFF1E293B)
                        : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        enabled ? Colors.grey.shade600 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: const Color(0xFF1CBF3F),
          ),
        ],
      ),
    );
  }

  // 📋 TILE AVEC DROPDOWN
  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF1CBF3F),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          DropdownButton<String>(
            value: value,
            items: items,
            onChanged: onChanged,
            underline: const SizedBox(),
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // 🔄 DIALOGUE DE RÉINITIALISATION
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Réinitialiser les paramètres'),
          content: const Text(
            'Êtes-vous sûr de vouloir réinitialiser tous vos paramètres ? Cette action ne peut pas être annulée.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<SettingsBloc>().add(const ResetSettings());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Réinitialiser'),
            ),
          ],
        );
      },
    );
  }
}
