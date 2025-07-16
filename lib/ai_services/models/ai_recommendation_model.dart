import 'package:sdealsapp/web/data/models/prestataire.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';

/// Modèle représentant une recommandation de prestataire générée par l'IA
class AIProviderRecommendation {
  final Prestataire prestataire;
  final double matchScore; // Score de pertinence entre 0 et 1
  final String matchReason; // Explication du match pour l'utilisateur
  final Map<String, dynamic> matchDetails; // Détails supplémentaires pour le debug

  AIProviderRecommendation({
    required this.prestataire,
    required this.matchScore,
    required this.matchReason,
    this.matchDetails = const {},
  });
}

/// Modèle pour une estimation de prix générée par l'IA
class AIPriceEstimation {
  final String serviceType;
  final String location;
  final double minPrice; // Prix minimum estimé en FCFA
  final double maxPrice; // Prix maximum estimé en FCFA
  final List<String> factors; // Facteurs influençant le prix
  final Map<String, dynamic> priceDetails; // Détails du calcul pour debug

  AIPriceEstimation({
    required this.serviceType,
    required this.location,
    required this.minPrice,
    required this.maxPrice,
    this.factors = const [],
    this.priceDetails = const {},
  });

  String get formattedPriceRange => 
      '${minPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} - ${maxPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} FCFA';
}

/// Modèle pour les prédictions de demande par zone et catégorie
class AIDemandPrediction {
  final String location;
  final Categorie categorie;
  final DateTime period; // Période de prédiction
  final double demandScore; // Score de demande prédit (0-1)
  final String trend; // "hausse", "stable", "baisse"
  final String insight; // Explication ou conseil basé sur la prédiction
  
  AIDemandPrediction({
    required this.location,
    required this.categorie,
    required this.period,
    required this.demandScore,
    required this.trend,
    required this.insight,
  });
}

/// Modèle pour les messages de l'assistant IA
class AIAssistantMessage {
  final String text; // Texte du message
  final AIMessageType type; // Type de message
  final Map<String, dynamic>? actionData; // Données pour actions (ex: redirection)
  final List<AIAssistantSuggestion>? suggestions; // Suggestions de réponses
  
  AIAssistantMessage({
    required this.text,
    required this.type,
    this.actionData,
    this.suggestions,
  });
}

/// Suggestions rapides pour l'assistant
class AIAssistantSuggestion {
  final String text;
  final String actionType; // Type d'action (search, filter, etc.)
  final Map<String, dynamic>? actionData;
  
  AIAssistantSuggestion({
    required this.text,
    required this.actionType,
    this.actionData,
  });
}

/// Types de messages pour l'assistant IA
enum AIMessageType {
  text,          // Message texte simple
  suggestion,    // Suggestion d'action
  serviceRecommendation, // Recommandation de service
  priceEstimation,  // Estimation de prix
  error,         // Message d'erreur
}
