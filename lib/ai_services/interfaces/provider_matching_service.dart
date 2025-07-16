import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';

/// Interface pour le service de matching intelligent entre clients et prestataires
abstract class ProviderMatchingService {
  /// Récupère des prestataires recommandés en fonction d'une requête textuelle et d'autres paramètres
  /// 
  /// [query] - La recherche textuelle de l'utilisateur (ex: "plombier urgence")
  /// [location] - La localisation de l'utilisateur (ex: "Yopougon, Abidjan")
  /// [maxResults] - Le nombre maximum de résultats à retourner
  /// [filterImmediatelyAvailable] - Si vrai, filtre uniquement les prestataires immédiatement disponibles
  Future<List<AIProviderRecommendation>> getRecommendedProviders({
    required String query,
    required String location,
    int maxResults = 5,
    bool filterImmediatelyAvailable = false,
  });
  
  /// Analyse une requête utilisateur et extrait des entités structurées pour faciliter la recherche
  /// 
  /// [query] - La recherche textuelle de l'utilisateur
  /// Retourne une Map avec les entités extraites (service, urgence, durée, etc.)
  Future<Map<String, dynamic>> analyzeUserQuery(String query);
  
  /// Détermine si un prestataire correspond bien à une requête spécifique
  /// 
  /// [providerData] - Les données du prestataire
  /// [queryEntities] - Les entités extraites de la requête utilisateur
  /// Retourne un score de matching entre 0 et 1
  Future<double> calculateMatchScore(
    Map<String, dynamic> providerData, 
    Map<String, dynamic> queryEntities
  );
}
