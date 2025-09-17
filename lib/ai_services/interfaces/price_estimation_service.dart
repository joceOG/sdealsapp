import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';

/// Interface pour le service d'estimation de prix intelligent
abstract class PriceEstimationService {
  /// Génère une estimation de prix pour un service spécifique dans une zone donnée
  /// 
  /// [serviceType] - Le type de service demandé
  /// [location] - La localisation où le service sera effectué
  /// [additionalFactors] - Facteurs supplémentaires pouvant influencer le prix (urgence, heure, etc.)
  Future<AIPriceEstimation> estimatePrice({
    required String serviceType,
    required String location,
    Map<String, dynamic> additionalFactors = const {},
  });
  
  /// Récupère les données historiques de prix pour un service dans une zone
  /// 
  /// [serviceType] - Le type de service
  /// [location] - La localisation
  /// [periodInDays] - La période d'historique à considérer en jours
  Future<List<Map<String, dynamic>>> getHistoricalPriceData({
    required String serviceType,
    required String location,
    int periodInDays = 90,
  });
  
  /// Analyse les facteurs qui influencent le prix d'un service
  /// 
  /// [serviceType] - Le type de service
  /// [location] - La localisation
  /// Retourne une liste des facteurs avec leur impact sur le prix
  Future<List<Map<String, dynamic>>> analyzePriceFactors({
    required String serviceType,
    required String location,
  });
}
