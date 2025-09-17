import 'dart:math';

import 'package:sdealsapp/ai_services/interfaces/ai_assistant_service.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';

/// Implémentation mock du service d'assistant virtuel IA
/// Cette classe simule le comportement d'un chatbot intelligent adapté au contexte africain
class MockAIAssistantService implements AIAssistantService {
  // Générateur de nombres aléatoires
  final Random _random = Random();
  
  // Langues supportées
  final List<String> _supportedLanguages = ['fr', 'en', 'nouchi'];
  
  // Dictionnaire d'intentions
  final Map<String, List<String>> _intentPatterns = {
    'trouver_service': [
      'trouver', 'chercher', 'rechercher', 'où', 'besoin de', 'comment trouver',
      'où est-ce que', 'je cherche', 'looking for', 'find', 'search',
    ],
    'demander_prix': [
      'prix', 'coût', 'tarif', 'combien', 'cher', 'budget',
      'price', 'cost', 'how much', 'expensive',
    ],
    'prendre_rdv': [
      'rendez-vous', 'rdv', 'réserver', 'programmer', 'quand', 'disponible',
      'appointment', 'book', 'schedule', 'when', 'available',
    ],
    'demander_info': [
      'comment', 'info', 'expliquer', 'qu\'est-ce que', 'what is', 'how to',
      'information', 'à propos', 'about',
    ],
    'salutation': [
      'bonjour', 'salut', 'hello', 'hi', 'hey', 'bonsoir', 'good',
    ],
    'remercier': [
      'merci', 'thanks', 'thank you', 'appreciation', 'remercie',
    ],
    'se_plaindre': [
      'problème', 'plainte', 'mauvais', 'pas content', 'insatisfait',
      'problem', 'complaint', 'bad', 'not happy', 'unsatisfied',
    ],
  };
  
  // Données des services et catégories (simplifiées)
  final List<Map<String, dynamic>> _mockServiceCategories = [
    {'id': 'cat1', 'nom': 'Plomberie', 'services': ['Réparation fuite', 'Installation sanitaire', 'Débouchage']},
    {'id': 'cat2', 'nom': 'Électricité', 'services': ['Installation', 'Dépannage', 'Mise aux normes']},
    {'id': 'cat3', 'nom': 'Mécanique', 'services': ['Réparation', 'Vidange', 'Diagnostic']},
    {'id': 'cat4', 'nom': 'Beauté', 'services': ['Coiffure', 'Maquillage', 'Onglerie']},
    {'id': 'cat5', 'nom': 'Informatique', 'services': ['Dépannage PC', 'Installation logiciel', 'Récupération données']},
    {'id': 'cat6', 'nom': 'Transport', 'services': ['Livraison', 'Déménagement', 'Course']},
    {'id': 'cat7', 'nom': 'Ménage', 'services': ['Nettoyage maison', 'Repassage', 'Garde d\'enfants']},
    {'id': 'cat8', 'nom': 'Jardinage', 'services': ['Tonte pelouse', 'Taille haie', 'Aménagement jardin']},
  ];
  
  // Données de quartiers (simplifiées)
  final List<Map<String, dynamic>> _mockLocations = [
    {'nom': 'Yopougon', 'alias': ['Yop', 'Yopou', 'Yopougon Academie']},
    {'nom': 'Cocody', 'alias': ['Coco', 'Riviera', 'Angré']},
    {'nom': 'Abobo', 'alias': ['Abo', 'Abobo Gare', 'Abobo Baoulé']},
    {'nom': 'Treichville', 'alias': ['Treich', 'Zone 3']},
    {'nom': 'Plateau', 'alias': ['Centre-ville', 'Centre d\'affaires']},
    {'nom': 'Marcory', 'alias': ['Marco', 'Zone 4', 'Biétry']},
    {'nom': 'Koumassi', 'alias': ['Koum']},
    {'nom': 'Port-Bouët', 'alias': ['PB', 'Port']},
    {'nom': 'Adjamé', 'alias': ['Adj', '220 Logements']},
    {'nom': 'Attécoubé', 'alias': ['Atté', 'Locodjro']},
  ];
  
