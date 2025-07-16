import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';

/// Interface pour le service de prédiction de la demande
abstract class DemandPredictionService {
  /// Prédit la demande future pour une catégorie dans une zone donnée
  /// 
  /// [categorie] - La catégorie de service
  /// [location] - La localisation à analyser
  /// [daysAhead] - Nombre de jours pour la prédiction (1-30)
  Future<AIDemandPrediction> predictDemand({
    required Categorie categorie,
    required String location,
    int daysAhead = 7,
  });
  
  /// Récupère les tendances actuelles et prévues pour plusieurs catégories dans une zone
  /// 
  /// [location] - La localisation à analyser
  /// [limit] - Nombre maximum de catégories à retourner
  Future<List<AIDemandPrediction>> getTopTrendingCategories({
    required String location,
    int limit = 5,
  });
  
  /// Génère des insights personnalisés pour un prestataire dans sa zone
  /// 
  /// [providerData] - Les données du prestataire
  /// [providerCategories] - Les catégories de services proposés par le prestataire
  /// [location] - La localisation du prestataire
  Future<List<String>> generateProviderInsights({
    required Map<String, dynamic> providerData,
    required List<Categorie> providerCategories,
    required String location,
  });
  
  /// Analyse les données historiques de demande pour une catégorie et location
  /// 
  /// [categorie] - La catégorie de service
  /// [location] - La localisation
  /// [periodInDays] - Période d'historique à analyser en jours
  Future<Map<String, dynamic>> getHistoricalDemandData({
    required Categorie categorie,
    required String location,
    int periodInDays = 90,
  });
}
