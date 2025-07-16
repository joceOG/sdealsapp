import 'dart:math';

import 'package:sdealsapp/ai_services/interfaces/demand_prediction_service.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';

/// Implémentation mock du service de prédiction de la demande
/// Cette classe simule le comportement d'un système de prédiction de demande
/// avec des données fictives et des tendances simulées
class MockDemandPredictionService implements DemandPredictionService {
  // Générateur de nombres aléatoires pour la simulation
  final Random _random = Random();
  
  // Facteurs saisonniers par mois (1-12)
  final Map<int, double> _seasonalFactors = {
    1: 0.9,  // Janvier
    2: 0.95, // Février
    3: 1.0,  // Mars
    4: 1.05, // Avril
    5: 1.1,  // Mai
    6: 1.2,  // Juin (début saison des pluies)
    7: 1.3,  // Juillet (pleine saison des pluies)
    8: 1.4,  // Août (pleine saison des pluies)
    9: 1.3,  // Septembre
    10: 1.2, // Octobre
    11: 1.1, // Novembre
    12: 1.3, // Décembre (fêtes)
  };
  
  // Facteurs journaliers (1-7, lundi à dimanche)
  final Map<int, double> _weekdayFactors = {
    1: 1.0,  // Lundi
    2: 0.9,  // Mardi
    3: 0.85, // Mercredi
    4: 0.9,  // Jeudi
    5: 1.1,  // Vendredi
    6: 1.5,  // Samedi
    7: 1.2,  // Dimanche
  };
  
  // Zones géographiques avec leurs facteurs de demande
  final Map<String, double> _locationFactors = {
    'abidjan': 1.2,
    'bouaké': 0.9,
    'daloa': 0.8,
    'san pedro': 0.85,
    'yamoussoukro': 0.95,
    'yopougon': 1.2,
    'cocody': 1.5,
    'abobo': 1.0,
    'treichville': 1.3,
    'plateau': 1.4,
    'marcory': 1.1,
    'koumassi': 0.9,
    'port-bouët': 0.8,
  };
  
  // Facteurs de base pour les catégories
  final Map<String, double> _categoryBaseFactors = {
    'plomberie': 0.75,
    'électricité': 0.8,
    'beauté': 0.85,
    'coiffure': 0.7,
    'informatique': 0.65,
    'transport': 0.6,
    'ménage': 0.7,
    'jardinage': 0.5,
    'mécanique': 0.7,
  };
  
