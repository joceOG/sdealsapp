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
    on<SavePersonalInfoSimplified>(_onSavePersonalInfoSimplified);
    on<SaveServiceSelection>(_onSaveServiceSelection);
    on<SavePricing>(_onSavePricing);
    on<SavePricingSimplified>(_onSavePricingSimplified);
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
      totalSteps: 2, // Simplifié à 2 étapes
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

  // 💾 SAUVEGARDER LES INFORMATIONS PERSONNELLES SIMPLIFIÉES (MODÈLE MOBILE)
  void _onSavePersonalInfoSimplified(
    SavePersonalInfoSimplified event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final updatedFormData = Map<String, dynamic>.from(currentState.formData);

      updatedFormData['personalInfo'] = {
        'fullName': event.fullName,
        'phone': event.phone,
        'email': event.email ?? '',
        'category': event.category,
        'service': event.service,
        'serviceAreas': event.serviceAreas,
        'position': {
          'latitude': event.position.latitude,
          'longitude': event.position.longitude,
        },
        'address': event.address,
      };

      emit(currentState.copyWith(
        formData: updatedFormData,
        canGoNext: true,
        errorMessage: null,
      ));
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

  // 💰 SAUVEGARDER LES TARIFS SIMPLIFIÉS (MODÈLE MOBILE)
  void _onSavePricingSimplified(
    SavePricingSimplified event,
    Emitter<PrestataireRegistrationState> emit,
  ) {
    if (state is PrestataireRegistrationFormState) {
      final currentState = state as PrestataireRegistrationFormState;
      final updatedFormData = Map<String, dynamic>.from(currentState.formData);

      updatedFormData['pricingInfo'] = {
        'dailyRate': event.dailyRate,
        'paymentMode': event.paymentMode,
        'availableDays': event.availableDays,
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
        // Préparer les données pour l'API en mappant les 2 étapes simplifiées
        final formData = currentState.formData;
        final personalInfo = formData['personalInfo'] as Map<String, dynamic>?;
        final pricingInfo = formData['pricingInfo'] as Map<String, dynamic>?;

        if (personalInfo == null || pricingInfo == null) {
          emit(const PrestataireRegistrationFailure(
            error: 'Données d\'inscription incomplètes',
          ));
          return;
        }

        // Mapper les données vers le format attendu par l'API
        final apiData = {
          // Informations personnelles
          'nom': personalInfo['fullName']?.toString().split(' ').first ?? '',
          'prenom': personalInfo['fullName']?.toString().split(' ').skip(1).join(' ') ?? '',
          'telephone': personalInfo['phone'] ?? '',
          'email': personalInfo['email'] ?? '',
          'adresse': personalInfo['address'] ?? '',
          'ville': personalInfo['serviceAreas']?.isNotEmpty == true 
              ? personalInfo['serviceAreas'][0] : '',
          
          // Informations de service
          'categorie': personalInfo['category'] ?? '',
          'service': personalInfo['service'] ?? '',
          'zonesIntervention': personalInfo['serviceAreas'] ?? [],
          
          // Position (si disponible)
          if (personalInfo['position'] != null) ...{
            'latitude': personalInfo['position']['latitude'],
            'longitude': personalInfo['position']['longitude'],
          },
          
          // Tarifs et disponibilités
          'tarifJournalier': pricingInfo['dailyRate'] ?? 0,
          'modePaiement': pricingInfo['paymentMode'] ?? 'mobile_money',
          'joursDisponibles': pricingInfo['availableDays'] ?? [],
          
          // Statut par défaut
          'statut': 'en_attente',
          'verifie': false,
        };

        print('🚀 Envoi des données d\'inscription prestataire:');
        print('📤 Données: $apiData');

        // Appel API pour créer le prestataire
        final response = await _apiClient.createPrestataire(apiData);

        print('📥 Réponse API: $response');

        if (response['success'] == true || response['_id'] != null) {
          emit(PrestataireRegistrationSuccess(
            message: 'Inscription réussie ! Votre profil est en cours de validation.',
            prestataireData: response,
          ));
        } else {
          emit(PrestataireRegistrationFailure(
            error: response['message'] ?? response['error'] ?? 'Erreur lors de l\'inscription',
          ));
        }
      } catch (e) {
        print('❌ Erreur lors de l\'inscription: $e');
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
