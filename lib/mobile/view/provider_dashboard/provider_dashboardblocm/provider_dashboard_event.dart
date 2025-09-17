import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';

abstract class ProviderDashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Événement pour charger les données initiales du dashboard
class LoadDashboardDataEvent extends ProviderDashboardEvent {}

// Événement pour obtenir une prédiction de demande
class GetDemandPredictionEvent extends ProviderDashboardEvent {
  final Categorie categorie;
  final String location;
  final int daysAhead;
  
  GetDemandPredictionEvent({
    required this.categorie,
    required this.location,
    this.daysAhead = 7,
  });
  
  @override
  List<Object> get props => [categorie, location, daysAhead];
}

// Événement pour obtenir les catégories les plus tendance
class GetTopTrendingCategoriesEvent extends ProviderDashboardEvent {
  final String location;
  final int limit;
  
  GetTopTrendingCategoriesEvent({
    required this.location,
    this.limit = 5,
  });
  
  @override
  List<Object> get props => [location, limit];
}

// Événement pour obtenir des insights pour un prestataire
class GetProviderInsightsEvent extends ProviderDashboardEvent {}

// Événement pour obtenir des données historiques
class GetHistoricalDataEvent extends ProviderDashboardEvent {
  final Categorie categorie;
  final String location;
  final int periodInDays;
  
  GetHistoricalDataEvent({
    required this.categorie,
    required this.location,
    this.periodInDays = 90,
  });
  
  @override
  List<Object> get props => [categorie, location, periodInDays];
}
