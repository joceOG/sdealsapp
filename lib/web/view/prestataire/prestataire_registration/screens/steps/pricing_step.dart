import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/prestataire_registration.dart';

// 🎯 ÉTAPE TARIFS ET DISPONIBILITÉS
class PricingStep extends StatefulWidget {
  const PricingStep({super.key});

  @override
  State<PricingStep> createState() => _PricingStepState();
}

class _PricingStepState extends State<PricingStep> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _tarifControllers = {};
  String _selectedModePaiement = '';
  String _selectedDisponibilite = '';

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs pour chaque service
    for (final service in _services) {
      _tarifControllers[service['id']] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _tarifControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de l'étape
            const Text(
              'Tarifs et disponibilités',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Définissez vos tarifs et vos créneaux de disponibilité',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 32),

            // Formulaire
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Tarifs par service
                    _buildSection(
                      title: 'Tarifs par service *',
                      subtitle: 'Définissez vos tarifs en FCFA',
                      child: _buildTarifsGrid(),
                    ),
                    const SizedBox(height: 32),

                    // Mode de paiement
                    _buildSection(
                      title: 'Mode de paiement *',
                      subtitle: 'Comment souhaitez-vous être payé ?',
                      child: _buildModePaiement(),
                    ),
                    const SizedBox(height: 32),

                    // Disponibilités
                    _buildSection(
                      title: 'Disponibilités *',
                      subtitle: 'Quand êtes-vous disponible ?',
                      child: _buildDisponibilites(),
                    ),
                  ],
                ),
              ),
            ),

            // Bouton de validation
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateAndSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continuer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🎯 SECTION
  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
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
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  // 🎯 GRILLE DES TARIFS
  Widget _buildTarifsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 800 ? 2 : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            final controller = _tarifControllers[service['id']]!;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        service['icon'],
                        color: const Color(0xFF4CAF50),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          service['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        'Prix (FCFA)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Prix requis';
                            }
                            final price = double.tryParse(value);
                            if (price == null || price <= 0) {
                              return 'Prix invalide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xFF4CAF50), width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 🎯 MODE DE PAIEMENT
  Widget _buildModePaiement() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: _modePaiements.map((mode) {
          final isSelected = _selectedModePaiement == mode['id'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedModePaiement = mode['id'];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4CAF50).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4CAF50)
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    mode['icon'],
                    color: isSelected
                        ? const Color(0xFF4CAF50)
                        : Colors.grey.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mode['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFF374151),
                          ),
                        ),
                        Text(
                          mode['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.8)
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF4CAF50),
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 🎯 DISPONIBILITÉS
  Widget _buildDisponibilites() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: _disponibilites.map((dispo) {
          final isSelected = _selectedDisponibilite == dispo['id'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDisponibilite = dispo['id'];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4CAF50).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4CAF50)
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    dispo['icon'],
                    color: isSelected
                        ? const Color(0xFF4CAF50)
                        : Colors.grey.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dispo['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFF374151),
                          ),
                        ),
                        Text(
                          dispo['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? const Color(0xFF4CAF50).withOpacity(0.8)
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF4CAF50),
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 🎯 VALIDATION ET SAUVEGARDE
  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      if (_selectedModePaiement.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner un mode de paiement'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_selectedDisponibilite.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner vos disponibilités'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Préparer les tarifs
      final Map<String, double> tarifs = {};
      for (final entry in _tarifControllers.entries) {
        final price = double.tryParse(entry.value.text);
        if (price != null && price > 0) {
          tarifs[entry.key] = price;
        }
      }

      context.read<PrestataireRegistrationBloc>().add(
            SavePricing(
              tarifs: tarifs,
              modePaiement: _selectedModePaiement,
              disponibilite: _selectedDisponibilite,
            ),
          );
    }
  }

  // 🎯 DONNÉES DES SERVICES
  static final List<Map<String, dynamic>> _services = [
    {
      'id': 'reparation_electromenager',
      'name': 'Réparation électroménager',
      'icon': Icons.build,
    },
    {
      'id': 'menage_ponctuel',
      'name': 'Ménage ponctuel',
      'icon': Icons.cleaning_services,
    },
    {
      'id': 'transport_personnes',
      'name': 'Transport de personnes',
      'icon': Icons.directions_car,
    },
    {
      'id': 'depannage_informatique',
      'name': 'Dépannage informatique',
      'icon': Icons.computer,
    },
    {
      'id': 'coaching_personnel',
      'name': 'Coaching personnel',
      'icon': Icons.psychology,
    },
    {
      'id': 'cours_musique',
      'name': 'Cours de musique',
      'icon': Icons.music_note,
    },
  ];

  // 🎯 MODES DE PAIEMENT
  static final List<Map<String, dynamic>> _modePaiements = [
    {
      'id': 'soutrapay',
      'name': 'SoutraPay',
      'description': 'Paiement via notre plateforme sécurisée',
      'icon': Icons.account_balance_wallet,
    },
    {
      'id': 'mobile_money',
      'name': 'Mobile Money',
      'description': 'Orange Money, MTN Money, Moov Money',
      'icon': Icons.phone_android,
    },
    {
      'id': 'virement_bancaire',
      'name': 'Virement bancaire',
      'description': 'Transfert direct vers votre compte bancaire',
      'icon': Icons.account_balance,
    },
    {
      'id': 'especes',
      'name': 'Espèces',
      'description': 'Paiement en espèces lors de la prestation',
      'icon': Icons.money,
    },
  ];

  // 🎯 DISPONIBILITÉS
  static final List<Map<String, dynamic>> _disponibilites = [
    {
      'id': 'tous_jours',
      'name': 'Tous les jours',
      'description': 'Disponible 7j/7, 24h/24',
      'icon': Icons.schedule,
    },
    {
      'id': 'semaine',
      'name': 'En semaine',
      'description': 'Lundi à vendredi, 8h à 18h',
      'icon': Icons.work,
    },
    {
      'id': 'weekend',
      'name': 'Week-end',
      'description': 'Samedi et dimanche uniquement',
      'icon': Icons.weekend,
    },
    {
      'id': 'soiree',
      'name': 'En soirée',
      'description': 'Après 18h, tous les jours',
      'icon': Icons.nightlight_round,
    },
  ];
}
