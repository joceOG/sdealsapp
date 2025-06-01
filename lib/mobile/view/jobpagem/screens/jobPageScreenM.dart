import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/jobpagem/screens/detailPageScreenM.dart';
import '../jobpageblocm/jobPageBlocM.dart';
import '../jobpageblocm/jobPageEventM.dart';

class JobPageScreenM extends StatelessWidget {
  const JobPageScreenM({super.key});

  // Liste des catégories (à remplacer par nos données API)
  final List<Map<String, dynamic>> categories = const [
    {'name': 'Auto & Moto', 'icon': Icons.directions_car},
    {'name': 'Immobilier', 'icon': Icons.house},
    {'name': 'Électronique', 'icon': Icons.electrical_services},
    {'name': 'Mode', 'icon': Icons.style},
    {'name': 'Maison', 'icon': Icons.chair},
    {'name': 'Sport', 'icon': Icons.sports_soccer},
    {'name': 'Jeux', 'icon': Icons.videogame_asset},
    {'name': 'Santé', 'icon': Icons.health_and_safety},
  ];

  // Données fictives pour les carrousels (à remplacer par API)
  static const List<Map<String, String>> topServices = [
    {"image": "assets/categories/Image1.png", "title": "Plombier"},
    {"image": "assets/categories/Image2.png", "title": "Coiffeur"},
    {"image": "assets/categories/Image3.png", "title": "Photographe"},
    {"image": "assets/categories/Image4.png", "title": "Nettoyage"},
    {"image": "assets/categories/Image5.png", "title": "Menuiserie"},
  ];

  static const List<Map<String, String>> topPrestataires = [
    {
      "image": "assets/categories/Image1.png",
      "title": "Électricien",
      "subtitle": "Disponible 24h/24",
      "location": "Abidjan",
      "rating": "4.8"
    },
    {
      "image": "assets/categories/Image2.png",
      "title": "Maçon",
      "subtitle": "Spécialiste rénovation",
      "location": "yamoussoukro",
      "rating": "4.6"
    },
    {
      "image": "assets/categories/Image3.png",
      "title": "Peintre",
      "subtitle": "Peinture intérieure/extérieure",
      "location": "Abobo PK18",
      "rating": "4.7"
    },
    {
      "image": "assets/categories/Image4.png",
      "title": "Jardinier",
      "subtitle": "Entretien & aménagement",
      "location": "Cocody",
      "rating": "4.5"
    },
    {
      "image": "assets/categories/Image5.png",
      "title": "Cuisinier",
      "subtitle": "Cuisine africaine & européenne",
      "location": "Plateau",
      "rating": "4.9"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => JobPageBlocM()..add(LoadCategorieDataM()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                // Liste horizontale des catégories
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return _buildCategoryCard(cat['name'], cat['icon']);
                    },
                  ),
                ),
                const SizedBox(height: 28),

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
                // Carrousel Top Services
                CarouselSlider.builder(
                  itemCount: topServices.length,
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    viewportFraction: 0.78,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final item = topServices[index];
                    return GestureDetector(
                      onTap: () {
                        // Redirection vers la page de détails du service
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
                                child: Image.asset(
                                  item['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Text(
                                item['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14.0),
                                child: Image.asset(
                                  item['image']!,
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 180,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Infos du prestataire
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item['title'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        color: Colors.black87,
                                      ),
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

  /// Widget pour une carte de catégorie
  Widget _buildCategoryCard(String categoryName, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.green.withOpacity(0.13),
          child: Icon(icon, size: 26, color: Colors.green),
        ),
        const SizedBox(height: 6),
        Text(
          categoryName,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
