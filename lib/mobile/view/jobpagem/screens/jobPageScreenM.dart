import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/serviceproviderwelcomepagem/screens/serviceProviderWelcomeScreenM.dart';
import 'package:sdealsapp/mobile/view/jobpagem/screens/detailPageScreenM.dart';
import 'package:sdealsapp/mobile/view/common/screens/ai_assistant_chat_screen.dart';
import 'package:sdealsapp/mobile/view/common/widgets/ai_price_estimator_widget.dart';

import '../../../../data/models/service.dart';
import '../../chatpagem/chatpageblocm/chatPageEventM.dart';
import '../jobpageblocm/jobPageBlocM.dart';
import '../jobpageblocm/jobPageStateM.dart';
import '../jobpageblocm/jobPageEventM.dart';

class JobPageScreenM extends StatelessWidget {
  final List<dynamic> categories;

  const JobPageScreenM({super.key, this.categories = const []});

  // Catégories par défaut si pas de données API
  final List<Map<String, dynamic>> defaultCategories = const [
    {'name': 'Auto & Moto', 'icon': Icons.directions_car, 'badge': ''},
    {'name': 'Immobilier', 'icon': Icons.house, 'badge': 'Promo'},
    {'name': 'Électronique', 'icon': Icons.electrical_services, 'badge': ''},
    {'name': 'Mode', 'icon': Icons.style, 'badge': 'Nouveau'},
    {'name': 'Maison', 'icon': Icons.chair, 'badge': ''},
    {'name': 'Sport', 'icon': Icons.sports_soccer, 'badge': 'Top'},
    {'name': 'Jeux', 'icon': Icons.videogame_asset, 'badge': ''},
    {'name': 'Santé', 'icon': Icons.health_and_safety, 'badge': ''},
  ];

  // Données de Stories (à remplacer par API)
  static const List<Map<String, String>> stories = [
    {"image": "assets/categories/Image1.png", "title": "Promo"},
    {"image": "assets/categories/Image2.png", "title": "Conseil"},
    {"image": "assets/categories/Image3.png", "title": "Bon plan"},
    {"image": "assets/categories/Image4.png", "title": "Tuto"},
    {"image": "assets/categories/Image5.png", "title": "Nouveau"},
  ];

  // Messages promotionnels pour la bannière
  static const List<String> bannerMessages = [
    "✨ Obtenez 10% de réduction sur votre première commande !",
    "🎯 Trouvez le prestataire idéal à proximité",
    "🛠️ Des services de qualité à portée de main",
    "💼 Rejoignez notre communauté de prestataires",
  ];

  // Données fictives pour les carrousels (à remplacer par API)
  static const List<Map<String, String>> topServices = [
    {
      "image": "assets/categories/Image1.png",
      "title": "Plombier",
      "price": "5000"
    },
    {
      "image": "assets/categories/Image2.png",
      "title": "Coiffeur",
      "price": "3500"
    },
    {
      "image": "assets/categories/Image3.png",
      "title": "Photographe",
      "price": "10000"
    },
    {
      "image": "assets/categories/Image4.png",
      "title": "Nettoyage",
      "price": "2500"
    },
    {
      "image": "assets/categories/Image5.png",
      "title": "Menuiserie",
      "price": "7000"
    },
  ];

