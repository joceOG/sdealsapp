import 'package:equatable/equatable.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';

abstract class ProviderDashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

// État initial
class ProviderDashboardInitialState extends ProviderDashboardState {}

// État de chargement
class ProviderDashboardLoadingState extends ProviderDashboardState {}

// État de mise à jour en cours
class ProviderDashboardUpdatingState extends ProviderDashboardState {
  final Map<String, dynamic> providerData;
  final List<Categorie> providerCategories;
  final String location;
  
  ProviderDashboardUpdatingState({
    required this.providerData,
    required this.providerCategories,
    required this.location,
  });
  
  @override
  List<Object?> get props => [providerData, providerCategories, location];
}

// État de base une fois chargé
class ProviderDashboardLoadedState extends ProviderDashboardState {
  final Map<String, dynamic> providerData;
  final List<Categorie> providerCategories;
  final String location;
  
  ProviderDashboardLoadedState({
    required this.providerData,
    required this.providerCategories,
    required this.location,
  });
  
  @override
  List<Object?> get props => [providerData, providerCategories, location];
}

// État avec prédiction de demande chargée
class ProviderDashboardDemandPredictionLoadedState extends ProviderDashboardLoadedState {
  final AIDemandPrediction prediction;
  
  ProviderDashboardDemandPredictionLoadedState({
    required Map<String, dynamic> providerData,
    required List<Categorie> providerCategories,
    required String location,
    required this.prediction,
  }) : super(
    providerData: providerData,
    providerCategories: providerCategories,
    location: location,
  );
  
  @override
  List<Object?> get props => [providerData, providerCategories, location, prediction];
}

// État avec tendances chargées
class ProviderDashboardTrendsLoadedState extends ProviderDashboardLoadedState {
  final List<AIDemandPrediction> trendingCategories;
  
  ProviderDashboardTrendsLoadedState({
    required Map<String, dynamic> providerData,
    required List<Categorie> providerCategories,
    required String location,
    required this.trendingCategories,
  }) : super(
    providerData: providerData,
    providerCategories: providerCategories,
    location: location,
  );
  
  @override
  List<Object?> get props => [providerData, providerCategories, location, trendingCategories];
}

// État avec insights chargés
class ProviderDashboardInsightsLoadedState extends ProviderDashboardLoadedState {
  final List<String> insights;
  
  ProviderDashboardInsightsLoadedState({
    required Map<String, dynamic> providerData,
    required List<Categorie> providerCategories,
    required String location,
    required this.insights,
  }) : super(
    providerData: providerData,
    providerCategories: providerCategories,
    location: location,
  );
  
  @override
  List<Object?> get props => [providerData, providerCategories, location, insights];
}

// État avec données historiques chargées
class ProviderDashboardHistoricalDataLoadedState extends ProviderDashboardLoadedState {
  final Map<String, dynamic> historicalData;
  final Categorie categorie;
  
  ProviderDashboardHistoricalDataLoadedState({
    required Map<String, dynamic> providerData,
    required List<Categorie> providerCategories,
    required String location,
    required this.historicalData,
    required this.categorie,
  }) : super(
    providerData: providerData,
    providerCategories: providerCategories,
    location: location,
  );
  
  @override
  List<Object?> get props => [providerData, providerCategories, location, historicalData, categorie];
}

// État d'erreur
class ProviderDashboardErrorState extends ProviderDashboardState {
  final String message;
  
  ProviderDashboardErrorState({required this.message});
  
  @override
  List<Object> get props => [message];
}