  @override
  Future<AIDemandPrediction> predictDemand({
    required Categorie categorie,
    required String location,
    int daysAhead = 7,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Date cible de la prédiction
    final DateTime predictionDate = DateTime.now().add(Duration(days: daysAhead));
    final int month = predictionDate.month;
    final int weekday = predictionDate.weekday;
    
    // Calculer le score de demande en fonction des différents facteurs
    double baseScore = _getCategoryBaseFactor(categorie);
    double locationFactor = _getLocationFactor(location);
    double seasonalFactor = _seasonalFactors[month] ?? 1.0;
    double weekdayFactor = _weekdayFactors[weekday] ?? 1.0;
    
    // Ajouter une variation aléatoire (±15%)
    double randomVariation = 0.85 + (_random.nextDouble() * 0.3);
    
    // Calculer le score final normalisé (entre 0.0 et 1.0)
    double demandScore = (baseScore * locationFactor * seasonalFactor * weekdayFactor * randomVariation).clamp(0.0, 1.0);
    
    // Déterminer la tendance
    String trend = _getTrend(demandScore);
    
    // Générer un insight textuel personnalisé
    String insight = _generateInsight(categorie, location, demandScore);
    
    // Créer la prédiction avec les données calculées
    return AIDemandPrediction(
      location: location,
      categorie: categorie,
      period: predictionDate,
      demandScore: demandScore,
      trend: trend,
      insight: insight,
    );
  }
  
  @override
  Future<List<AIDemandPrediction>> getTopTrendingCategories({
    required String location,
    int limit = 5,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Créer une liste de catégories fictives
    List<Categorie> mockCategories = [
      Categorie(idcategorie: '1', nomcategorie: 'Plomberie', imagecategorie: 'plumbing.png', groupe: 'Habitat'),
      Categorie(idcategorie: '2', nomcategorie: 'Électricité', imagecategorie: 'electricity.png', groupe: 'Habitat'),
      Categorie(idcategorie: '3', nomcategorie: 'Coiffure', imagecategorie: 'hairdressing.png', groupe: 'Beauté'),
      Categorie(idcategorie: '4', nomcategorie: 'Mécanique', imagecategorie: 'mechanics.png', groupe: 'Auto'),
      Categorie(idcategorie: '5', nomcategorie: 'Ménage', imagecategorie: 'cleaning.png', groupe: 'Habitat'),
      Categorie(idcategorie: '6', nomcategorie: 'Jardinage', imagecategorie: 'gardening.png', groupe: 'Habitat'),
      Categorie(idcategorie: '7', nomcategorie: 'Informatique', imagecategorie: 'it.png', groupe: 'Tech'),
      Categorie(idcategorie: '8', nomcategorie: 'Transport', imagecategorie: 'transport.png', groupe: 'Mobilité'),
    ];
    
    // Liste pour stocker les prédictions calculées
    List<AIDemandPrediction> trendingPredictions = [];
    
    // Date de prédiction commune pour toutes les catégories
    final DateTime predictionDate = DateTime.now().add(const Duration(days: 7));
    
    // Facteur lié à la localisation
    double locationFactor = _getLocationFactor(location);
    
    // Pour chaque catégorie, calculer un score de demande simulé
    for (var categorie in mockCategories) {
      // Calculer un score de base avec variation aléatoire
      double baseScore = _getCategoryBaseFactor(categorie);
      double randomFactor = 0.8 + (_random.nextDouble() * 0.4); // 0.8 à 1.2
      
      // Facteurs saisonniers et journaliers
      double seasonalFactor = _seasonalFactors[predictionDate.month] ?? 1.0;
      double weekdayFactor = _weekdayFactors[predictionDate.weekday] ?? 1.0;
      
      // Score final
      double finalScore = (baseScore * locationFactor * seasonalFactor * weekdayFactor * randomFactor).clamp(0.0, 1.0);
      
      // Déterminer la tendance
      String trend = _getTrend(finalScore);
      
      // Générer un insight
      String insight = _generateTrendInsight(categorie.nomcategorie, location, finalScore);
      
      // Créer la prédiction et l'ajouter à la liste
      trendingPredictions.add(
        AIDemandPrediction(
          location: location,
          categorie: categorie,
          period: predictionDate,
          demandScore: finalScore,
          trend: trend,
          insight: insight,
        ),
      );
    }
    
    // Trier par score de demande décroissant
    trendingPredictions.sort((a, b) => b.demandScore.compareTo(a.demandScore));
    
    // Limiter le nombre de résultats
    return trendingPredictions.take(limit).toList();
  }
  
  @override
  Future<List<String>> generateProviderInsights({
    required Map<String, dynamic> providerData,
    required List<Categorie> providerCategories,
    required String location,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Liste pour stocker les insights générés
    List<String> insights = [];
    
    // Date de référence
    final now = DateTime.now();
    
    // Générer des insights généraux basés sur la localisation
    String locationInsight = _getLocationBasedInsight(location);
    insights.add(locationInsight);
    
    // Générer des insights pour chaque catégorie de service du prestataire
    for (var categorie in providerCategories) {
      // Calculer un score de demande pour cette catégorie
      double baseScore = _getCategoryBaseFactor(categorie);
      double locationFactor = _getLocationFactor(location);
      double seasonalFactor = _seasonalFactors[now.month] ?? 1.0;
      double randomVariation = 0.9 + (_random.nextDouble() * 0.2);
      
      // Score final
      double demandScore = (baseScore * locationFactor * seasonalFactor * randomVariation).clamp(0.0, 1.0);
      
      // Générer un insight pour le prestataire sur cette catégorie
      String categoryInsight = _generateProviderCategoryInsight(categorie, location, demandScore);
      insights.add(categoryInsight);
    }
    
    // Ajouter un conseil sur la tarification si on a assez de données
    if (providerCategories.isNotEmpty) {
      String pricingInsight = _generatePricingInsight(providerCategories.first, location);
      insights.add(pricingInsight);
    }
    
    // Ajouter un conseil sur la satisfaction client
    String satisfactionInsight = _generateCustomerSatisfactionInsight();
    insights.add(satisfactionInsight);
    
    return insights;
  }
  
  @override
  Future<Map<String, dynamic>> getHistoricalDemandData({
    required Categorie categorie,
    required String location,
    int periodInDays = 90,
  }) async {
    // Simuler un délai de traitement
    await Future.delayed(const Duration(milliseconds: 700));
    
    // Nombre de points de données à générer
    int numberOfDataPoints = (periodInDays / 7).ceil(); // Un point par semaine
    
    // Date actuelle
    DateTime currentDate = DateTime.now();
    
    // Facteurs de base pour la catégorie et la localisation
    double baseScore = _getCategoryBaseFactor(categorie);
    double locationFactor = _getLocationFactor(location);
    
    // Listes pour stocker les données simulées
    List<double> demandValues = [];
    List<double> priceValues = [];
    List<double> satisfactionValues = [];
    List<String> timeLabels = [];
    
    // Générer des données pour chaque point dans le temps
    for (int i = numberOfDataPoints - 1; i >= 0; i--) {
      // Calculer la date de ce point de données (en remontant dans le passé)
      DateTime pointDate = currentDate.subtract(Duration(days: i * 7));
      String dateLabel = '${pointDate.day}/${pointDate.month}/${pointDate.year}';
      timeLabels.add(dateLabel);
      
      // Facteur saisonnier pour ce mois
      double seasonalFactor = _seasonalFactors[pointDate.month] ?? 1.0;
      
      // Variation aléatoire pour simuler des fluctuations naturelles
      double randomVariation = 0.85 + (_random.nextDouble() * 0.3);
      
      // Calculer le score de demande pour cette période
      double demandScore = (baseScore * locationFactor * seasonalFactor * randomVariation).clamp(0.0, 1.0);
      
      // Ajouter une tendance légère dans le temps (croissance progressive de 2% par point)
      double timeProgression = 1.0 + (0.02 * (numberOfDataPoints - i - 1));
      demandScore = (demandScore * timeProgression).clamp(0.0, 1.0);
      
      // Prix moyen (corrélé à la demande avec une légère variation)
      double priceScore = (demandScore * (0.9 + _random.nextDouble() * 0.2)).clamp(0.0, 1.0);
      
      // Satisfaction client (inversement corrélée au prix, avec variation)
      double satisfactionScore = ((1 - (priceScore - 0.5) * 0.5) * (0.85 + _random.nextDouble() * 0.3)).clamp(0.0, 1.0);
      
      // Ajouter les données calculées
      demandValues.add(demandScore);
      priceValues.add(priceScore);
      satisfactionValues.add(satisfactionScore);
    }
    
    // Structure des données historiques à retourner
    Map<String, dynamic> historicalData = {
      'category': categorie.nomcategorie,
      'location': location,
      'period': '$periodInDays jours',
      'timeLabels': timeLabels,
      'datasets': {
        'demand': {
          'label': 'Niveau de demande',
          'data': demandValues,
        },
        'price': {
          'label': 'Prix moyen relatif',
          'data': priceValues,
        },
        'satisfaction': {
          'label': 'Satisfaction client',
          'data': satisfactionValues,
        },
      },
      'insights': _generateHistoricalInsight(categorie, location, demandValues),
    };
    
    return historicalData;
  }
  
  // Méthodes utilitaires privées
  
  /// Obtenir le facteur de base pour une catégorie
  double _getCategoryBaseFactor(Categorie categorie) {
    String categoryName = categorie.nomcategorie.toLowerCase();
    return _categoryBaseFactors[categoryName] ?? 0.65; // Valeur par défaut
  }
  
  /// Obtenir le facteur de demande pour une localisation
  double _getLocationFactor(String location) {
    String locationKey = location.toLowerCase();
    return _locationFactors[locationKey] ?? 1.0; // Valeur par défaut
  }
  
  /// Déterminer la tendance en fonction du score de demande
  String _getTrend(double score) {
    if (score > 0.8) {
      return 'forte hausse';
    } else if (score > 0.6) {
      return 'hausse modérée';
    } else if (score > 0.4) {
      return 'stable';
    } else if (score > 0.2) {
      return 'baisse modérée';
    } else {
      return 'forte baisse';
    }
  }
  
  /// Générer un insight basé sur le score de demande
  String _generateInsight(Categorie categorie, String location, double score) {
    if (score > 0.8) {
      return 'Forte demande prévue pour ${categorie.nomcategorie} à $location. Une excellente opportunité pour les prestataires.';
    } else if (score > 0.6) {
      return 'Bonne demande anticipée pour ${categorie.nomcategorie} à $location dans les jours à venir.';
    } else if (score > 0.4) {
      return 'Demande modérée prévue pour ${categorie.nomcategorie} à $location. Restez visible pour attirer des clients.';
    } else if (score > 0.2) {
      return 'Demande assez faible pour ${categorie.nomcategorie} à $location. Envisagez des offres promotionnelles.';
    } else {
      return 'Faible demande prévue pour ${categorie.nomcategorie} à $location. Période idéale pour se former ou diversifier vos services.';
    }
  }
  
  /// Générer un insight pour les tendances des catégories
  String _generateTrendInsight(String category, String location, double score) {
    // Calculer un taux de croissance fictif
    double growthRate = ((score - 0.5) * 20.0).clamp(-15.0, 30.0);
    int growthRateInt = growthRate.round();
    
    if (growthRate > 10) {
      return "$category connaît une forte croissance à $location avec +$growthRateInt% d'augmentation de la demande.";
    } else if (growthRate > 5) {
      return "$category est en hausse constante à $location avec +$growthRateInt% de croissance.";
    } else if (growthRate > 0) {
      return "$category montre une légère progression à $location avec +$growthRateInt% de croissance.";
    } else if (growthRate < 0) {
      return "$category est en légère baisse à $location avec $growthRateInt% de diminution.";
    } else {
      return "$category reste stable à $location.";
    }
  }
  
  /// Générer un insight basé sur la localisation
  String _getLocationBasedInsight(String location) {
    final insights = [
      "À $location, la visibilité en ligne est cruciale pour attirer de nouveaux clients.",
      "Les prestataires à $location ont intérêt à mettre en avant leurs avis clients positifs.",
      "Notre analyse montre que les clients de $location privilégient la rapidité d'intervention.",
      "La zone de $location présente une forte concurrence, différenciez-vous par la qualité.",
      "Les habitants de $location recherchent principalement des prestataires disponibles le week-end."
    ];
    
    return insights[_random.nextInt(insights.length)];
  }
  
  /// Générer un insight spécifique à une catégorie pour un prestataire
  String _generateProviderCategoryInsight(Categorie categorie, String location, double score) {
    String categoryName = categorie.nomcategorie;
    
    if (score > 0.7) {
      return "La demande pour $categoryName est forte à $location. C'est le moment idéal pour développer cette activité et augmenter modérément vos tarifs.";
    } else if (score > 0.5) {
      return "Le marché du $categoryName est stable à $location. Continuez à proposer vos services avec une communication régulière.";
    } else if (score > 0.3) {
      return "La demande pour $categoryName est modérée à $location. Envisagez des offres spéciales pour vous démarquer de la concurrence.";
    } else {
      return "Le secteur $categoryName connaît un ralentissement à $location. Diversifiez vos services ou ciblez d'autres zones pour maintenir votre activité.";
    }
  }
  
  /// Générer un conseil de tarification
  String _generatePricingInsight(Categorie categorie, String location) {
    final insights = [
      "Nos données montrent qu'une tarification transparente augmente de 30% les conversions clients pour ${categorie.nomcategorie} à $location.",
      "Les prestataires de ${categorie.nomcategorie} qui proposent des forfaits tout compris ont 25% de clients en plus à $location.",
      "À $location, les clients de ${categorie.nomcategorie} sont prêts à payer plus pour un service rapide et de qualité.",
      "Proposer différentes gammes de prix pour ${categorie.nomcategorie} permet de toucher une clientèle plus large à $location."
    ];
    
    return insights[_random.nextInt(insights.length)];
  }
  
  /// Générer un conseil sur la satisfaction client
  String _generateCustomerSatisfactionInsight() {
    final insights = [
      "Les prestataires qui répondent aux messages en moins de 30 minutes ont un taux de satisfaction client 40% plus élevé.",
      "Proposer un suivi après prestation augmente de 35% les chances d'obtenir des recommandations client.",
      "Les photos de vos réalisations précédentes renforcent la confiance des clients potentiels.",
      "Les clients apprécient particulièrement les prestataires qui respectent scrupuleusement les horaires convenus."
    ];
    
    return insights[_random.nextInt(insights.length)];
  }
  
  /// Générer un insight basé sur les données historiques
  String _generateHistoricalInsight(Categorie categorie, String location, List<double> demandValues) {
    // Calculer la tendance générale
    double firstValue = demandValues.first;
    double lastValue = demandValues.last;
    double change = lastValue - firstValue;
    double percentChange = (change / firstValue * 100).roundToDouble();
    
    String trend = '';
    if (percentChange > 15) {
      trend = 'forte croissance';
    } else if (percentChange > 5) {
      trend = 'croissance modérée';
    } else if (percentChange > -5) {
      trend = 'relative stabilité';
    } else if (percentChange > -15) {
      trend = 'légère baisse';
    } else {
      trend = 'baisse significative';
    }
    
    return "Sur la période analysée, la demande pour ${categorie.nomcategorie} à $location montre une $trend (${percentChange.round()}%). ${_getAdviceBasedOnTrend(trend, categorie.nomcategorie)}";
  }
  
  /// Générer un conseil basé sur la tendance
  String _getAdviceBasedOnTrend(String trend, String categoryName) {
    switch (trend) {
      case 'forte croissance':
        return "Nous vous recommandons d'investir dans ce secteur en expansion et d'optimiser votre capacité de service.";
      case 'croissance modérée':
        return "Cette tendance positive est encourageante, maintenez votre qualité de service pour profiter de cette dynamique.";
      case 'relative stabilité':
        return "Le marché est mature, différenciez-vous par la qualité et les services additionnels.";
      case 'légère baisse':
        return "Restez vigilant, envisagez des actions marketing ciblées pour relancer votre activité.";
      case 'baisse significative':
        return "Nous recommandons de diversifier vos services ou de vous repositionner sur des segments plus porteurs.";
      default:
        return "Surveillez régulièrement l'évolution du marché pour adapter votre stratégie.";
    }
  }
}
