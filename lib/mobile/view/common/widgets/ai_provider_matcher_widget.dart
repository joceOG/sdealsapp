import 'package:flutter/material.dart';
import 'package:sdealsapp/ai_services/interfaces/provider_matching_service.dart';
import 'package:sdealsapp/ai_services/mock_implementations/mock_provider_matching_service.dart';
import 'package:sdealsapp/ai_services/models/provider_match_explanation.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/data/models/prestataire.dart';

/// Widget pour afficher les prestataires recommandés par IA
class AIProviderMatcherWidget extends StatefulWidget {
  final String serviceType;
  final String location;
  final List<String>? preferences;
  final Function(Prestataire)? onProviderSelected;

  const AIProviderMatcherWidget({
    Key? key,
    required this.serviceType,
    required this.location,
    this.preferences,
    this.onProviderSelected,
  }) : super(key: key);

  @override
  _AIProviderMatcherWidgetState createState() => _AIProviderMatcherWidgetState();
}

class _AIProviderMatcherWidgetState extends State<AIProviderMatcherWidget> {
  final ProviderMatchingService _matchingService = MockProviderMatchingService();
  List<Prestataire>? _matchedProviders;
  ProviderMatchExplanation? _matchExplanation;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _findMatchingProviders();
  }

  /// Récupère les prestataires correspondants via le service IA
  Future<void> _findMatchingProviders() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      // Convertir le type de service en requête
      final query = "${widget.serviceType} ${widget.preferences?.join(' ') ?? ''}".trim();
      
      // Appeler le service de matching
      final recommendations = await _matchingService.getRecommendedProviders(
        query: query,
        location: widget.location,
        maxResults: 5,
      );
      
      // Créer une explication de mise en correspondance à partir des recommandations
      final matchCriteria = [widget.serviceType, widget.location];
      if (widget.preferences != null && widget.preferences!.isNotEmpty) {
        matchCriteria.addAll(widget.preferences!);
      }
      
      final providerScores = <String, double>{};
      final providerStrengths = <String, List<String>>{};
      final providers = <Prestataire>[];
      
      // Traiter les recommandations
      for (final recommendation in recommendations) {
        providers.add(recommendation.prestataire);
        
        // Utiliser l'ID comme clé pour les scores et forces
        final idKey = recommendation.prestataire.utilisateur.idutilisateur;
        providerScores[idKey] = recommendation.matchScore;
        providerStrengths[idKey] = [recommendation.matchReason];
        if (recommendation.matchDetails.isNotEmpty) {
          recommendation.matchDetails.forEach((key, value) {
            if (value is String) {
              providerStrengths[idKey]?.add(value);
            }
          });
        }
      }
      
      // Créer l'objet d'explication
      final explanation = ProviderMatchExplanation(
        matchingCriteria: matchCriteria,
        providerScores: providerScores,
        providerStrengths: providerStrengths,
      );
      
      setState(() {
        _matchedProviders = providers;
        _matchExplanation = explanation;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Impossible de trouver des prestataires correspondants: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Prestataires recommandés par IA",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _findMatchingProviders,
                  tooltip: 'Actualiser les recommandations',
                ),
              ],
            ),
            const Divider(),
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_error != null)
              Center(
                child: Column(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[700]),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: Icon(Icons.refresh),
                      label: const Text('Réessayer'),
                      onPressed: _findMatchingProviders,
                    ),
                  ],
                ),
              )
            else if (_matchedProviders == null || _matchedProviders!.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 48, color: Colors.grey[500]),
                      const SizedBox(height: 8),
                      Text(
                        'Aucun prestataire correspondant trouvé',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              _buildMatchingResults(context),
          ],
        ),
      ),
    );
  }

  /// Construit la section des résultats de matching
  Widget _buildMatchingResults(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_matchExplanation?.matchingCriteria.isNotEmpty ?? false) ...[
          const Text(
            'Critères de recherche:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _matchExplanation!.matchingCriteria
                .map((criteria) => _buildCriteriaChip(criteria))
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
        
        const Text(
          'Prestataires recommandés:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(),
          itemCount: _matchedProviders!.length > 3 ? 3 : _matchedProviders!.length,
          itemBuilder: (context, index) {
            final provider = _matchedProviders![index];
            final matchScore = _matchExplanation?.providerScores[provider.utilisateur.idutilisateur] ?? 0.0;
            final matchPercent = (matchScore * 100).toInt();
            
            return InkWell(
              onTap: () => widget.onProviderSelected?.call(provider),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    // Avatar du prestataire
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Informations principales du prestataire
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  provider.utilisateur.prenom,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Match $matchPercent%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          
                          // Localisation du prestataire
                          Text(provider.localisation),
                          const SizedBox(height: 4),
                          
                          // Note et avis (simulés)
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                provider.utilisateur.note!,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text(' (12 avis)'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          
                          // Points forts du prestataire
                          if (_matchExplanation?.providerStrengths[provider.utilisateur.idutilisateur] != null)
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: _matchExplanation!.providerStrengths[provider.utilisateur.idutilisateur]!
                                  .take(2)
                                  .map((strength) => _buildStrengthTag(strength))
                                  .toList(),
                            ),
                        ],
                      ),
                    ),
                    
                    // Icône de flèche pour indiquer l'action
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        
        if (_matchedProviders!.length > 3)
          Center(
            child: TextButton(
              child: const Text('Voir plus de prestataires'),
              onPressed: () {
                // Action pour voir plus de prestataires
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fonctionnalité à implémenter')),
                );
              },
            ),
          ),
      ],
    );
  }

  /// Crée une puce pour afficher un critère de recherche
  Widget _buildCriteriaChip(String criteria) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(criteria),
    );
  }

  /// Crée une puce pour afficher un point fort du prestataire
  Widget _buildStrengthTag(String strength) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(color: Colors.green[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        strength,
        style: TextStyle(
          color: Colors.green[800],
          fontSize: 12,
        ),
      ),
    );
  }
}