  // Réponses prédéfinies par intention et par langue
  final Map<String, Map<String, List<String>>> _responses = {
    'fr': {
      'trouver_service': [
        'Pour trouver un {service}, vous pouvez utiliser la fonction de recherche en haut de l\'écran.',
        'Nous avons plusieurs prestataires de {service} disponibles dans votre zone.',
        'Vous cherchez un {service}? Je peux vous aider à en trouver un proche de chez vous.',
        'Pour un {service} de qualité, je vous recommande d\'utiliser les filtres pour affiner votre recherche.',
      ],
      'demander_prix': [
        'Le prix pour {service} varie généralement entre {min_price} et {max_price} FCFA dans votre zone.',
        'Pour un {service} à {location}, comptez environ {avg_price} FCFA en moyenne.',
        'Les tarifs pour {service} peuvent varier selon le prestataire, mais la moyenne est de {avg_price} FCFA.',
        'Un {service} coûte habituellement entre {min_price} et {max_price} FCFA, selon la complexité.',
      ],
      'prendre_rdv': [
        'Pour prendre rendez-vous, sélectionnez un prestataire puis cliquez sur "Contacter" ou "Réserver".',
        'Vous pouvez programmer un rendez-vous en contactant directement le prestataire via l\'application.',
        'La prise de rendez-vous se fait en quelques clics: choisissez votre prestataire, puis "Réserver".',
        'Pour un rendez-vous, trouvez d\'abord un prestataire disponible et utilisez le bouton "Contacter".',
      ],
      'demander_info': [
        'Voici comment fonctionne {subject}: {explanation}',
        'Sur {subject}, voici ce que vous devez savoir: {explanation}',
        'Je peux vous donner plus d\'informations sur {subject}: {explanation}',
        '{subject} est {explanation}',
      ],
      'salutation': [
        'Bonjour! Comment puis-je vous aider aujourd\'hui?',
        'Salut! Que puis-je faire pour vous?',
        'Bonjour! Je suis votre assistant Soutrali. Que recherchez-vous?',
        'Bienvenue sur Soutrali Deals! Comment puis-je vous être utile?',
      ],
      'remercier': [
        'De rien! C\'est toujours un plaisir de vous aider.',
        'Avec plaisir! N\'hésitez pas si vous avez d\'autres questions.',
        'Je vous en prie! Avez-vous besoin d\'autre chose?',
        'C\'est mon travail de vous aider. Passez une excellente journée!',
      ],
      'se_plaindre': [
        'Je suis désolé pour ce problème. Pouvez-vous me donner plus de détails pour que nous puissions le résoudre?',
        'Toutes nos excuses pour ce désagrément. Nous allons faire le nécessaire pour résoudre ce problème rapidement.',
        'Nous prenons votre plainte très au sérieux. Un membre de notre équipe va s\'en occuper immédiatement.',
        'Merci de nous signaler ce problème. Nous allons travailler à l\'améliorer sans délai.',
      ],
      'default': [
        'Je ne suis pas sûr de comprendre votre demande. Pouvez-vous préciser?',
        'Pourriez-vous reformuler votre question?',
        'Je n\'ai pas saisi votre demande. Comment puis-je vous aider exactement?',
        'Désolé, je n\'ai pas compris. Pouvez-vous dire cela différemment?',
      ],
    },
    'en': {
      'trouver_service': [
        'To find a {service}, you can use the search function at the top of the screen.',
        'We have several {service} providers available in your area.',
        'Looking for a {service}? I can help you find one near you.',
        'For quality {service}, I recommend using filters to refine your search.',
      ],
      'demander_prix': [
        'The price for {service} typically ranges between {min_price} and {max_price} FCFA in your area.',
        'For a {service} in {location}, expect to pay around {avg_price} FCFA on average.',
        'Rates for {service} may vary by provider, but the average is {avg_price} FCFA.',
        'A {service} usually costs between {min_price} and {max_price} FCFA, depending on complexity.',
      ],
      // Autres intentions en anglais...
    },
    'nouchi': {
      'trouver_service': [
        'Pour trouver un {service}, faut check en haut de l\'écran où y a la recherche là.',
        'On a plein de gars qui font {service} dans ton coin.',
        'Tu cherches {service}? Je vais te montrer les meilleurs dans ton quartier!',
        'Pour un bon {service} qui est pas bidon, utilise les filtres pour bien choisir.',
      ],
      'demander_prix': [
        'Pour le {service} là, ça peut coûter entre {min_price} et {max_price} FCFA dans ton coin.',
        'Dans {location}, un {service} c\'est autour de {avg_price} FCFA quoi.',
        'Le {service}, chacun a son prix, mais en moyenne c\'est {avg_price} FCFA.',
        'Pour faire {service}, prévoir entre {min_price} et {max_price} FCFA, ça dépend du travail.',
      ],
      // Autres intentions en nouchi...
    },
  };
  
