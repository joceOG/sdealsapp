import 'dart:math';

import 'package:sdealsapp/ai_services/interfaces/provider_matching_service.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/web/data/models/prestataire.dart';

/// Implémentation mock du service de matching des prestataires
/// Cette classe simule le comportement d'un service de matching IA avec des données préfabriquées
class MockProviderMatchingService implements ProviderMatchingService {
  // Données mock de prestataires
  final List<Map<String, dynamic>> _mockPrestataires = [
    {
      'id': 'pres-001',
      'nom': 'Kouassi Konan',
      'profession': 'Plombier',
      'categories': ['Plomberie', 'Sanitaire'],
      'tags': ['urgence', 'réparation', 'installation', 'tuyauterie'],
      'disponible': true,
      'zone': 'Yopougon',
      'note': 4.8,
      'experience': 5,
      'bio': 'Plombier professionnel avec 5 ans d\'expérience dans les réparations d\'urgence',
    },
    {
      'id': 'pres-002',
      'nom': 'Aminata Diallo',
      'profession': 'Électricienne',
      'categories': ['Électricité', 'Domotique'],
      'tags': ['installation', 'dépannage', 'câblage', 'tableau électrique'],
      'disponible': true,
      'zone': 'Cocody',
      'note': 4.9,
      'experience': 8,
      'bio': 'Électricienne certifiée spécialisée dans les installations domestiques et professionnelles',
    },
    {
      'id': 'pres-003',
      'nom': 'Ibrahim Touré',
      'profession': 'Mécanicien',
      'categories': ['Automobile', 'Mécanique'],
      'tags': ['réparation', 'entretien', 'diagnostic', 'moteur'],
      'disponible': false,
      'zone': 'Abobo',
      'note': 4.5,
      'experience': 12,
      'bio': 'Mécanicien automobile avec atelier équipé pour tout type de réparation',
    },
    {
      'id': 'pres-004',
      'nom': 'Fatou Cissé',
      'profession': 'Coiffeuse',
      'categories': ['Beauté', 'Coiffure'],
      'tags': ['tresses', 'extensions', 'coupe', 'coloration', 'à domicile'],
      'disponible': true,
      'zone': 'Treichville',
      'note': 4.7,
      'experience': 6,
      'bio': 'Coiffeuse styliste spécialisée dans les tresses africaines et extensions',
    },
    {
      'id': 'pres-005',
      'nom': 'Mamadou Bamba',
      'profession': 'Menuisier',
      'categories': ['Menuiserie', 'Ébénisterie'],
      'tags': ['fabrication', 'réparation', 'meuble', 'bois', 'cuisine'],
      'disponible': true,
      'zone': 'Plateau',
      'note': 4.6,
      'experience': 15,
      'bio': 'Menuisier ébéniste avec atelier artisanal, création de meubles sur mesure',
    },
    {
      'id': 'pres-006',
      'nom': 'Aya Koné',
      'profession': 'Informaticienne',
      'categories': ['Informatique', 'Réseaux'],
      'tags': ['dépannage', 'installation', 'maintenance', 'formation'],
      'disponible': true,
      'zone': 'Marcory',
      'note': 4.8,
      'experience': 4,
      'bio': 'Ingénieure informatique offrant des services de maintenance et formation',
    },
  ];

  // Zones géographiques d'Abidjan pour la correspondance
  final Map<String, List<String>> _zoneAliases = {
    'Yopougon': ['Yop', 'Yopou', 'Yopougon Académie', 'Yopougon Santé'],
    'Cocody': ['Cocody Angré', 'Riviera', 'II Plateaux', 'Ambassade'],
    'Abobo': ['Abobo Baoulé', 'Abobo Gare', 'Abobo Centre'],
    'Treichville': ['Treich', 'Zone 3'],
    'Plateau': ['Centre-ville', 'Plateau Centre', 'Plateau Dokui'],
    'Marcory': ['Marcory Zone 4', 'Marcory Résidentiel'],
    'Koumassi': ['Koum', 'Koumassi Grand Marché'],
    'Port-Bouët': ['Port-Bouët Vridi', 'Port-Bouët Aéroport'],
    'Adjamé': ['Adjamé Centre', 'Adjamé Forum'],
    'Attécoubé': ['Attécoubé Locodjoro'],
  };

