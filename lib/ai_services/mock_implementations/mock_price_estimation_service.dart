import 'dart:math';

import 'package:sdealsapp/ai_services/interfaces/price_estimation_service.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';

/// Implémentation mock du service d'estimation de prix intelligent
/// Cette classe simule le comportement d'un service d'estimation de prix par IA
class MockPriceEstimationService implements PriceEstimationService {
  // Données de base pour les estimations de prix par service et zone
  final Map<String, Map<String, Map<String, dynamic>>> _basePriceData = {
    'Plomberie': {
      'Yopougon': {'min': 5000.0, 'max': 15000.0, 'demand': 0.8},
      'Cocody': {'min': 8000.0, 'max': 20000.0, 'demand': 0.7},
      'Abobo': {'min': 5000.0, 'max': 12000.0, 'demand': 0.9},
      'Treichville': {'min': 6000.0, 'max': 15000.0, 'demand': 0.6},
      'default': {'min': 6000.0, 'max': 18000.0, 'demand': 0.7},
    },
    'Électricité': {
      'Yopougon': {'min': 6000.0, 'max': 18000.0, 'demand': 0.7},
      'Cocody': {'min': 10000.0, 'max': 25000.0, 'demand': 0.8},
      'Abobo': {'min': 5000.0, 'max': 15000.0, 'demand': 0.8},
      'Treichville': {'min': 7000.0, 'max': 18000.0, 'demand': 0.6},
      'default': {'min': 7000.0, 'max': 20000.0, 'demand': 0.7},
    },
    'Mécanique': {
      'Yopougon': {'min': 8000.0, 'max': 35000.0, 'demand': 0.9},
      'Cocody': {'min': 15000.0, 'max': 50000.0, 'demand': 0.6},
      'Abobo': {'min': 7000.0, 'max': 30000.0, 'demand': 0.8},
      'Treichville': {'min': 10000.0, 'max': 40000.0, 'demand': 0.7},
      'default': {'min': 10000.0, 'max': 40000.0, 'demand': 0.7},
    },
    'Coiffure': {
      'Yopougon': {'min': 3000.0, 'max': 12000.0, 'demand': 0.8},
      'Cocody': {'min': 5000.0, 'max': 20000.0, 'demand': 0.9},
      'Abobo': {'min': 2500.0, 'max': 10000.0, 'demand': 0.7},
      'Treichville': {'min': 3500.0, 'max': 15000.0, 'demand': 0.8},
      'default': {'min': 3500.0, 'max': 15000.0, 'demand': 0.8},
    },
    'Menuiserie': {
      'Yopougon': {'min': 15000.0, 'max': 60000.0, 'demand': 0.6},
      'Cocody': {'min': 25000.0, 'max': 100000.0, 'demand': 0.7},
      'Abobo': {'min': 12000.0, 'max': 50000.0, 'demand': 0.6},
      'Treichville': {'min': 18000.0, 'max': 70000.0, 'demand': 0.5},
      'default': {'min': 18000.0, 'max': 70000.0, 'demand': 0.6},
    },
    'Informatique': {
      'Yopougon': {'min': 8000.0, 'max': 25000.0, 'demand': 0.7},
      'Cocody': {'min': 12000.0, 'max': 35000.0, 'demand': 0.9},
      'Abobo': {'min': 7000.0, 'max': 20000.0, 'demand': 0.5},
      'Treichville': {'min': 10000.0, 'max': 30000.0, 'demand': 0.8},
      'default': {'min': 9000.0, 'max': 28000.0, 'demand': 0.7},
    },
    'default': {
      'default': {'min': 5000.0, 'max': 20000.0, 'demand': 0.7},
    },
  };

  // Facteurs qui influencent les prix
  final Map<String, double> _priceFactors = {
    'urgence': 1.5, // +50% pour une urgence
    'weekend': 1.3, // +30% pour un weekend
    'nuit': 1.4, // +40% pour la nuit
    'complexite_elevee': 1.4, // +40% pour travaux complexes
    'saison_pluie': 1.2, // +20% en saison des pluies (pour plomberie, etc.)
    'forte_demande': 1.15, // +15% en période de forte demande
    'experience_elevee': 1.25, // +25% pour prestataire très expérimenté
    'materiaux_fournis': 1.3, // +30% si matériaux fournis
  };

  // Données d'historique de prix simulées
  final Map<String, List<Map<String, dynamic>>> _mockHistoricalData = {};
  
