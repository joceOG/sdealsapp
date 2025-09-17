import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';

/// Interface pour l'assistant virtuel IA
abstract class AIAssistantService {
  /// Traite un message de l'utilisateur et génère une réponse appropriée
  /// 
  /// [userMessage] - Le message envoyé par l'utilisateur
  /// [conversationHistory] - L'historique de la conversation pour le contexte
  /// [userLocation] - La localisation de l'utilisateur pour des réponses contextuelles
  /// [language] - La langue préférée de l'utilisateur (fr, en, nouchi)
  Future<AIAssistantMessage> processUserMessage({
    required String userMessage,
    List<Map<String, String>> conversationHistory = const [],
    String? userLocation,
    String language = 'fr',
  });
  
  /// Suggère des actions ou questions pertinentes basées sur le contexte actuel
  /// 
  /// [currentScreen] - L'écran actuel de l'application
  /// [userContext] - Le contexte utilisateur (historique récent, préférences)
  /// [count] - Nombre de suggestions à générer
  Future<List<AIAssistantSuggestion>> generateContextualSuggestions({
    required String currentScreen,
    Map<String, dynamic> userContext = const {},
    int count = 3,
  });
  
  /// Traduit un message dans la langue préférée de l'utilisateur
  /// 
  /// [message] - Le message à traduire
  /// [targetLanguage] - La langue cible (fr, en, nouchi)
  Future<String> translateMessage({
    required String message,
    required String targetLanguage,
  });
  
  /// Extrait les intentions et entités d'un message utilisateur
  /// 
  /// [userMessage] - Le message de l'utilisateur à analyser
  /// Retourne une Map avec les intentions détectées et entités extraites
  Future<Map<String, dynamic>> extractIntentAndEntities(String userMessage);
}