  // Explications pour les demandes d'information
  final Map<String, String> _explanations = {
    'application': 'Soutrali Deals est une plateforme qui connecte les clients avec des prestataires de services locaux.',
    'paiement': 'Vous pouvez payer directement via l\'application avec Mobile Money, carte bancaire, ou en espèces à la livraison.',
    'inscription': 'Pour vous inscrire comme prestataire, cliquez sur "Devenir prestataire" et suivez les étapes indiquées.',
    'annulation': 'Pour annuler une commande, allez dans "Mes commandes", sélectionnez la commande et cliquez sur "Annuler".',
    'note': 'Vous pouvez noter les prestataires de 1 à 5 étoiles et laisser un commentaire après chaque service.',
    'litige': 'En cas de litige, contactez notre service client via "Aide et support" dans votre profil.',
  };
  
  // Suggestions rapides par écran
  final Map<String, List<AIAssistantSuggestion>> _screenSuggestions = {
    'home': [
      AIAssistantSuggestion(
        text: 'Comment trouver un plombier?',
        actionType: 'search',
        actionData: {'category': 'Plomberie'},
      ),
      AIAssistantSuggestion(
        text: 'Tarifs moyens électricien',
        actionType: 'price_estimate',
        actionData: {'service': 'Électricité'},
      ),
      AIAssistantSuggestion(
        text: 'Devenir prestataire',
        actionType: 'navigate',
        actionData: {'screen': 'provider_registration'},
      ),
    ],
    'search_results': [
      AIAssistantSuggestion(
        text: 'Filtrer par avis',
        actionType: 'filter',
        actionData: {'filter': 'rating', 'min': 4},
      ),
      AIAssistantSuggestion(
        text: 'Trier par prix',
        actionType: 'sort',
        actionData: {'sort': 'price', 'order': 'asc'},
      ),
      AIAssistantSuggestion(
        text: 'Uniquement disponibles aujourd\'hui',
        actionType: 'filter',
        actionData: {'filter': 'availability', 'value': 'today'},
      ),
    ],
    'provider_profile': [
      AIAssistantSuggestion(
        text: 'Voir les avis',
        actionType: 'navigate',
        actionData: {'section': 'reviews'},
      ),
      AIAssistantSuggestion(
        text: 'Contacter',
        actionType: 'contact',
        actionData: {},
      ),
      AIAssistantSuggestion(
        text: 'Services similaires',
        actionType: 'search',
        actionData: {'similar': true},
      ),
    ],
    'default': [
      AIAssistantSuggestion(
        text: 'Comment ça marche?',
        actionType: 'help',
        actionData: {'topic': 'general'},
      ),
      AIAssistantSuggestion(
        text: 'Trouver un service',
        actionType: 'navigate',
        actionData: {'screen': 'search'},
      ),
      AIAssistantSuggestion(
        text: 'Contactez le support',
        actionType: 'contact_support',
        actionData: {},
      ),
    ],
  };
  