  // Générateur de nombres aléatoires
  final Random _random = Random();
  
  MockPriceEstimationService() {
    _generateHistoricalData();
  }
  
  void _generateHistoricalData() {
    // Génère des données historiques fictives pour chaque service et zone
    final now = DateTime.now();
    
    for (var service in _basePriceData.keys) {
      if (service == 'default') continue;
      
      _mockHistoricalData[service] = [];
      
      for (var zone in _basePriceData[service]!.keys) {
        if (zone == 'default') continue;
        
        final basePrice = _basePriceData[service]![zone]!;
        
        // Générer des données pour les 90 derniers jours
        for (var i = 0; i < 90; i++) {
          final date = now.subtract(Duration(days: i));
          
          // Variation saisonnière (plus cher en saison des pluies pour plomberie par exemple)
          final month = date.month;
          double seasonFactor = 1.0;
          
          // Mai à juillet: saison des pluies (Abidjan)
          if (month >= 5 && month <= 7) {
            seasonFactor = service == 'Plomberie' ? 1.2 : 1.05;
          }
          
          // Variation hebdomadaire (plus cher le weekend)
          final weekday = date.weekday;
          final weekendFactor = (weekday == 6 || weekday == 7) ? 1.15 : 1.0;
          
          // Variation aléatoire
          final randomFactor = 0.9 + (_random.nextDouble() * 0.2); // Entre 0.9 et 1.1
          
          final minPrice = basePrice['min'] * seasonFactor * weekendFactor * randomFactor;
          final maxPrice = basePrice['max'] * seasonFactor * weekendFactor * randomFactor;
          
          _mockHistoricalData[service]!.add({
            'date': date.toString().substring(0, 10),
            'zone': zone,
            'minPrice': minPrice,
            'maxPrice': maxPrice,
            'demandLevel': basePrice['demand'] * seasonFactor * randomFactor,
            'factors': {
              'season': seasonFactor,
              'weekend': weekendFactor,
              'random': randomFactor,
            },
          });
        }
      }
    }
  }