  @override
  Future<List<AIProviderRecommendation>> getRecommendedProviders({
    required String query,
    required String location,
    int maxResults = 5,
    bool filterImmediatelyAvailable = false,
  }) async {
    // Simuler un délai de traitement IA
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Extraire les entités de la requête
    final queryEntities = await analyzeUserQuery(query);
    
    // Filtrer les prestataires disponibles si demandé
    var filteredProviders = _mockPrestataires;
    if (filterImmediatelyAvailable) {
      filteredProviders = filteredProviders.where((p) => p['disponible'] == true).toList();
    }
    
    // Identifier la zone correspondante
    String normalizedLocation = _normalizeLocation(location);
    
    // Filtrer par localisation si fournie
    if (location.isNotEmpty) {
      filteredProviders = filteredProviders.where((p) {
        final providerZone = p['zone'] as String;
        return _isInSameArea(providerZone, normalizedLocation);
      }).toList();
    }
    
    // Calculer les scores de correspondance pour chaque prestataire
    List<AIProviderRecommendation> recommendations = [];
    
    for (var providerData in filteredProviders) {
      final matchScore = await calculateMatchScore(providerData, queryEntities);
      
      // Créer un prestataire à partir des données mock
      final prestataire = Prestataire(
        idutilisateur: providerData['id'].toString(), 
        nomprenom: providerData['nom'],
        telephone: providerData['telephone'] ?? '+225 0700000000',
        idservice: providerData['categoryId'] ?? '0',
        nomservice: providerData['category'] ?? 'Service général',
        prixmoyen: providerData['averagePrice']?.toString() ?? '5000',
        localisation: providerData['zone'] ?? 'Abidjan',
        note: providerData['rating']?.toString() ?? '4.0',
        verifier: providerData['verified'] ? '1' : '0',
      );
      
      // Générer une raison de match explicative
      final matchReason = _generateMatchReason(matchScore, providerData, queryEntities);
      
      recommendations.add(AIProviderRecommendation(
        prestataire: prestataire,
        matchScore: matchScore,
        matchReason: matchReason,
        matchDetails: {
          'queryTerms': queryEntities['terms'],
          'providerTags': providerData['tags'],
          'categoryMatch': queryEntities['category'] == providerData['profession'],
          'locationMatch': _isInSameArea(providerData['zone'], normalizedLocation),
        },
      ));
    }
    
    // Trier par score de correspondance et limiter le nombre de résultats
    recommendations.sort((a, b) => b.matchScore.compareTo(a.matchScore));
    return recommendations.take(maxResults).toList();
  }

  @override
  Future<Map<String, dynamic>> analyzeUserQuery(String query) async {
    // Simuler l'analyse NLP d'une requête utilisateur
    final query_lower = query.toLowerCase();
    
    // Extraire la catégorie/profession
    String category = '';
    if (query_lower.contains('plomb')) category = 'Plombier';
    else if (query_lower.contains('élect') || query_lower.contains('elect')) category = 'Électricien';
    else if (query_lower.contains('mécan') || query_lower.contains('mecan')) category = 'Mécanicien';
    else if (query_lower.contains('coiff')) category = 'Coiffeur';
    else if (query_lower.contains('menuis')) category = 'Menuisier';
    else if (query_lower.contains('info')) category = 'Informaticien';
    
    // Détecter l'urgence
    bool isUrgent = query_lower.contains('urgent') || 
                   query_lower.contains('urgence') || 
                   query_lower.contains('rapidement') ||
                   query_lower.contains('immédiat');
    
    // Extraire la localisation si présente
    String location = '';
    for (var zone in _zoneAliases.keys) {
      if (query_lower.contains(zone.toLowerCase())) {
        location = zone;
        break;
      }
      
      // Vérifier les alias
      for (var alias in _zoneAliases[zone]!) {
        if (query_lower.contains(alias.toLowerCase())) {
          location = zone;
          break;
        }
      }
      
      if (location.isNotEmpty) break;
    }
    
    // Extraire les termes significatifs
    List<String> terms = query_lower
        .split(' ')
        .where((term) => term.length > 3)  // Ignorer les mots courts
        .toList();
    
    return {
      'category': category,
      'isUrgent': isUrgent,
      'extractedLocation': location,
      'terms': terms,
      'originalQuery': query,
    };
  }

