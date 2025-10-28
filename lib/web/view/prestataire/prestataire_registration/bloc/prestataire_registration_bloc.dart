import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/services/api_client.dart';
import 'prestataire_registration_event.dart';
import 'prestataire_registration_state.dart';

// 🎯 BLOC D'INSCRIPTION PRESTATAIRE
class PrestataireRegistrationBloc
    extends Bloc<PrestataireRegistrationEvent, PrestataireRegistrationState> {
  final ApiClient _apiClient;

  PrestataireRegistrationBloc({required ApiClient apiClient})
      : _apiClient = apiClient,
        super(const PrestataireRegistrationInitial()) {
    // Gestionnaires d'événements
    on<StartRegistration>(_onStartRegistration);
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<SavePersonalInfo>(_onSavePersonalInfo);
    on<SaveServiceSelection>(_onSaveServiceSelection);
    on<SavePricing>(_onSavePricing);
    on<SaveDocuments>(_onSaveDocuments);
    on<SubmitRegistration>(_onSubmitRegistration);
    on<ResetRegistration>(_onResetRegistration);
    on<CancelRegistration>(_onCancelRegistration);
  }

  // 🚀 DÉMARRER L'INSCRIPTION
  void _onStartRegistration(
    StartRegistration event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    emit(const PrestataireRegistrationFormState(
      currentStep: 1,
      totalSteps: 4,
      formData: {},
      canGoNext: false,
      canGoPrevious: false,
    ));
  }

  // 📝 ÉTAPE SUIVANTE
  void _onNextStep(
    NextStep event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final nextStep = currentState.currentStep + 1;

      if (nextStep <= currentState.totalSteps) {
        emit(currentState.copyWith(
          currentStep: nextStep,
          canGoPrevious: true,
          canGoNext: nextStep < currentState.totalSteps,
        ));
      }
    }
  }

  // ⬅️ ÉTAPE PRÉCÉDENTE
  void _onPreviousStep(
    PreviousStep event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final previousStep = currentState.currentStep - 1;

      if (previousStep >= 1) {
        emit(currentState.copyWith(
          currentStep: previousStep,
          canGoPrevious: previousStep > 1,
          canGoNext: true,
        ));
      }
    }
  }

  // 💾 SAUVEGARDER LES INFORMATIONS PERSONNELLES
  void _onSavePersonalInfo(
    SavePersonalInfo event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final updatedFormData = Map<String, dynamic>.from(currentState.formData);

      updatedFormData['personalInfo'] = {
        'nom': event.nom,
        'prenom': event.prenom,
        'email': event.email,
        'telephone': event.telephone,
        'adresse': event.adresse,
        'ville': event.ville,
        'dateNaissance': event.dateNaissance,
        'genre': event.genre,
      };

      emit(currentState.copyWith(
        formData: updatedFormData,
        canGoNext: true,
        errorMessage: null,
      ));
    }
  }

  // 🛠️ SAUVEGARDER LA SÉLECTION DE SERVICES
  void _onSaveServiceSelection(
    SaveServiceSelection event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final updatedFormData = Map<String, dynamic>.from(currentState.formData);

      updatedFormData['serviceSelection'] = {
        'categories': event.categories,
        'services': event.services,
        'description': event.description,
        'competences': event.competences,
      };

      emit(currentState.copyWith(
        formData: updatedFormData,
        canGoNext: true,
        errorMessage: null,
      ));
    }
  }

  // 💰 SAUVEGARDER LES TARIFS
  void _onSavePricing(
    SavePricing event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final updatedFormData = Map<String, dynamic>.from(currentState.formData);

      updatedFormData['pricing'] = {
        'tarifs': event.tarifs,
        'modePaiement': event.modePaiement,
        'disponibilite': event.disponibilite,
      };

      emit(currentState.copyWith(
        formData: updatedFormData,
        canGoNext: true,
        errorMessage: null,
      ));
    }
  }

  // 📄 SAUVEGARDER LES DOCUMENTS
  void _onSaveDocuments(
    SaveDocuments event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final updatedFormData = Map<String, dynamic>.from(currentState.formData);

      updatedFormData['documents'] = {
        'documents': event.documents,
        'photoProfil': event.photoProfil,
        'pieceIdentite': event.pieceIdentite,
      };

      emit(currentState.copyWith(
        formData: updatedFormData,
        canGoNext: true,
        errorMessage: null,
      ));
    }
  }

  // ✅ SOUMETTRE L'INSCRIPTION
  void _onSubmitRegistration(
    SubmitRegistration event,
    Emitter<PrestataireRegistrationState> emit,
  ) async {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;

      emit(const PrestataireRegistrationLoading());

      try {
        // Préparer les données pour l'API
        final formData = currentState.formData;

        // Appel API pour créer le prestataire
        final response = await _apiClient.createPrestataire(formData);

        if (response['success'] == true) {
          emit(PrestataireRegistrationSuccess(
            message:
                'Inscription réussie ! Votre profil est en cours de validation.',
            prestataireData: response['prestataire'],
          ));
        } else {
          emit(PrestataireRegistrationFailure(
            error: response['message'] ?? 'Erreur lors de l\'inscription',
          ));
        }
      } catch (e) {
        emit(PrestataireRegistrationFailure(
          error: 'Erreur de connexion: ${e.toString()}',
        ));
      }
    }
  }

  // 🔄 RÉINITIALISER LE FORMULAIRE
  void _onResetRegistration(
    ResetRegistration event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    emit(const PrestataireRegistrationInitial());
  }

  // ❌ ANNULER L'INSCRIPTION
  void _onCancelRegistration(
    CancelRegistration event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    emit(const PrestataireRegistrationInitial());
  }
}
