import 'package:sdealsapp/web/data/models/prestataire.dart';

/// Modèle pour les explications de correspondance entre prestataires et demandes
class ProviderMatchExplanation {
  /// Critères de correspondance utilisés pour la mise en relation
  final List<String> matchingCriteria;
  
  /// Scores de correspondance par ID de prestataire (entre 0 et 1)
  final Map<String, double> providerScores;
  
  /// Points forts spécifiques par ID de prestataire
  final Map<String, List<String>> providerStrengths;
  
  /// Facteurs qui ont influencé la correspondance
  final List<String> matchFactors;
  
  /// Raisons pour lesquelles certains prestataires ont été filtrés
  final Map<String, String> filterReasons;

  ProviderMatchExplanation({
    this.matchingCriteria = const [],
    this.providerScores = const {},
    this.providerStrengths = const {},
    this.matchFactors = const [],
    this.filterReasons = const {},
  });
}

/// Résultat complet du processus de mise en correspondance
class ProviderMatchResult {
  /// Liste des prestataires correspondants
  final List<Prestataire> providers;
  
  /// Explications sur la mise en correspondance
  final ProviderMatchExplanation explanation;
  
  ProviderMatchResult({
    required this.providers,
    required this.explanation,
  });
}
