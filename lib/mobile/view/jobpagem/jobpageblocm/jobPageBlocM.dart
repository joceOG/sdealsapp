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

  JobPageBlocM() : super( JobPageStateM.initial()) {
    on<LoadCategorieDataJobM>(_onLoadCategorieDataJobM);
    on<LoadServiceDataJobM>(_onLoadServiceDataJobM);
    on<LoadPriceEstimationM>(_onLoadPriceEstimationM);
    on<LoadProviderMatchingM>(_onLoadProviderMatchingM);
  }

  Future<void> _onLoadCategorieDataJobM(LoadCategorieDataJobM event,
      Emitter<JobPageStateM> emit,) async {
    // String nomgroupe = "Metiers";
    // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading: true));

    ApiClient apiClient = ApiClient();
    print("Try");
    try {
      var nomgroupe = "Métiers" ;
      List<Categorie> list_categorie = await apiClient.fetchCategorie(nomgroupe);
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

  // Gestion du matching de prestataires IA
  Future<void> _onLoadProviderMatchingM(
      LoadProviderMatchingM event, Emitter<JobPageStateM> emit) async {
    final matchingService = MockProviderMatchingService();
    emit(state.copyWith(isMatchingLoading: true, matchError: ''));
    try {
      final List<AIProviderRecommendation> recommendations = await matchingService.getRecommendedProviders(
        query: '${event.serviceType} ${event.preferences?.join(' ') ?? ''}'.trim(),
        location: event.location,
        maxResults: 5,
      );

      List<Prestataire> providers = recommendations.map((r) => r.prestataire).toList();
      ProviderMatchExplanation explanation = ProviderMatchExplanation();
      emit(state.copyWith(
        matchedProviders: providers,
        matchExplanation: explanation,
        isMatchingLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isMatchingLoading: false,
        matchError: e.toString(),
      ));
    }
  }

}