  @override
  Future<AIAssistantMessage> processUserMessage({
    required String userMessage,
    List<Map<String, String>> conversationHistory = const [],
    String? userLocation,
    String language = 'fr',
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 700));
    
    // Normaliser la langue
    String normalizedLanguage = _normalizeLanguage(language);
    
    // Extraire l'intention et les entités
    final intentAndEntities = await extractIntentAndEntities(userMessage);
    final intent = intentAndEntities['intent'] as String;
    final entities = intentAndEntities['entities'] as Map<String, dynamic>;
    
    // Générer une réponse appropriée
    String responseText = _generateResponse(
      intent,
      entities,
      normalizedLanguage,
      userLocation,
    );
    
    // Si nécessaire, traduire la réponse dans la langue demandée
    if (normalizedLanguage != 'fr') {
      responseText = await translateMessage(
        message: responseText,
        targetLanguage: normalizedLanguage,
      );
    }
    
    // Déterminer le type de message
    AIMessageType messageType = AIMessageType.text;
    Map<String, dynamic>? actionData;
    List<AIAssistantSuggestion>? suggestions;
    
    // Ajouter des suggestions contextuelles selon l'intention
    if (intent == 'trouver_service') {
      messageType = AIMessageType.serviceRecommendation;
      actionData = {
        'service': entities['service'] ?? '',
        'location': entities['location'] ?? userLocation ?? '',
      };
      
      // Ajouter des suggestions de services spécifiques
      if (entities['service'] != null) {
        final serviceCategory = entities['service'].toString();
        suggestions = _getServiceSuggestions(serviceCategory);
      }
    } else if (intent == 'demander_prix') {
      messageType = AIMessageType.priceEstimation;
      actionData = {
        'service': entities['service'] ?? '',
        'location': entities['location'] ?? userLocation ?? '',
      };
    } else if (intent == 'salutation') {
      suggestions = _getGenericSuggestions();
    }
    