  static const List<Map<String, dynamic>> topPrestataires = [
    {
      "image": "assets/categories/Image1.png",
      "title": "Électricien",
      "subtitle": "Disponible 24h/24",
      "location": "Abidjan",
      "rating": "4.8",
      "verified": true,
      "online": true
    },
    {
      "image": "assets/categories/Image2.png",
      "title": "Maçon",
      "subtitle": "Spécialiste rénovation",
      "location": "yamoussoukro",
      "rating": "4.6",
      "verified": false,
      "online": false
    },
    {
      "image": "assets/categories/Image3.png",
      "title": "Peintre",
      "subtitle": "Peinture intérieure/extérieure",
      "location": "Abobo PK18",
      "rating": "4.7",
      "verified": true,
      "online": true
    },
    {
      "image": "assets/categories/Image4.png",
      "title": "Jardinier",
      "subtitle": "Entretien & aménagement",
      "location": "Cocody",
      "rating": "4.5",
      "verified": false,
      "online": true
    },
    {
      "image": "assets/categories/Image5.png",
      "title": "Cuisinier",
      "subtitle": "Cuisine africaine & européenne",
      "location": "Plateau",
      "rating": "4.9",
      "verified": true,
      "online": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Convertir les objets Categorie en maps utilisables par l'interface
    List<Map<String, dynamic>> displayCategories = [];

    if (categories.isNotEmpty) {
      print(
          'JobPageScreenM: Utilisation de ${categories.length} catégories depuis l\'API');
      // Utiliser les catégories de l'API
      displayCategories = categories
          .map((cat) => {
                'name': cat.nomcategorie,
                'icon': Icons
                    .category, // Par défaut, car l'API ne fournit pas d'icônes
                'badge': '',
                'id': cat.idcategorie,
                'image': cat.imagecategorie
              })
          .toList();
    } else {
      // Utiliser les catégories par défaut
      displayCategories = defaultCategories;
      print('JobPageScreenM: Utilisation des catégories par défaut');
    }

     return BlocProvider(
      create: (_) => JobPageBlocM()
        ..add(LoadCategorieDataJobM())
        ..add(LoadServiceDataJobM())
       ,
      child: Scaffold(
        backgroundColor: Colors.white,
        // AppBar avec bouton SoutraPay comme dans les autres onglets
        appBar: AppBar(
          title: const Text('Métiers',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green,
          elevation: 0,
          actions: [
            // Bouton SoutraPay inspiré de la page Freelance
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/wallet');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                icon: const Icon(Icons.account_balance_wallet, size: 16),
                label: const Text('💳 SoutraPay',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
            // Bouton Assistant IA
            IconButton(
              icon: const Icon(Icons.smart_toy_outlined, color: Colors.white),
              tooltip: 'Assistant IA',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AIAssistantChatScreen()),
                );
              },
            ),
            // Icône notifications
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stories Instagram-style
                _buildStoriesSection(),
                const SizedBox(height: 16),

                // Bannière promotionnelle
                _buildPromoBanner(context),
                const SizedBox(height: 20),

                // Titre catégories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Catégories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Voir plus',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Liste horizontale des catégories avec design amélioré

                BlocBuilder<JobPageBlocM, JobPageStateM>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.green));
                    }
                    if (state.error.isNotEmpty) {
                      return Text("Erreur: ${state.error}",
                          style: const TextStyle(color: Colors.red));
                    }
                    if (state.listItems.isEmpty) {
                      return const Text("Aucune catégorie disponible");
                    }

                    return SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.listItems.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final cat = state.listItems[index];
                          return _buildCategoryCardWithImage(
                            cat.nomcategorie,
                            cat.imagecategorie,
                            _getCategoryIcon(cat.nomcategorie),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Titre Top Services
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Services',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Voir plus',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Estimation IA de prix pour un service populaire
                AIPriceEstimatorWidget(
                  serviceCategory: topServices.isNotEmpty ? topServices[0]['title']! : 'Service',
                  location: 'Abidjan',
                  jobDescription: 'Besoin standard',
                ),
                const SizedBox(height: 16),
                // Carrousel Top Services
                BlocBuilder<JobPageBlocM, JobPageStateM>(
                  builder: (context, state) {
                    if (state.isLoading2) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.listItems2.isEmpty) {
                      return const Center(child: Text('Aucun service disponible'));
                    }

                    return CarouselSlider.builder(
                      itemCount: state.listItems2.length,
                      options: CarouselOptions(
                        height: 180.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        viewportFraction: 0.78,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final Service item = state.listItems2[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailPage(
                                  title: item.nomservice,
                                  image: item.imageservice,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            color: Colors.green.withOpacity(0.07),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(14.0),
                                    ),
                                    child: item.imageservice.isNotEmpty
                                        ? Image.network(
                                      item.imageservice,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                        : Image.asset(
                                      'assets/default.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.nomservice,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'À partir de ${item.prixmoyen} FCFA/h',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Catégorie: ${item.categorie?.nomcategorie}',
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 11.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Titre Top Prestataires
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Prestataires',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Voir plus',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // À la une cette semaine
                _buildFeaturedSection(),
                const SizedBox(height: 24),

                // Carrousel Top Prestataires (design différent)
                CarouselSlider.builder(
                  itemCount: topPrestataires.length,
                  options: CarouselOptions(
                    height: 170.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final item = topPrestataires[index];
                    return GestureDetector(
                      onTap: () {
                        // Redirection vers la page de détails du prestataire
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              title: item['title']!,
                              image: item['image']!,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              // Image du prestataire
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14.0),
                                    child: Image.asset(
                                      item['image']!,
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 130,
                                    ),
                                  ),
                                  // Indicateur en ligne
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: item['online'] == true
                                            ? Colors.green
                                            : Colors.grey,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              // Infos du prestataire
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          item['title'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        if (item['verified'] == true)
                                          const Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Icon(Icons.verified,
                                                color: Colors.green, size: 16),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['subtitle'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 15, color: Colors.green),
                                        const SizedBox(width: 4),
                                        Text(
                                          item['location'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.star,
                                            size: 15, color: Colors.amber),
                                        const SizedBox(width: 2),
                                        Text(
                                          item['rating'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Action contacter
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        minimumSize:
                                            const Size(double.infinity, 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text('Contacter'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Section Stories
  Widget _buildStoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Découvrir',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.orange, Colors.pink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipOval(
                          child: Image.asset(
                            story['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      story['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Bannière promotionnelle
  Widget _buildPromoBanner(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.green, Color(0xFF66BB6A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CarouselSlider.builder(
            itemCount: bannerMessages.length,
            options: CarouselOptions(
              height: 60,
              autoPlay: true,
              viewportFraction: 1.0,
              autoPlayInterval: const Duration(seconds: 4),
            ),
            itemBuilder: (context, index, realIndex) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    bannerMessages[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
        // Bouton "Devenir prestataire"
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            // Navigation vers la page d'accueil prestataire
            GoRouter.of(context).push(
              '/serviceProviderWelcome',
              extra: categories,
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.handyman, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Devenir prestataire',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Carte de catégorie améliorée avec couleur personnalisée
  Widget _buildCategoryCardImproved(
      String name, IconData icon, Color backgroundColor) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: backgroundColor, size: 32),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour attribuer une icône selon le nom de la catégorie
  IconData _getCategoryIcon(String name) {
    // Par défaut
    IconData icon = Icons.category;

    final lowerName = name.toLowerCase();

    if (lowerName.contains('auto') || lowerName.contains('moto')) {
      return Icons.directions_car;
    } else if (lowerName.contains('immobilier') ||
        lowerName.contains('maison')) {
      return Icons.house;
    } else if (lowerName.contains('électronique') ||
        lowerName.contains('electronique')) {
      return Icons.devices;
    } else if (lowerName.contains('tech')) {
      return Icons.electrical_services;
    } else if (lowerName.contains('mode') || lowerName.contains('vêtement')) {
      return Icons.style;
    } else if (lowerName.contains('meuble')) {
      return Icons.chair;
    } else if (lowerName.contains('sport')) {
      return Icons.sports_soccer;
    } else if (lowerName.contains('jeu')) {
      return Icons.videogame_asset;
    } else if (lowerName.contains('santé') || lowerName.contains('sante')) {
      return Icons.health_and_safety;
    } else if (lowerName.contains('coiff') || lowerName.contains('beauté')) {
      return Icons.face;
    } else if (lowerName.contains('plomb') || lowerName.contains('eau')) {
      return Icons.plumbing;
    } else if (lowerName.contains('électricité') ||
        lowerName.contains('electricité')) {
      return Icons.electrical_services;
    } else if (lowerName.contains('livraison') ||
        lowerName.contains('transport')) {
      return Icons.delivery_dining;
    } else if (lowerName.contains('menuis') || lowerName.contains('bois')) {
      return Icons.carpenter;
    }

    return icon;
  }

  // Section À la une cette semaine
  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.star_border, color: Colors.amber),
                SizedBox(width: 6),
                Text(
                  'À la une cette semaine',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Voir plus',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
              image: AssetImage('assets/categories/Image3.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'POPULAIRE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Amadou K. - Plombier Professionnel',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '15 ans d\'expérience - Disponible 24/7',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ✅ Carte Catégorie avec Image API
  Widget _buildCategoryCardWithImage(String name, String? imageUrl, IconData fallbackIcon) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(fallbackIcon, color: Colors.green, size: 32),
              ),
            )
          else
            Icon(fallbackIcon, color: Colors.green, size: 40),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ),
    );
  }

  /// Widget pour une carte de catégorie
  Widget _buildCategoryCard(String categoryName, IconData icon,
      {String badge = ''}) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(35),
          onTap: () {},
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.green.withOpacity(0.15),
                    child: Icon(icon, size: 28, color: Colors.green),
                  ),
                  if (badge.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: badge == 'Promo'
                              ? Colors.orange
                              : badge == 'Nouveau'
                                  ? Colors.blue
                                  : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                categoryName,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
