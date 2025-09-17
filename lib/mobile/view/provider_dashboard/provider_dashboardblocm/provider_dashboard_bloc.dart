import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/ai_services/interfaces/demand_prediction_service.dart';
import 'package:sdealsapp/ai_services/mock_implementations/mock_demand_prediction_service.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/provider_dashboardblocm/provider_dashboard_event.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/provider_dashboardblocm/provider_dashboard_state.dart';
import 'package:sdealsapp/data/models/categorie.dart';

import '../../../../data/models/groupe.dart';

class ProviderDashboardBloc extends Bloc<ProviderDashboardEvent, ProviderDashboardState> {
  final DemandPredictionService _demandService = MockDemandPredictionService();
  
  ProviderDashboardBloc() : super(ProviderDashboardInitialState()) {
    on<LoadDashboardDataEvent>(_onLoadDashboard);
    on<GetDemandPredictionEvent>(_onGetDemandPrediction);
    on<GetTopTrendingCategoriesEvent>(_onGetTopTrendingCategories);
    on<GetProviderInsightsEvent>(_onGetProviderInsights);
    on<GetHistoricalDataEvent>(_onGetHistoricalData);
  }

  void _onLoadDashboard(LoadDashboardDataEvent event, Emitter<ProviderDashboardState> emit) async {
    emit(ProviderDashboardLoadingState());
    
    try {
      // Simuler le chargement des données du prestataire
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Charger les données du prestataire (simulées pour l'instant)
      final providerData = {
        'name': 'Kouassi Services',
        'rating': 4.7,
        'completedJobs': 57,
        'memberSince': '2024-03-15',
      };
      
      // Catégories du prestataire (simulées)
      final providerCategories = [
        Categorie(
          idcategorie: '1',
          nomcategorie: 'Plomberie',
          imagecategorie: 'plumbing.png',
          groupe: Groupe(idgroupe: 'g1', nomgroupe: 'Habitat'),
        ),
        Categorie(
          idcategorie: '2',
          nomcategorie: 'Électricité',
          imagecategorie: 'electricity.png',
          groupe: Groupe(idgroupe: 'g1', nomgroupe: 'Habitat'),
        ),
      ];

      
      // Localisation par défaut
      const String location = 'Abidjan';
      
      emit(ProviderDashboardLoadedState(
        providerData: providerData,
        providerCategories: providerCategories,
        location: location,
      ));
    } catch (e) {
      emit(ProviderDashboardErrorState(message: 'Erreur lors du chargement des données: ${e.toString()}'));
    }
  }

  void _onGetDemandPrediction(GetDemandPredictionEvent event, Emitter<ProviderDashboardState> emit) async {
    if (state is ProviderDashboardLoadedState) {
      final currentState = state as ProviderDashboardLoadedState;
      
      emit(ProviderDashboardUpdatingState(
        providerData: currentState.providerData,
        providerCategories: currentState.providerCategories,
        location: currentState.location,
      ));
      
      try {
        final prediction = await _demandService.predictDemand(
          categorie: event.categorie,
          location: event.location,
          daysAhead: event.daysAhead,
        );
        
        emit(ProviderDashboardDemandPredictionLoadedState(
          providerData: currentState.providerData,
          providerCategories: currentState.providerCategories,
          location: currentState.location,
          prediction: prediction,
        ));
      } catch (e) {
        emit(ProviderDashboardErrorState(message: 'Erreur lors de la prédiction: ${e.toString()}'));
      }
    }
  }

  void _onGetTopTrendingCategories(GetTopTrendingCategoriesEvent event, Emitter<ProviderDashboardState> emit) async {
    if (state is ProviderDashboardLoadedState) {
      final currentState = state as ProviderDashboardLoadedState;
      
      emit(ProviderDashboardUpdatingState(
        providerData: currentState.providerData,
        providerCategories: currentState.providerCategories,
        location: currentState.location,
      ));
      
      try {
        final trendingCategories = await _demandService.getTopTrendingCategories(
          location: event.location,
          limit: event.limit,
        );
        
        emit(ProviderDashboardTrendsLoadedState(
          providerData: currentState.providerData,
          providerCategories: currentState.providerCategories,
          location: currentState.location,
          trendingCategories: trendingCategories,
        ));
      } catch (e) {
        emit(ProviderDashboardErrorState(message: 'Erreur lors du chargement des tendances: ${e.toString()}'));
      }
    }
  }

  void _onGetProviderInsights(GetProviderInsightsEvent event, Emitter<ProviderDashboardState> emit) async {
    if (state is ProviderDashboardLoadedState) {
      final currentState = state as ProviderDashboardLoadedState;
      
      emit(ProviderDashboardUpdatingState(
        providerData: currentState.providerData,
        providerCategories: currentState.providerCategories,
        location: currentState.location,
      ));
      
      try {
        final insights = await _demandService.generateProviderInsights(
          providerData: currentState.providerData,
          providerCategories: currentState.providerCategories,
          location: currentState.location,
        );
        
        emit(ProviderDashboardInsightsLoadedState(
          providerData: currentState.providerData,
          providerCategories: currentState.providerCategories,
          location: currentState.location,
          insights: insights,
        ));
      } catch (e) {
        emit(ProviderDashboardErrorState(message: 'Erreur lors du chargement des insights: ${e.toString()}'));
      }
    }
  }

  void _onGetHistoricalData(GetHistoricalDataEvent event, Emitter<ProviderDashboardState> emit) async {
    if (state is ProviderDashboardLoadedState) {
      final currentState = state as ProviderDashboardLoadedState;
      
      emit(ProviderDashboardUpdatingState(
        providerData: currentState.providerData,
        providerCategories: currentState.providerCategories,
        location: currentState.location,
      ));
      
      try {
        final historicalData = await _demandService.getHistoricalDemandData(
          categorie: event.categorie,
          location: event.location,
          periodInDays: event.periodInDays,
        );
        
        emit(ProviderDashboardHistoricalDataLoadedState(
          providerData: currentState.providerData,
          providerCategories: currentState.providerCategories,
          location: currentState.location,
          historicalData: historicalData,
          categorie: event.categorie,
        ));
      } catch (e) {
        emit(ProviderDashboardErrorState(message: 'Erreur lors du chargement des données historiques: ${e.toString()}'));
      }
    }
  }
}