    return AIAssistantMessage(
      text: responseText,
      type: messageType,
      actionData: actionData,
      suggestions: suggestions,
    );
  }
  
  @override
  Future<List<AIAssistantSuggestion>> generateContextualSuggestions({
    required String currentScreen,
    Map<String, dynamic> userContext = const {},
    int count = 3,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Récupérer les suggestions par écran
    List<AIAssistantSuggestion> availableSuggestions = [];
    
    if (_screenSuggestions.containsKey(currentScreen)) {
      availableSuggestions = _screenSuggestions[currentScreen]!;
    } else {
      availableSuggestions = _screenSuggestions['default']!;
    }
    
    // Adaptation contextuelle des suggestions
    if (userContext.containsKey('lastSearchedService')) {
      final lastService = userContext['lastSearchedService'] as String;
      
      // Ajouter des suggestions liées au dernier service recherché
      availableSuggestions.add(
        AIAssistantSuggestion(
          text: 'Prix moyen pour $lastService',
          actionType: 'price_estimate',
          actionData: {'service': lastService},
        ),
      );
      
      availableSuggestions.add(
        AIAssistantSuggestion(
          text: 'Meilleurs prestataires en $lastService',
          actionType: 'search',
          actionData: {'service': lastService, 'sort': 'rating'},
        ),
      );
    }
    
    if (userContext.containsKey('location')) {
      final userLocation = userContext['location'] as String;
      
      // Ajouter des suggestions liées à la localisation
      availableSuggestions.add(
        AIAssistantSuggestion(
          text: 'Services populaires à $userLocation',
          actionType: 'popular_services',
          actionData: {'location': userLocation},
        ),
      );
    }
    
    // Mélanger et limiter le nombre de suggestions
    availableSuggestions.shuffle(_random);
    return availableSuggestions.take(count).toList();
  }
  
  @override
  Future<String> translateMessage({
    required String message,
    required String targetLanguage,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Normaliser la langue
    String normalizedLanguage = _normalizeLanguage(targetLanguage);
    
    // Pour cette version mock, nous allons simplement ajouter un préfixe
    // Dans une vraie implémentation, on utiliserait un service de traduction
    if (normalizedLanguage == 'fr') {
      return message; // Déjà en français
    } else if (normalizedLanguage == 'en') {
      // Simuler une traduction en anglais avec des modifications basiques
      // Remplacer quelques mots clés pour simuler
      String translated = message
          .replaceAll('Bonjour', 'Hello')
          .replaceAll('Salut', 'Hi')
          .replaceAll('Merci', 'Thank you')
          .replaceAll('s\'il vous plaît', 'please')
          .replaceAll('prestataire', 'provider')
          .replaceAll('service', 'service')
          .replaceAll('prix', 'price')
          .replaceAll('recherche', 'search');
          
      return '[EN] $translated';
    } else if (normalizedLanguage == 'nouchi') {
      // Simuler une traduction en nouchi avec des modifications basiques
      String translated = message
          .replaceAll('Bonjour', 'Coucou')
          .replaceAll('Salut', 'Yoh')
          .replaceAll('s\'il vous plaît', 'stp')
          .replaceAll('Merci', 'Merci hein')
          .replaceAll('prestataire', 'gars-là')
          .replaceAll('chercher', 'cheka');
          
      return '[NOUCHI] $translated';
    }
    
    // Langue non supportée
    return message;
  }
  
  @override
  Future<Map<String, dynamic>> extractIntentAndEntities(String userMessage) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 400));
    
    final message = userMessage.toLowerCase();
    
    // Identifier l'intention principale
    String primaryIntent = 'default';
    double highestScore = 0.0;
    
    _intentPatterns.forEach((intent, patterns) {
      for (var pattern in patterns) {
        if (message.contains(pattern.toLowerCase())) {
          // Calculer un score basique de confiance
          double score = pattern.length / message.length;
          if (score > highestScore) {
            highestScore = score;
            primaryIntent = intent;
          }
        }
      }
    });
    
    // Extraire les entités (service, localisation, etc.)
    Map<String, dynamic> entities = {};
    
    // Extraire les services mentionnés
    for (var category in _mockServiceCategories) {
      final categoryName = category['nom'] as String;
      if (message.contains(categoryName.toLowerCase())) {
        entities['service'] = categoryName;
        break;
      }
      
      // Vérifier les services spécifiques
      for (var service in category['services'] as List<dynamic>) {
        if (message.contains(service.toString().toLowerCase())) {
          entities['service'] = categoryName;
          entities['specific_service'] = service;
          break;
        }
      }
      
      if (entities.containsKey('service')) break;
    }
    
    // Extraire les localisations mentionnées
    for (var location in _mockLocations) {
      final locationName = location['nom'] as String;
      if (message.contains(locationName.toLowerCase())) {
        entities['location'] = locationName;
        break;
      }
      
      // Vérifier les alias
      for (var alias in location['alias'] as List<dynamic>) {
        if (message.contains(alias.toString().toLowerCase())) {
          entities['location'] = locationName;
          break;
        }
      }
      
      if (entities.containsKey('location')) break;
    }
    
    // Détecter si c'est une urgence
    if (message.contains('urgent') || 
        message.contains('urgence') || 
        message.contains('immédiat') ||
        message.contains('vite')) {
      entities['urgent'] = true;
    }
    
    // Détecter des préférences de prix
    if (message.contains('pas cher') || 
        message.contains('économique') || 
        message.contains('abordable')) {
      entities['price_preference'] = 'low';
    } else if (message.contains('luxe') || 
               message.contains('premium') || 
               message.contains('meilleur')) {
      entities['price_preference'] = 'high';
    }
    
    return {
      'intent': primaryIntent,
      'confidence': highestScore,
      'entities': entities,
      'original_message': userMessage,
    };
  }
  
  // Méthodes auxiliaires privées
  
  String _normalizeLanguage(String language) {
    final lang = language.toLowerCase();
    
    // Utilisation du champ _supportedLanguages
    if (lang.contains('fr') || lang.contains('français') || lang.contains('francais')) {
      return _supportedLanguages[0]; // français
    } else if (lang.contains('en') || lang.contains('english') || lang.contains('anglais')) {
      return _supportedLanguages[1]; // anglais
    } else if (lang.contains('nouchi') || lang.contains('ivoirien')) {
      return _supportedLanguages[2]; // nouchi
    }
    
    // Par défaut, utiliser le français
    return _supportedLanguages[0];
  }
  
  String _generateResponse(
    String intent,
    Map<String, dynamic> entities,
    String language,
    String? userLocation,
  ) {
    // Récupérer les réponses disponibles pour cette intention et langue
    final languageResponses = _responses[language] ?? _responses['fr']!;
    final intentResponses = languageResponses[intent] ?? languageResponses['default']!;
    
    // Sélectionner une réponse aléatoire
    final responseTemplate = intentResponses[_random.nextInt(intentResponses.length)];
    
    // Remplacer les variables dans le template
    String response = responseTemplate;
    
    if (entities.containsKey('service')) {
      response = response.replaceAll('{service}', entities['service'] as String);
    }
    
    if (entities.containsKey('location')) {
      response = response.replaceAll('{location}', entities['location'] as String);
    } else if (userLocation != null) {
      response = response.replaceAll('{location}', userLocation);
    }
    
    if (intent == 'demander_prix' && entities.containsKey('service')) {
      // Générer des prix fictifs
      final minPrice = 5000 + _random.nextInt(10000);
      final maxPrice = minPrice + 5000 + _random.nextInt(15000);
      final avgPrice = (minPrice + maxPrice) ~/ 2;
      
      response = response
          .replaceAll('{min_price}', _formatPrice(minPrice))
          .replaceAll('{max_price}', _formatPrice(maxPrice))
          .replaceAll('{avg_price}', _formatPrice(avgPrice));
    }
    
    if (intent == 'demander_info' && entities.containsKey('subject')) {
      final subject = entities['subject'] as String;
      String explanation = _explanations[subject] ?? 
          'une fonctionnalité de notre application. Pour plus de détails, consultez notre guide utilisateur.';
      
      response = response
          .replaceAll('{subject}', subject)
          .replaceAll('{explanation}', explanation);
    }
    
    return response;
  }
  
  List<AIAssistantSuggestion> _getServiceSuggestions(String serviceCategory) {
    // Trouver la catégorie de service
    Map<String, dynamic>? category;
    for (var cat in _mockServiceCategories) {
      if (cat['nom'].toString().toLowerCase() == serviceCategory.toLowerCase()) {
        category = cat;
        break;
      }
    }
    
    if (category == null) return _getGenericSuggestions();
    
    // Créer des suggestions basées sur les services spécifiques
    List<AIAssistantSuggestion> suggestions = [];
    final services = category['services'] as List<dynamic>;
    
    for (var service in services) {
      suggestions.add(
        AIAssistantSuggestion(
          text: service.toString(),
          actionType: 'search',
          actionData: {
            'category': category['nom'],
            'service': service,
          },
        ),
      );
    }
    
    // Ajouter une suggestion de prix
    suggestions.add(
      AIAssistantSuggestion(
        text: 'Prix moyens ${category['nom']}',
        actionType: 'price_estimate',
        actionData: {'service': category['nom']},
      ),
    );
    
    return suggestions;
  }
  
  List<AIAssistantSuggestion> _getGenericSuggestions() {
    return [
      AIAssistantSuggestion(
        text: 'Trouver un service près de chez moi',
        actionType: 'search_nearby',
        actionData: {},
      ),
      AIAssistantSuggestion(
        text: 'Comment ça marche?',
        actionType: 'help',
        actionData: {'topic': 'general'},
      ),
      AIAssistantSuggestion(
        text: 'Services populaires',
        actionType: 'popular_services',
        actionData: {},
      ),
    ];
  }
  
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => '.',
    );
  }
}
