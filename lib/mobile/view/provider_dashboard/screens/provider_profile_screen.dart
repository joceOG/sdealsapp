import 'package:flutter/material.dart';

class ProviderProfileScreen extends StatefulWidget {
  const ProviderProfileScreen({Key? key}) : super(key: key);

  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  // Données simulées pour le profil prestataire
  final Map<String, dynamic> _providerData = {
    'name': 'Amadou Diallo',
    'profession': 'Plombier & Électricien',
    'rating': 4.8,
    'reviewCount': 24,
    'memberSince': 'Mai 2025',
    'location': 'Abidjan, Cocody',
    'avatar': 'AD',
    'bio': 'Professionnel avec 15 ans d\'expérience en plomberie et électricité. '
        'Spécialisé dans les installations domestiques et dépannages urgents. '
        'Service rapide et travail soigné garanti.',
    'phone': '+225 07 XX XX XX',
    'email': 'amadou.diallo@example.com',
    'completionRate': 98,
    'responseRate': 95,
    'skills': [
      {'name': 'Plomberie', 'level': 0.9},
      {'name': 'Électricité', 'level': 0.85},
      {'name': 'Climatisation', 'level': 0.7},
      {'name': 'Carrelage', 'level': 0.5},
    ],
    'certifications': [
      'Certificat Professionnel de Plomberie - 2015',
      'Habilitation Électrique B1V - 2018',
      'Formation Sécurité au Travail - 2023',
    ],
    'languages': [
      {'name': 'Français', 'level': 'Courant'},
      {'name': 'Anglais', 'level': 'Intermédiaire'},
      {'name': 'Malinké', 'level': 'Natif'},
    ],
    'portfolioItems': [
      {
        'title': 'Rénovation salle de bain complète',
        'image': 'bathroom.jpg',
        'description': 'Installation complète de la plomberie et électricité',
      },
      {
        'title': 'Installation tableau électrique',
        'image': 'electrical.jpg',
        'description': 'Mise aux normes d\'un tableau électrique résidentiel',
      },
      {
        'title': 'Réparation fuite complexe',
        'image': 'plumbing.jpg',
        'description': 'Détection et réparation d\'une fuite souterraine',
      },
    ],
    'services': [
      {'name': 'Plomberie urgence', 'price': '15,000 FCFA/h', 'duration': '1-2h'},
      {'name': 'Installation sanitaire', 'price': '25,000 FCFA', 'duration': '2-3h'},
      {'name': 'Dépannage électrique', 'price': '20,000 FCFA', 'duration': '1-3h'},
      {'name': 'Installation électrique complète', 'price': 'Sur devis', 'duration': 'Variable'},
    ],
    'accountSettings': {
      'notifications': true,
      'displayPhone': true,
      'autoAcceptMissions': false,
      'darkMode': false,
      'language': 'Français',
    },
  };

