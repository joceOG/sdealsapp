import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/prestataire_registration.dart';

// 🎯 ÉTAPE TARIFS SIMPLIFIÉE (MODÈLE MOBILE)
class PricingStep extends StatefulWidget {
  const PricingStep({super.key});

  @override
  State<PricingStep> createState() => _PricingStepState();
}

class _PricingStepState extends State<PricingStep> {
  final _formKey = GlobalKey<FormState>();
  final _dailyRateController = TextEditingController();
  String _selectedPaymentMode = 'mobile_money';
  List<String> _selectedDays = [];

  // Jours de la semaine
  final List<Map<String, dynamic>> _availableDays = [
    {'id': 'lundi', 'name': 'Lundi', 'short': 'Lun'},
    {'id': 'mardi', 'name': 'Mardi', 'short': 'Mar'},
    {'id': 'mercredi', 'name': 'Mercredi', 'short': 'Mer'},
    {'id': 'jeudi', 'name': 'Jeudi', 'short': 'Jeu'},
    {'id': 'vendredi', 'name': 'Vendredi', 'short': 'Ven'},
    {'id': 'samedi', 'name': 'Samedi', 'short': 'Sam'},
    {'id': 'dimanche', 'name': 'Dimanche', 'short': 'Dim'},
  ];

  // Modes de paiement
  final List<Map<String, dynamic>> _paymentModes = [
    {
      'id': 'mobile_money',
      'name': 'Mobile Money',
      'icon': Icons.phone_android,
      'description': 'Orange Money, MTN Money'
    },
    {
      'id': 'bank_transfer',
      'name': 'Virement bancaire',
      'icon': Icons.account_balance,
      'description': 'Transfert vers votre compte'
    },
    {
      'id': 'cash',
      'name': 'Espèces',
      'icon': Icons.money,
      'description': 'Paiement en main propre'
    },
  ];

  @override
  void dispose() {
    _dailyRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrestataireRegistrationBloc,
        PrestataireRegistrationState>(
      listener: (context, state) {
        if (state is PrestataireRegistrationLoading) {
          // Afficher un indicateur de chargement
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PrestataireRegistrationSuccess) {
          // Fermer le dialog de chargement
          Navigator.of(context).pop();

          // Afficher le message de succès
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );

          // Rediriger vers le dashboard prestataire
          Future.delayed(const Duration(seconds: 2), () {
            context.go('/prestataire/dashboard');
          });
        } else if (state is PrestataireRegistrationFailure) {
          // Fermer le dialog de chargement
          Navigator.of(context).pop();

          // Afficher l'erreur
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 32),

                // Formulaire
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Tarif journalier
                          _buildDailyRateSection(),
                          const SizedBox(height: 32),

                          // Mode de paiement
                          _buildPaymentModeSection(),
                          const SizedBox(height: 32),

                          // Jours de disponibilité
                          _buildAvailabilitySection(),
                          const SizedBox(height: 32),

                          // Note informative
                          _buildInfoNote(),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bouton de validation
                const SizedBox(height: 24),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🎯 HEADER
  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Tarifs et disponibilités',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Définissez votre tarif journalier et vos créneaux',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // 🎯 TARIF JOURNALIER
  Widget _buildDailyRateSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Votre tarif journalier *',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Combien facturez-vous par jour de travail ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _dailyRateController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Le tarif journalier est requis';
              }
              final amount = int.tryParse(value);
              if (amount == null || amount < 1000) {
                return 'Le tarif minimum est de 1000 FCFA';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Ex: 15000',
              prefixText: 'FCFA ',
              prefixStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF4CAF50),
              ),
              hintStyle: TextStyle(color: Colors.grey.shade400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF4CAF50), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 MODE DE PAIEMENT
  Widget _buildPaymentModeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mode de paiement préféré *',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Comment souhaitez-vous être payé ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          ..._paymentModes.map((mode) {
            final isSelected = _selectedPaymentMode == mode['id'];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPaymentMode = mode['id'];
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF4CAF50).withOpacity(0.1)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        mode['icon'],
                        color: isSelected
                            ? const Color(0xFF4CAF50)
                            : Colors.grey.shade600,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mode['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              mode['description'],
                              style: TextStyle(
                                fontSize: 14,
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
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // 🎯 DISPONIBILITÉS
  Widget _buildAvailabilitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jours de disponibilité *',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Quels jours êtes-vous disponible ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableDays.map((day) {
              final isSelected = _selectedDays.contains(day['id']);
              return FilterChip(
                label: Text(day['short']),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedDays.add(day['id']);
                    } else {
                      _selectedDays.remove(day['id']);
                    }
                  });
                },
                selectedColor: const Color(0xFF4CAF50).withOpacity(0.2),
                checkmarkColor: const Color(0xFF4CAF50),
                backgroundColor: Colors.grey.shade100,
                labelStyle: TextStyle(
                  color: isSelected
                      ? const Color(0xFF4CAF50)
                      : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 🎯 NOTE INFORMATIVE
  Widget _buildInfoNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: const Row(
        children: [
          Icon(Icons.info, color: Colors.blue),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Vous pourrez modifier ces informations plus tard dans votre profil prestataire.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 BOUTON DE VALIDATION
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _validateAndSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Finaliser mon inscription',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // 🎯 VALIDATION ET SOUMISSION
  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Veuillez sélectionner au moins un jour de disponibilité')),
        );
        return;
      }

      // Dispatch l'événement de sauvegarde des tarifs
      context.read<PrestataireRegistrationBloc>().add(
            SavePricingSimplified(
              dailyRate: int.parse(_dailyRateController.text),
              paymentMode: _selectedPaymentMode,
              availableDays: _selectedDays,
            ),
          );

      // Dispatch l'événement de soumission finale
      context.read<PrestataireRegistrationBloc>().add(
            const SubmitRegistration(),
          );
    }
  }
}