  @override
  Future<AIPriceEstimation> estimatePrice({
    required String serviceType,
    required String location,
    Map<String, dynamic> additionalFactors = const {},
  }) async {
    // Simuler un délai de traitement IA
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Normaliser le type de service
    String normalizedServiceType = _normalizeServiceType(serviceType);
    
    // Normaliser la localisation
    String normalizedLocation = _normalizeLocation(location);
    
    // Récupérer les prix de base
    Map<String, dynamic> basePrice;
    
    // Vérifier si nous avons des données spécifiques pour cette combinaison service/zone
    if (_basePriceData.containsKey(normalizedServiceType)) {
      final serviceData = _basePriceData[normalizedServiceType]!;
      
      if (serviceData.containsKey(normalizedLocation)) {
        basePrice = serviceData[normalizedLocation]!;
      } else {
        // Utiliser les valeurs par défaut pour ce service
        basePrice = serviceData['default']!;
      }
    } else {
      // Utiliser les valeurs par défaut générales
      basePrice = _basePriceData['default']!['default']!;
    }
    
    // Calculer les facteurs de prix supplémentaires
    double factorMultiplier = 1.0;
    List<String> factorsApplied = [];
    
    additionalFactors.forEach((factor, value) {
      if (value == true && _priceFactors.containsKey(factor)) {
        factorMultiplier *= _priceFactors[factor]!;
        factorsApplied.add(factor);
      }
    });
    
    // Appliquer une légère variation aléatoire (+/- 5%)
    final randomVariation = 0.95 + (_random.nextDouble() * 0.1);
    factorMultiplier *= randomVariation;
    
    // Calculer les prix finaux
    final minPrice = basePrice['min'] * factorMultiplier;
    final maxPrice = basePrice['max'] * factorMultiplier;
    
    // Générer les facteurs explicatifs
    final factors = _generatePriceFactors(
      normalizedServiceType,
      normalizedLocation,
      factorsApplied,
      basePrice['demand'] as double,
    );
    
    return AIPriceEstimation(
      serviceType: normalizedServiceType,
      location: normalizedLocation,
      minPrice: minPrice,
      maxPrice: maxPrice,
      factors: factors,
      priceDetails: {
        'baseMin': basePrice['min'],
        'baseMax': basePrice['max'],
        'factorMultiplier': factorMultiplier,
        'factorsApplied': factorsApplied,
        'demandLevel': basePrice['demand'],
        'randomVariation': randomVariation,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getHistoricalPriceData({
    required String serviceType,
    required String location,
    int periodInDays = 90,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Normaliser les paramètres
    String normalizedServiceType = _normalizeServiceType(serviceType);
    String normalizedLocation = _normalizeLocation(location);
    
    // Si nous n'avons pas d'historique pour ce service, retourner une liste vide
    if (!_mockHistoricalData.containsKey(normalizedServiceType)) {
      return [];
    }
    
    // Filtrer les données par zone et période
    final now = DateTime.now();
    final cutoffDate = now.subtract(Duration(days: periodInDays));
    
    return _mockHistoricalData[normalizedServiceType]!
        .where((data) {
          // Vérifier la zone
          if (data['zone'] != normalizedLocation) return false;
          
          // Vérifier la date
          final dataDate = DateTime.parse(data['date'] as String);
          return dataDate.isAfter(cutoffDate);
        })
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> analyzePriceFactors({
    required String serviceType,
    required String location,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 700));
    
    // Normaliser les paramètres
    String normalizedServiceType = _normalizeServiceType(serviceType);
    String normalizedLocation = _normalizeLocation(location);
    
    // Facteurs spécifiques par type de service
    final Map<String, List<String>> serviceSpecificFactors = {
      'Plomberie': ['saison_pluie', 'urgence', 'complexite_elevee'],
      'Électricité': ['urgence', 'complexite_elevee', 'nuit'],
      'Mécanique': ['complexite_elevee', 'forte_demande', 'materiaux_fournis'],
      'Coiffure': ['weekend', 'experience_elevee', 'forte_demande'],
      'Menuiserie': ['materiaux_fournis', 'complexite_elevee', 'experience_elevee'],
      'Informatique': ['urgence', 'experience_elevee', 'forte_demande'],
    };
    
    // Sélectionner les facteurs pertinents pour ce service
    List<String> relevantFactors = serviceSpecificFactors[normalizedServiceType] ?? 
        ['urgence', 'weekend', 'experience_elevee'];
    
    // Analyser l'impact de chaque facteur
    List<Map<String, dynamic>> analysis = [];
    
    for (var factor in relevantFactors) {
      if (_priceFactors.containsKey(factor)) {
        final impact = _priceFactors[factor]! - 1.0; // Convertir multiplicateur en pourcentage
        
        analysis.add({
          'facteur': _factorDisplayName(factor),
          'impact': impact,
          'impactPercent': '${(impact * 100).toStringAsFixed(0)}%',
          'explication': _getFactorExplanation(factor),
        });
      }
    }
    
    // Ajouter un facteur d'emplacement si non-standard
    if (normalizedLocation != 'default') {
      double locationImpact = 0.0;
      
      // Comparer avec une zone moyenne
      final serviceData = _basePriceData[normalizedServiceType] ?? _basePriceData['default']!;
      final defaultPrice = serviceData['default']!['min'];
      final locationPrice = serviceData[normalizedLocation]?['min'] ?? defaultPrice;
      
      if (defaultPrice > 0) {
        locationImpact = (locationPrice / defaultPrice) - 1.0;
      }
      
      analysis.add({
        'facteur': 'Emplacement ($normalizedLocation)',
        'impact': locationImpact,
        'impactPercent': '${(locationImpact * 100).toStringAsFixed(0)}%',
        'explication': 'Impact de la zone géographique sur les prix',
      });
    }
    
    // Trier par impact décroissant
    analysis.sort((a, b) => (b['impact'] as double).compareTo(a['impact'] as double));
    
    return analysis;
  }
  
  // Méthodes auxiliaires
  
  String _normalizeServiceType(String serviceType) {
    final serviceLower = serviceType.toLowerCase();
    
    if (serviceLower.contains('plomb')) return 'Plomberie';
    else if (serviceLower.contains('élect') || serviceLower.contains('elect')) return 'Électricité';
    else if (serviceLower.contains('mécan') || serviceLower.contains('mecan')) return 'Mécanique';
    else if (serviceLower.contains('coiff')) return 'Coiffure';
    else if (serviceLower.contains('menuis')) return 'Menuiserie';
    else if (serviceLower.contains('info')) return 'Informatique';
    
    // Vérifier les correspondances partielles
    for (var service in _basePriceData.keys) {
      if (service == 'default') continue;
      if (serviceLower.contains(service.toLowerCase())) return service;
    }
    
    return serviceType;
  }
  
  String _normalizeLocation(String location) {
    final locationLower = location.toLowerCase();
    
    if (locationLower.contains('yopou')) return 'Yopougon';
    else if (locationLower.contains('cocody')) return 'Cocody';
    else if (locationLower.contains('abobo')) return 'Abobo';
    else if (locationLower.contains('treich')) return 'Treichville';
    else if (locationLower.contains('plateau')) return 'Plateau';
    else if (locationLower.contains('marcory')) return 'Marcory';
    else if (locationLower.contains('koumas')) return 'Koumassi';
    else if (locationLower.contains('port')) return 'Port-Bouët';
    else if (locationLower.contains('adjam')) return 'Adjamé';
    
    return location;
  }
  
  List<String> _generatePriceFactors(
    String serviceType, 
    String location, 
    List<String> appliedFactors,
    double demandLevel,
  ) {
    List<String> factors = [];
    
    // Facteur de demande
    if (demandLevel > 0.8) {
      factors.add('Forte demande dans cette zone (+${(15 * demandLevel).toStringAsFixed(0)}%)');
    } else if (demandLevel < 0.6) {
      factors.add('Demande modérée dans cette zone');
    }
    
    // Facteurs spécifiques appliqués
    for (var factor in appliedFactors) {
      switch (factor) {
        case 'urgence':
          factors.add('Majoration pour intervention urgente (+50%)');
          break;
        case 'weekend':
          factors.add('Majoration weekend (+30%)');
          break;
        case 'nuit':
          factors.add('Majoration horaire de nuit (+40%)');
          break;
        case 'complexite_elevee':
          factors.add('Complexité technique élevée (+40%)');
          break;
        case 'saison_pluie':
          factors.add('Période de saison des pluies (+20%)');
          break;
        case 'forte_demande':
          factors.add('Période de forte affluence (+15%)');
          break;
        case 'experience_elevee':
          factors.add('Prestataire hautement qualifié (+25%)');
          break;
        case 'materiaux_fournis':
          factors.add('Matériaux/pièces inclus (+30%)');
          break;
      }
    }
    
    // Facteurs spécifiques au service
    switch (serviceType) {
      case 'Plomberie':
        factors.add('Prix basé sur les interventions similaires récentes');
        break;
      case 'Électricité':
        factors.add('Tarification alignée sur les standards du secteur');
        break;
      case 'Mécanique':
        factors.add('Prix estimé hors pièces détachées majeures');
        break;
      case 'Coiffure':
        factors.add('Tarif moyen pour une prestation standard');
        break;
      case 'Menuiserie':
        factors.add('Estimation pour travail artisanal, hors matériaux spéciaux');
        break;
      case 'Informatique':
        factors.add('Tarif pour intervention technique standard');
        break;
    }
    
    return factors;
  }
  
  String _factorDisplayName(String factor) {
    switch (factor) {
      case 'urgence': return 'Urgence';
      case 'weekend': return 'Weekend';
      case 'nuit': return 'Intervention de nuit';
      case 'complexite_elevee': return 'Complexité technique';
      case 'saison_pluie': return 'Saison des pluies';
      case 'forte_demande': return 'Forte demande';
      case 'experience_elevee': return 'Expertise supérieure';
      case 'materiaux_fournis': return 'Matériaux inclus';
      default: return factor;
    }
  }
  
  String _getFactorExplanation(String factor) {
    switch (factor) {
      case 'urgence':
        return 'Les interventions urgentes nécessitent une réorganisation du planning du prestataire';
      case 'weekend':
        return 'Les weekends sont généralement facturés avec une majoration standard';
      case 'nuit':
        return 'Les interventions nocturnes impliquent des conditions de travail particulières';
      case 'complexite_elevee':
        return 'Les travaux complexes demandent plus de compétences et de temps';
      case 'saison_pluie':
        return 'En saison des pluies, la demande pour certains services augmente significativement';
      case 'forte_demande':
        return 'Les périodes de forte demande influent sur la disponibilité et les tarifs';
      case 'experience_elevee':
        return 'L\'expertise et l\'expérience du prestataire impactent la qualité et le prix';
      case 'materiaux_fournis':
        return 'La fourniture des matériaux ou pièces par le prestataire inclut une marge';
      default:
        return 'Ce facteur influence le prix final du service';
    }
  }
}
