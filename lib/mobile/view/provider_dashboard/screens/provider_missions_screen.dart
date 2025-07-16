import 'package:flutter/material.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/widgets/mission_list_item.dart';

class ProviderMissionsScreen extends StatefulWidget {
  const ProviderMissionsScreen({Key? key}) : super(key: key);

  @override
  _ProviderMissionsScreenState createState() => _ProviderMissionsScreenState();
}

class _ProviderMissionsScreenState extends State<ProviderMissionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Données simulées pour les missions
  final List<Map<String, dynamic>> _availableMissions = [
    {
      'title': 'Réparation robinet',
      'location': 'Cocody',
      'price': '25,000 FCFA',
      'urgency': 'Urgent',
      'distance': '1.2 km',
      'clientName': 'Marie K.',
      'clientRating': 4.2,
      'description': 'Fuite importante sous évier cuisine, eau qui s\'accumule...',
    },
    {
      'title': 'Installation climatisation',
      'location': 'Marcory',
      'price': '80,000 FCFA',
      'urgency': 'Standard',
      'distance': '3.5 km',
      'clientName': 'Paul M.',
      'clientRating': 4.8,
      'description': 'Installation de 2 climatiseurs split dans salon et chambre principale...',
    },
    {
      'title': 'Débouchage canalisation',
      'location': 'Yopougon',
      'price': '35,000 FCFA',
      'urgency': 'Standard',
      'distance': '5.1 km',
      'clientName': 'Ahmed T.',
      'clientRating': 3.9,
      'description': 'Évier bouché depuis 2 jours, l\'eau ne s\'évacue plus du tout...',
    },
    {
      'title': 'Remplacement interrupteur',
      'location': 'Abobo',
      'price': '15,000 FCFA',
      'urgency': 'Urgent',
      'distance': '8.3 km',
      'clientName': 'Sophie D.',
      'clientRating': 4.0,
      'description': 'Interrupteur cassé dans salon, risque d\'électrocution...',
    },
  ];
  
  final List<Map<String, dynamic>> _ongoingMissions = [
    {
      'title': 'Installation plomberie salle de bain',
      'location': 'Treichville',
      'price': '120,000 FCFA',
      'urgency': 'En cours',
      'progress': 0.6,
      'clientName': 'Jean K.',
      'dueDate': '18/07/2025',
    },
    {
      'title': 'Réparation climatisation',
      'location': 'Plateau',
      'price': '45,000 FCFA',
      'urgency': 'En cours',
      'progress': 0.3,
      'clientName': 'Fatou B.',
      'dueDate': '15/07/2025',
    },
  ];
  
  final List<Map<String, dynamic>> _completedMissions = [
    {
      'title': 'Installation prise électrique',
      'location': 'Cocody',
      'price': '20,000 FCFA',
      'rating': 5.0,
      'clientName': 'Konan A.',
      'completedDate': '10/07/2025',
    },
    {
      'title': 'Réparation fuite WC',
      'location': 'Yopougon',
      'price': '30,000 FCFA',
      'rating': 4.5,
      'clientName': 'Mariam S.',
      'completedDate': '08/07/2025',
    },
    {
      'title': 'Changement robinetterie',
      'location': 'Marcory',
      'price': '45,000 FCFA',
      'rating': 5.0,
      'clientName': 'Robert L.',
      'completedDate': '05/07/2025',
    },
  ];
  
  final List<Map<String, dynamic>> _rejectedMissions = [
    {
      'title': 'Réparation chauffe-eau',
      'location': 'Port-Bouët',
      'price': '55,000 FCFA',
      'reason': 'Indisponible',
      'clientName': 'David K.',
      'rejectedDate': '11/07/2025',
    },
    {
      'title': 'Pose carrelage',
      'location': 'Koumassi',
      'price': '180,000 FCFA',
      'reason': 'Hors compétences',
      'clientName': 'Aminata D.',
      'rejectedDate': '02/07/2025',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barre de filtres avec TabBar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  icon: Icon(Icons.local_fire_department),
                  text: 'Disponibles',
                ),
                Tab(
                  icon: Icon(Icons.schedule),
                  text: 'En cours',
                ),
                Tab(
                  icon: Icon(Icons.check_circle_outline),
                  text: 'Terminées',
                ),
                Tab(
                  icon: Icon(Icons.cancel_outlined),
                  text: 'Refusées',
                ),
              ],
            ),
          ),
          
          // Zone de recherche et filtres
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher une mission...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                ),
              ],
            ),
          ),
          
          // Contenu des onglets
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Onglet Missions disponibles
                _buildAvailableMissionsTab(),
                
                // Onglet Missions en cours
                _buildOngoingMissionsTab(),
                
                // Onglet Missions terminées
                _buildCompletedMissionsTab(),
                
                // Onglet Missions refusées
                _buildRejectedMissionsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableMissionsTab() {
    if (_availableMissions.isEmpty) {
      return _buildEmptyState('Aucune mission disponible actuellement', Icons.search_off);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _availableMissions.length,
      itemBuilder: (context, index) {
        final mission = _availableMissions[index];
        return MissionListItem(
          title: mission['title'],
          location: mission['location'],
          price: mission['price'],
          urgency: mission['urgency'],
          distance: mission['distance'],
          onTap: () {
            _showMissionDetailsDialog(context, mission);
          },
        );
      },
    );
  }

  Widget _buildOngoingMissionsTab() {
    if (_ongoingMissions.isEmpty) {
      return _buildEmptyState('Aucune mission en cours', Icons.pending_actions);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _ongoingMissions.length,
      itemBuilder: (context, index) {
        final mission = _ongoingMissions[index];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mission['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'EN COURS',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      mission['location'],
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      mission['clientName'],
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text('Livraison: ${mission['dueDate']}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Avancement:'),
                              Text('${(mission['progress'] * 100).toInt()}%'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: mission['progress'],
                              minHeight: 8,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mission['price'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            // Mettre à jour le statut
                          },
                          child: const Text('Mettre à jour'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Terminer la mission
                          },
                          child: const Text('Terminer'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompletedMissionsTab() {
    if (_completedMissions.isEmpty) {
      return _buildEmptyState('Aucune mission terminée', Icons.check_circle_outline);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _completedMissions.length,
      itemBuilder: (context, index) {
        final mission = _completedMissions[index];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mission['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < mission['rating'] ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      mission['location'],
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      mission['clientName'],
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.event_available, size: 16),
                    const SizedBox(width: 4),
                    Text('Terminée le ${mission['completedDate']}'),
                    const Spacer(),
                    Text(
                      mission['price'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Voir détails
                      },
                      child: const Text('Voir détails'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.receipt_long, size: 16),
                      label: const Text('Facture'),
                      onPressed: () {
                        // Voir facture
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRejectedMissionsTab() {
    if (_rejectedMissions.isEmpty) {
      return _buildEmptyState('Aucune mission refusée', Icons.cancel_outlined);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _rejectedMissions.length,
      itemBuilder: (context, index) {
        final mission = _rejectedMissions[index];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mission['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'REFUSÉE',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      mission['location'],
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      mission['clientName'],
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16),
                    const SizedBox(width: 4),
                    Text('Motif: ${mission['reason']}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.event_busy, size: 16),
                    const SizedBox(width: 4),
                    Text('Refusée le ${mission['rejectedDate']}'),
                    const Spacer(),
                    Text(
                      mission['price'],
                      style: TextStyle(
                        color: Colors.grey[600],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showMissionDetailsDialog(BuildContext context, Map<String, dynamic> mission) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mission['urgency'] == 'Urgent'
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.priority_high, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  'URGENT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 8),
                    Text(
                      mission['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white70, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          mission['location'],
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.directions_walk, color: Colors.white70, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          mission['distance'],
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Client
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mission['clientName'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber[700],
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${mission['clientRating']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mission['description'],
                      style: const TextStyle(
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Budget
                    const Text(
                      'Budget',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.payments,
                            color: Colors.green,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            mission['price'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.close),
                      label: const Text('Passer'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.chat),
                      label: const Text('Contacter'),
                      onPressed: () {
                        Navigator.pop(context);
                        // Naviguer vers le chat
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.description),
                      label: const Text('Proposer'),
                      onPressed: () {
                        Navigator.pop(context);
                        // Naviguer vers la création de devis
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtres'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Distance
            const Text('Distance maximale'),
            Slider(
              value: 10,
              min: 1,
              max: 20,
              divisions: 19,
              label: '10 km',
              onChanged: (value) {
                // Mettre à jour la distance
              },
            ),
            
            // Budget
            const Text('Budget'),
            RangeSlider(
              values: const RangeValues(10000, 100000),
              min: 5000,
              max: 200000,
              divisions: 39,
              labels: const RangeLabels('10,000 FCFA', '100,000 FCFA'),
              onChanged: (values) {
                // Mettre à jour le budget
              },
            ),
            
            // Urgence
            const Text('Urgence'),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Immédiat'),
                  selected: true,
                  onSelected: (selected) {
                    // Mettre à jour le filtre
                  },
                ),
                FilterChip(
                  label: const Text('Cette semaine'),
                  selected: true,
                  onSelected: (selected) {
                    // Mettre à jour le filtre
                  },
                ),
                FilterChip(
                  label: const Text('Flexible'),
                  selected: true,
                  onSelected: (selected) {
                    // Mettre à jour le filtre
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Appliquer les filtres
            },
            child: const Text('Appliquer'),
          ),
        ],
      ),
    );
  }
}
