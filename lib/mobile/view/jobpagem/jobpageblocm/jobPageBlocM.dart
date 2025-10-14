import 'package:sdealsapp/mobile/view/jobpagem/jobpageblocm/jobPageEventM.dart';
import 'package:sdealsapp/mobile/view/jobpagem/jobpageblocm/jobPageStateM.dart';

import 'package:bloc/bloc.dart';

import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/ai_services/mock_implementations/mock_price_estimation_service.dart';
import 'package:sdealsapp/ai_services/mock_implementations/mock_provider_matching_service.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/ai_services/models/provider_match_explanation.dart';
import 'package:sdealsapp/data/models/prestataire.dart';

import '../../../../data/models/service.dart';

class JobPageBlocM extends Bloc<JobPageEventM, JobPageStateM> {
  JobPageBlocM() : super(JobPageStateM.initial()) {
    on<LoadCategorieDataJobM>(_onLoadCategorieDataJobM);
    on<LoadServiceDataJobM>(_onLoadServiceDataJobM);
    on<LoadPriceEstimationM>(_onLoadPriceEstimationM);
    on<LoadProviderMatchingM>(_onLoadProviderMatchingM);
  }

  Future<void> _onLoadCategorieDataJobM(
    LoadCategorieDataJobM event,
    Emitter<JobPageStateM> emit,
  ) async {
    // String nomgroupe = "Metiers";
    // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading: true));

    ApiClient apiClient = ApiClient();
    print("Try");
    try {
      var nomgroupe = "Métiers";
      List<Categorie> list_categorie =
          await apiClient.fetchCategorie(nomgroupe);
      print("List Categorie");
      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> _onLoadServiceDataJobM(
    LoadServiceDataJobM event,
    Emitter<JobPageStateM> emit,
  ) async {
    emit(state.copyWith(isLoading2: true));

    ApiClient apiClient = ApiClient();
    try {
      var nomGroupe = "Métiers";
      List<Service> listService = await apiClient.fetchServices(nomGroupe);
      emit(state.copyWith(listItems2: listService, isLoading2: false));
    } catch (error) {
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }

  // Gestion de l'estimation de prix IA
  Future<void> _onLoadPriceEstimationM(
      LoadPriceEstimationM event, Emitter<JobPageStateM> emit) async {
    final priceService = MockPriceEstimationService();
    emit(state.copyWith(isPriceLoading: true, priceError: ''));
    try {
      final estimation = await priceService.estimatePrice(
        serviceType: event.serviceType,
        location: event.location,
        additionalFactors: {'jobDescription': event.jobDescription},
      );
      emit(state.copyWith(
        priceEstimation: estimation,
        isPriceLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isPriceLoading: false,
        priceError: e.toString(),
      ));
    }
  }

  // ✅ NOUVEAU : Chargement réel des prestataires depuis le backend
  Future<void> _onLoadProviderMatchingM(
      LoadProviderMatchingM event, Emitter<JobPageStateM> emit) async {
    emit(state.copyWith(isMatchingLoading: true, matchError: ''));

    try {
      // 🚀 Charger les prestataires depuis le backend
      ApiClient apiClient = ApiClient();
      print("🚀 Chargement des prestataires depuis le backend...");

      final List<Map<String, dynamic>> prestatairesData =
          await apiClient.fetchPrestataires();

      // Convertir vers le modèle Prestataire
      List<Prestataire> providers =
          prestatairesData.map((data) => Prestataire.fromJson(data)).toList();

      print("✅ Prestataires chargés depuis le backend: ${providers.length}");

      // 🔍 Filtrer par type de service si spécifié
      if (event.serviceType.isNotEmpty) {
        providers = providers
            .where((p) =>
                (p.serviceName
                        ?.toLowerCase()
                        .contains(event.serviceType.toLowerCase()) ??
                    false) ||
                (p.competences?.any((s) => s
                        .toLowerCase()
                        .contains(event.serviceType.toLowerCase())) ??
                    false))
            .toList();

        print(
            "🎯 Prestataires filtrés pour '${event.serviceType}': ${providers.length}");
      }

      // 📍 Filtrer par localisation si spécifié
      if (event.location.isNotEmpty) {
        providers = providers
            .where((p) => (p.localisation
                    ?.toLowerCase()
                    .contains(event.location.toLowerCase()) ??
                false))
            .toList();

        print("📍 Prestataires dans '${event.location}': ${providers.length}");
      }

      // 🏆 Trier par note (vérifiés en premier, puis par note)
      providers.sort((a, b) {
        if (a.verifier && !b.verifier) return -1;
        if (!a.verifier && b.verifier) return 1;

        // Comparer par note
        double noteA = a.note ?? 0.0;
        double noteB = b.note ?? 0.0;
        return noteB.compareTo(noteA);
      });

      // 🎯 Limiter les résultats à 5 maximum
      if (providers.length > 5) {
        providers = providers.take(5).toList();
      }

      // ✅ Créer l'explication du matching
      final matchCriteria = [event.serviceType, event.location];
      if (event.preferences != null && event.preferences!.isNotEmpty) {
        matchCriteria.addAll(event.preferences!);
      }

      final providerScores = <String, double>{};
      final providerStrengths = <String, List<String>>{};

      // Générer des scores basés sur les critères réels
      for (final provider in providers) {
        final idKey = provider.id;
        double score = 0.0;
        List<String> strengths = [];

        // Points pour vérification
        if (provider.verifier) {
          score += 30;
          strengths.add("Profil vérifié");
        }

        // Points pour note
        if (provider.note != null && provider.note! > 4.0) {
          score += 25;
          strengths.add("Note élevée (${provider.note!.toStringAsFixed(1)})");
        } else if (provider.note != null && provider.note! > 3.0) {
          score += 15;
          strengths.add("Bonne note (${provider.note!.toStringAsFixed(1)})");
        }

        // Points pour compétences
        if (provider.competences != null && provider.competences!.isNotEmpty) {
          score += 20;
          strengths
              .add("Compétences: ${provider.competences!.take(2).join(', ')}");
        }

        // Points pour localisation
        if (provider.localisation != null &&
            provider.localisation!.isNotEmpty) {
          score += 15;
          strengths.add("Basé à ${provider.localisation}");
        }

        // Points pour description
        if (provider.description != null && provider.description!.isNotEmpty) {
          score += 10;
          strengths.add("Profil détaillé");
        }

        providerScores[idKey] = score;
        providerStrengths[idKey] = strengths;
      }

      final explanation = ProviderMatchExplanation(
        matchingCriteria: matchCriteria,
        providerScores: providerScores,
        providerStrengths: providerStrengths,
      );

      emit(state.copyWith(
        matchedProviders: providers,
        matchExplanation: explanation,
        isMatchingLoading: false,
      ));
    } catch (error) {
      print("❌ Erreur chargement prestataires: $error");

      // ⚠️ Fallback vers le service mock en cas d'erreur
      try {
        final matchingService = MockProviderMatchingService();
        final List<AIProviderRecommendation> recommendations =
            await matchingService.getRecommendedProviders(
          query: '${event.serviceType} ${event.preferences?.join(' ') ?? ''}'
              .trim(),
          location: event.location,
          maxResults: 5,
        );

        List<Prestataire> providers =
            recommendations.map((r) => r.prestataire).toList();

        // Créer l'explication du fallback mock
        final explanation = ProviderMatchExplanation(
          matchingCriteria: [event.serviceType, event.location],
          providerScores: {},
          providerStrengths: {},
        );

        emit(state.copyWith(
          matchedProviders: providers,
          matchExplanation: explanation,
          isMatchingLoading: false,
        ));

        print("🔄 Fallback vers données mock réussi");
      } catch (mockError) {
        print("💥 Erreur critique: $mockError");
        emit(state.copyWith(
          isMatchingLoading: false,
          matchError: error.toString(),
        ));
      }
    }
  }
}