  @override
  Future<double> calculateMatchScore(
    Map<String, dynamic> providerData, 
    Map<String, dynamic> queryEntities
  ) async {
    double score = 0.0;
    
    // Score pour la correspondance de catégorie/profession
    final providerProfession = providerData['profession'] as String;
    final queryCategory = queryEntities['category'] as String;
    
    if (queryCategory.isNotEmpty && providerProfession == queryCategory) {
      score += 0.5; // 50% du score pour la catégorie correcte
    }
    
    // Score pour les tags correspondants
    final providerTags = providerData['tags'] as List<dynamic>;
    final queryTerms = queryEntities['terms'] as List<dynamic>;
    
    int matchingTerms = 0;
    for (var term in queryTerms) {
      for (var tag in providerTags) {
        if (tag.toString().toLowerCase().contains(term.toString().toLowerCase())) {
          matchingTerms++;
          break;
        }
      }
    }
    
    if (queryTerms.isNotEmpty) {
      score += (0.3 * matchingTerms / queryTerms.length); // 30% pour les tags
    }
    
    // Score pour l'expérience
    final experience = providerData['experience'] as int;
    score += (0.1 * min(experience / 10, 1.0)); // 10% pour l'expérience (max 10 ans)
    
    // Score pour les notes
    final rating = providerData['note'] as double;
    score += (0.1 * (rating / 5.0)); // 10% pour la note (sur 5)
    
    // Ajuster pour l'urgence si demandé et non disponible
    if (queryEntities['isUrgent'] == true && providerData['disponible'] != true) {
      score *= 0.5; // Diviser le score par 2 si urgent mais non disponible
    }
    
    return score;
  }

  // Méthodes auxiliaires
  
  String _normalizeLocation(String location) {
    final locationLower = location.toLowerCase();
    
    for (var zone in _zoneAliases.keys) {
      if (locationLower.contains(zone.toLowerCase())) {
        return zone;
      }
      
      for (var alias in _zoneAliases[zone]!) {
        if (locationLower.contains(alias.toLowerCase())) {
          return zone;
        }
      }
    }
    
    return location;
  }
  
  bool _isInSameArea(String providerZone, String queryLocation) {
    if (queryLocation.isEmpty) return true;
    
    final providerZoneLower = providerZone.toLowerCase();
    final queryLocationLower = queryLocation.toLowerCase();
    
    if (providerZoneLower.contains(queryLocationLower) || 
        queryLocationLower.contains(providerZoneLower)) {
      return true;
    }
    
    // Vérifier les alias de zone
    for (var zone in _zoneAliases.keys) {
      final aliases = _zoneAliases[zone]!;
      
      bool providerInZone = providerZoneLower.contains(zone.toLowerCase());
      if (!providerInZone) {
        for (var alias in aliases) {
          if (providerZoneLower.contains(alias.toLowerCase())) {
            providerInZone = true;
            break;
          }
        }
      }
      
      bool queryInZone = queryLocationLower.contains(zone.toLowerCase());
      if (!queryInZone) {
        for (var alias in aliases) {
          if (queryLocationLower.contains(alias.toLowerCase())) {
            queryInZone = true;
            break;
          }
        }
      }
      
      if (providerInZone && queryInZone) return true;
    }
    
    return false;
  }
  
  String _generateMatchReason(
    double score, 
    Map<String, dynamic> providerData, 
    Map<String, dynamic> queryEntities
  ) {
    if (score > 0.8) {
      return 'Excellent match! ${providerData['nom']} est spécialisé(e) en ${providerData['profession']} '
          'avec ${providerData['experience']} ans d\'expérience et d\'excellentes évaluations.';
    } else if (score > 0.6) {
      return 'Très bon match avec ${providerData['nom']}, qui correspond parfaitement à votre recherche '
          'et opère dans votre zone.';
    } else if (score > 0.4) {
      return 'Bon match. ${providerData['nom']} propose des services similaires à votre recherche.';
    } else {
      return 'Match possible. ${providerData['nom']} pourrait répondre à certains aspects de votre demande.';
    }
  }
}
