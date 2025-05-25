import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/homepagem/homepageblocm/homePageStateM.dart';
import 'package:sdealsapp/mobile/view/jobpagem/jobpageblocm/jobPageBlocM.dart';
import '../../profilpagem/screens/profilPageScreenM.dart';
import '../jobpageblocm/jobPageBlocM.dart';
import '../jobpageblocm/jobPageEventM.dart';

class JobPageScreenM extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => JobPageBlocM()..add(LoadCategorieDataM()),
        child: SingleChildScrollView(
          //padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Image.asset('assets/_acceuil_.jpeg'),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre des catégories
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Catégories',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        // Bouton "Voir plus"
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
                    const SizedBox(height: 10),
                    // Liste horizontale des catégories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryCard('Auto & Moto', Icons.directions_car),
                          _buildCategoryCard('Immobilier', Icons.house),
                          _buildCategoryCard(
                              'Électronique', Icons.electrical_services),
                          _buildCategoryCard('Mode', Icons.style),
                          // Ajoute autant de catégories que nécessaire ici
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Titre des services
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Services',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        // Bouton "Voir plus"
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
                    const SizedBox(height: 10),
                    // CarouselSlider pour afficher les services
                    CarouselSlider.builder(
                      itemCount: categoriesSoutraliData.length,
                      options: CarouselOptions(
                        height: 140.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final item = categoriesSoutraliData[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                  child: Image.asset(
                                    item['image']!,
                                    fit: BoxFit.cover,
                                    width: 300.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2.0, left: 5.0, bottom: 2.0),
                                child: Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'rif',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
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

  // Fonction pour créer une carte de catégorie
  Widget _buildCategoryCard(String categoryName, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            // ignore: deprecated_member_use
            backgroundColor: Colors.green.withOpacity(0.2),
            child: Icon(icon, size: 30, color: Colors.green),
          ),
          const SizedBox(height: 5),
          Text(categoryName, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Liste des données du carousel (à remplacer par les données réelles) soutralideals
const List<Map<String, String>> categoriesSoutraliData = [
  {
    "image": "assets/categories/Image1.png",
    "title": "Plombier",
  },
  {
    "image": "assets/categories/Image2.png",
    "title": "Coiffeurs",
  },
  {
    "image": "assets/categories/Image3.png",
    "title": "Photographes",
  },
  {
    "image": "assets/categories/Image4.png",
    "title": "Nettoyage",
  },
  {
    "image": "assets/categories/Image5.png",
    "title": "Menuiserie",
  },
  // Ajoutez les autres éléments ici...
];