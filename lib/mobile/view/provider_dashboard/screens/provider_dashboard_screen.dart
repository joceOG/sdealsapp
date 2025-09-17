import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/provider_dashboardblocm/provider_dashboard_bloc.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/provider_dashboardblocm/provider_dashboard_event.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/provider_dashboardblocm/provider_dashboard_state.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/widgets/ai_insights_widget.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/widgets/dashboard_stat_card.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/widgets/mission_list_item.dart';
import 'package:sdealsapp/data/models/categorie.dart';

class ProviderDashboardScreen extends StatefulWidget {
  const ProviderDashboardScreen({Key? key}) : super(key: key);

  @override
  _ProviderDashboardScreenState createState() => _ProviderDashboardScreenState();
}

class _ProviderDashboardScreenState extends State<ProviderDashboardScreen> {
  late ProviderDashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    _dashboardBloc = ProviderDashboardBloc();
    _dashboardBloc.add(LoadDashboardDataEvent());
  }

  @override
  void dispose() {
    _dashboardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _dashboardBloc,
      child: BlocBuilder<ProviderDashboardBloc, ProviderDashboardState>(
        builder: (context, state) {
          if (state is ProviderDashboardInitialState || 
              state is ProviderDashboardLoadingState) {
            return _buildLoadingView();
          } else if (state is ProviderDashboardLoadedState) {
            return _buildDashboardView(context, state);
          } else if (state is ProviderDashboardUpdatingState) {
            // Créer un état temporaire de type LoadedState à partir de l'état Updating
            final loadedState = ProviderDashboardLoadedState(
              providerData: state.providerData,
              providerCategories: state.providerCategories,
              location: state.location
            );
            return _buildDashboardView(context, loadedState);
          } else if (state is ProviderDashboardErrorState) {
            return _buildErrorView(state.message);
          } else {
            // État non géré
            return Center(child: Text('État non géré: ${state.runtimeType}'));
          }
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Erreur de chargement',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _dashboardBloc.add(LoadDashboardDataEvent());
            },
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardView(BuildContext context, ProviderDashboardLoadedState state) {
    // Récupérer les informations du prestataire
    final providerName = state.providerData['name'] as String;
    final rating = state.providerData['rating'] as double;
    final completedJobs = state.providerData['completedJobs'] as int;
    final revenue = 450000; // Simulé pour l'exemple
    final loyalClients = 3; // Simulé pour l'exemple
    
    // Missions simulées à proximité
    final nearbyMissions = [
      {
        'title': 'Réparation robinet',
        'location': 'Cocody',
        'price': '25,000 FCFA',
        'urgency': 'Urgent',
        'distance': '1.2 km',
      },
      {
        'title': 'Installation climatisation',
        'location': 'Marcory',
        'price': '80,000 FCFA',
        'urgency': 'Standard',
        'distance': '3.5 km',
      },
      {
        'title': 'Débouchage canalisation',
        'location': 'Yopougon',
        'price': '35,000 FCFA',
        'urgency': 'Standard',
        'distance': '5.1 km',
      },
    ];

    // Statistiques de performance
    final Map<String, dynamic> performance = {
      'responseRate': 95,
      'completedMissions': 12,
      'totalMissions': 13,
      'satisfiedClients': 100,
    };

    return RefreshIndicator(
      onRefresh: () async {
        _dashboardBloc.add(LoadDashboardDataEvent());
        // Attendre un peu pour simuler le rafraîchissement
        return Future.delayed(const Duration(milliseconds: 800));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre de bienvenue
              Text(
                'Bonjour, $providerName!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Voici votre activité ce mois-ci',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Statistiques du mois
              const Text(
                '📊 Statistiques du mois',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.assignment_turned_in,
                      title: 'Missions',
                      value: '$completedJobs',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.star,
                      title: 'Note moyenne',
                      value: '$rating/5',
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.payments,
                      title: 'Revenus',
                      value: '${revenue / 1000}k FCFA',
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.people,
                      title: 'Clients fidèles',
                      value: '$loyalClients',
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Missions à proximité
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '🎯 Missions disponibles près de vous',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '(${nearbyMissions.length})',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...nearbyMissions.map((mission) => MissionListItem(
                title: mission['title'] as String,
                location: mission['location'] as String,
                price: mission['price'] as String,
                urgency: mission['urgency'] as String,
                distance: mission['distance'] as String,
                onTap: () {
                  // Navigation vers les détails de la mission
                },
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // Naviguer vers toutes les missions
                    },
                    child: const Text('Voir toutes les missions →'),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Actions rapides
              const Text(
                '⚡ Actions rapides',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.description,
                    label: 'Créer un devis',
                    onTap: () {
                      // Naviguer vers la création de devis
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.bar_chart,
                    label: 'Mes revenus',
                    onTap: () {
                      // Naviguer vers les revenus
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.star_rate,
                    label: 'Mes avis',
                    onTap: () {
                      // Naviguer vers les avis
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Insights IA
              if (state.providerCategories.isNotEmpty)
                _buildAIInsightsSection(context, state),
              
              const SizedBox(height: 24),

              // Performance
              const Text(
                '📈 Performance ce mois',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildPerformanceItem(
                icon: Icons.reply_all,
                title: 'Taux de réponse',
                value: '${performance['responseRate']}%',
                color: Colors.green,
              ),
              _buildPerformanceItem(
                icon: Icons.assignment_turned_in,
                title: 'Missions terminées',
                value: '${performance['completedMissions']}/${performance['totalMissions']}',
                color: Colors.blue,
              ),
              _buildPerformanceItem(
                icon: Icons.sentiment_very_satisfied,
                title: 'Clients satisfaits',
                value: '${performance['satisfiedClients']}%',
                color: Colors.amber,
              ),
              const SizedBox(height: 24),

              // Section motivation
              _buildMotivationSection(context),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIInsightsSection(BuildContext context, ProviderDashboardLoadedState state) {
    // Si nous avons déjà chargé des insights
    if (state is ProviderDashboardInsightsLoadedState) {
      return AIInsightsWidget(insights: state.insights);
    }
    
    // Sinon, on affiche un bouton pour les charger
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Insights IA - Analyse de Marché',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Notre IA peut analyser le marché et vous fournir des conseils personnalisés pour optimiser votre activité.',
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.insights),
                label: const Text('Générer des insights IA'),
                onPressed: () {
                  context.read<ProviderDashboardBloc>().add(GetProviderInsightsEvent());
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(title),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.emoji_events, color: Colors.amber),
                  SizedBox(width: 8),
                  Text(
                    'Top Prestataire du mois',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Objectif : 15 missions ce mois',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 12 / 15, // 12 missions sur 15
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '12/15 complétées',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.tips_and_updates, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Conseil : Répondez rapidement aux demandes pour augmenter vos chances d\'être sélectionné.',
                      style: TextStyle(
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