  final List<Map<String, dynamic>> _reviews = [
    {
      'clientName': 'Sophie K.',
      'rating': 5,
      'comment': 'Excellent service, rapide et efficace. Je recommande vivement !',
      'date': '12/07/2025',
    },
    {
      'clientName': 'Jean M.',
      'rating': 5,
      'comment': 'Très professionnel et ponctuel. Travail impeccable.',
      'date': '05/07/2025',
    },
    {
      'clientName': 'Marie T.',
      'rating': 4,
      'comment': 'Bon travail, mais un peu de retard sur l\'horaire prévu.',
      'date': '28/06/2025',
    },
    {
      'clientName': 'Konan A.',
      'rating': 5,
      'comment': 'Intervention rapide et efficace pour une urgence. Merci !',
      'date': '15/06/2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: _buildProfileHeader(),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: const [
                      Tab(text: 'Infos'),
                      Tab(text: 'Compétences'),
                      Tab(text: 'Portfolio'),
                      Tab(text: 'Avis'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Onglet Infos
              _buildInfoTab(),
              
              // Onglet Compétences
              _buildSkillsTab(),
              
              // Onglet Portfolio
              _buildPortfolioTab(),
              
              // Onglet Avis
              _buildReviewsTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  _providerData['avatar'],
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Informations de base
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _providerData['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _providerData['profession'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber[700],
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${_providerData['rating']} (${_providerData['reviewCount']} avis)',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Bouton d'édition
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Ouvrir l'écran d'édition du profil
                  _showEditProfileDialog();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                'Depuis',
                _providerData['memberSince'],
                Icons.calendar_today,
              ),
              _buildStatItem(
                'Complétion',
                '${_providerData['completionRate']}%',
                Icons.task_alt,
              ),
              _buildStatItem(
                'Réponse',
                '${_providerData['responseRate']}%',
                Icons.reply_all,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // À propos
          const Text(
            'À propos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _providerData['bio'],
            style: const TextStyle(
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          
          // Contact
          const Text(
            'Contact',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildContactItem(
            Icons.phone,
            'Téléphone',
            _providerData['phone'],
          ),
          _buildContactItem(
            Icons.email,
            'Email',
            _providerData['email'],
          ),
          _buildContactItem(
            Icons.location_on,
            'Localisation',
            _providerData['location'],
          ),
          const SizedBox(height: 16),
          
          // Services et tarifs
          const Text(
            'Services et tarifs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...(_providerData['services'] as List).map((service) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                service['duration'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        service['price'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 16),
          
          // Langues
          const Text(
            'Langues',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...(_providerData['languages'] as List).map((language) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 12),
                  Text(
                    language['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    language['level'],
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 32),
          
          // Paramètres du compte
          const Text(
            'Paramètres du compte',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingSwitch(
            'Recevoir des notifications',
            _providerData['accountSettings']['notifications'],
            (value) {
              // Mise à jour de la valeur
            },
          ),
          _buildSettingSwitch(
            'Afficher mon numéro de téléphone',
            _providerData['accountSettings']['displayPhone'],
            (value) {
              // Mise à jour de la valeur
            },
          ),
          _buildSettingSwitch(
            'Acceptation automatique des missions',
            _providerData['accountSettings']['autoAcceptMissions'],
            (value) {
              // Mise à jour de la valeur
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Langue de l\'application'),
            subtitle: Text(_providerData['accountSettings']['language']),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Ouvrir sélection de la langue
            },
          ),
          const SizedBox(height: 24),
          
          // Boutons d'action
          Center(
            child: Column(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Déconnexion'),
                  onPressed: () {
                    // Déconnexion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 45),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Désactiver le compte
                  },
                  child: const Text('Désactiver temporairement mon compte'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildSkillsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compétences
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Compétences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Ajouter'),
                onPressed: () {
                  // Ajouter une compétence
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...(_providerData['skills'] as List).map((skill) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        skill['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${(skill['level'] * 100).toInt()}%',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: skill['level'],
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 24),
          
          // Certifications
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Certifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Ajouter'),
                onPressed: () {
                  // Ajouter une certification
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...(_providerData['certifications'] as List).map((certification) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified,
                    color: Colors.amber[700],
                  ),
                ),
                title: Text(certification),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Voir détails de la certification
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPortfolioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Portfolio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_photo_alternate, size: 16),
                label: const Text('Ajouter'),
                onPressed: () {
                  // Ajouter une réalisation au portfolio
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: (_providerData['portfolioItems'] as List).length,
            itemBuilder: (context, index) {
              final item = (_providerData['portfolioItems'] as List)[index];
              
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    // Afficher le détail du projet
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image placeholder
                      Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[600],
                            size: 48,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Avis clients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${_providerData['rating']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                ' (${_providerData['reviewCount']} avis)',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Liste des avis
          ..._reviews.map((review) {
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
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            review['clientName'].split(' ')[0][0] + review['clientName'].split(' ')[1][0],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review['clientName'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              review['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < review['rating'] ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review['comment'],
                      style: const TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          
          // Bouton "voir plus"
          if (_reviews.length >= 4) Center(
            child: TextButton(
              onPressed: () {
                // Voir plus d'avis
              },
              child: const Text('Voir tous les avis →'),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le profil'),
        content: const SingleChildScrollView(
          child: Text('Ici apparaîtrait un formulaire complet d\'édition du profil'),
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
              // Sauvegarder les modifications
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
