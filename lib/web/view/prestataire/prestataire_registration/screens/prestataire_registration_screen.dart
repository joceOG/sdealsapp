import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../data/services/api_client.dart';
import '../bloc/prestataire_registration.dart';
import 'steps/personal_info_step.dart';
import 'steps/service_selection_step.dart';
import 'steps/pricing_step.dart';
import 'steps/verification_step.dart';

// 🎯 ÉCRAN D'INSCRIPTION PRESTATAIRE MODERNE 2025
class PrestataireRegistrationScreen extends StatelessWidget {
  const PrestataireRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrestataireRegistrationBloc(
        apiClient: ApiClient(),
      )..add(const StartRegistration()),
      child: const _PrestataireRegistrationView(),
    );
  }
}

class _PrestataireRegistrationView extends StatelessWidget {
  const _PrestataireRegistrationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Inscription Prestataire',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PrestataireRegistrationBloc,
          PrestataireRegistrationState>(
        listener: (context, state) {
          if (state is PrestataireRegistrationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.go('/prestataire/dashboard');
          } else if (state is PrestataireRegistrationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PrestataireRegistrationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
              ),
            );
          }

          if (state is PrestataireRegistrationFormState) {
            return _buildRegistrationForm(context, state);
          }

          return const Center(
            child: Text('Erreur de chargement'),
          );
        },
      ),
    );
  }

  // 🎯 FORMULAIRE D'INSCRIPTION
  Widget _buildRegistrationForm(
    BuildContext context,
    PrestataireRegistrationFormState state,
  ) {
    return Column(
      children: [
        // Barre de progression
        _buildProgressBar(state),

        // Contenu du formulaire
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
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
            child: _buildStepContent(context, state),
          ),
        ),

        // Boutons de navigation
        _buildNavigationButtons(context, state),
      ],
    );
  }

  // 🎯 BARRE DE PROGRESSION
  Widget _buildProgressBar(PrestataireRegistrationFormState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Titre de l'étape
          Text(
            _getStepTitle(state.currentStep),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          // Barre de progression
          Row(
            children: List.generate(state.totalSteps, (index) {
              final stepNumber = index + 1;
              final isActive = stepNumber <= state.currentStep;
              final isCompleted = stepNumber < state.currentStep;

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: index < state.totalSteps - 1 ? 8 : 0,
                  ),
                  child: Row(
                    children: [
                      // Cercle de l'étape
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF4CAF50)
                              : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )
                              : Text(
                                  stepNumber.toString(),
                                  style: TextStyle(
                                    color: isActive
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      // Ligne de connexion
                      if (index < state.totalSteps - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isCompleted
                                ? const Color(0xFF4CAF50)
                                : Colors.grey.shade300,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // 🎯 CONTENU DE L'ÉTAPE
  Widget _buildStepContent(
    BuildContext context,
    PrestataireRegistrationFormState state,
  ) {
    switch (state.currentStep) {
      case 1:
        return const PersonalInfoStep();
      case 2:
        return const ServiceSelectionStep();
      case 3:
        return const PricingStep();
      case 4:
        return const VerificationStep();
      default:
        return const Center(
          child: Text('Étape non trouvée'),
        );
    }
  }

  // 🎯 BOUTONS DE NAVIGATION
  Widget _buildNavigationButtons(
    BuildContext context,
    PrestataireRegistrationFormState state,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Bouton Précédent
          if (state.canGoPrevious)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<PrestataireRegistrationBloc>().add(
                        const PreviousStep(),
                      );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF4CAF50)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Précédent',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          if (state.canGoPrevious) const SizedBox(width: 16),

          // Bouton Suivant/Valider
          Expanded(
            child: ElevatedButton(
              onPressed: state.canGoNext
                  ? () {
                      if (state.currentStep < state.totalSteps) {
                        context.read<PrestataireRegistrationBloc>().add(
                              const NextStep(),
                            );
                      } else {
                        context.read<PrestataireRegistrationBloc>().add(
                              const SubmitRegistration(),
                            );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                state.currentStep < state.totalSteps ? 'Suivant' : 'Valider',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 TITRE DE L'ÉTAPE
  String _getStepTitle(int step) {
    switch (step) {
      case 1:
        return 'Informations personnelles';
      case 2:
        return 'Sélection des services';
      case 3:
        return 'Tarifs et disponibilités';
      case 4:
        return 'Vérification et documents';
      default:
        return 'Étape $step';
    }
  }
}
