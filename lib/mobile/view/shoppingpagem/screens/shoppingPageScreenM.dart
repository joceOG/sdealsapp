import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../shoppingpageblocm/shoppingPageBlocM.dart';
import '../shoppingpageblocm/shoppingPageEventM.dart';
import 'productDetailsScreenM.dart';

class ShoppingPageScreenM  extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => ShoppingPageBlocM()..add(LoadCategorieDataM()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ajout de la section catégories
                const Text(
                  'Top Catégories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Liste horizontale de catégories
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
                // Section Top Articles
                const Text(
                  'Nos partenaires',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                // Section pour les images avec noms à droite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTopArticle('assets/molly.jpg', 'Samsung'),
                    _buildTopArticle('assets/esty.jpg', 'XIAOMI'),
                    _buildTopArticle('assets/esty.jpg', 'Nasco'),
                  ],
                ),
                const SizedBox(height: 20),
                // Ajout des widgets carrés avec détails produits
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Action pour rediriger vers la page de détails du produit
                        //context.go('/productDetails');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductDetails(),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProductImage('assets/adidas.jpg'),
                          const SizedBox(height: 8),
                          const Text('Nike',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          const Text('Pointures 42-43',
                              style: TextStyle(fontSize: 14)),
                          const SizedBox(height: 3),
                          const Text('25.000 Fcfa',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Action pour rediriger vers la page de détails du produit
                        //context.go('/ProductDetails');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductDetails(),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProductImage('assets/adidas.jpg'),
                          const SizedBox(height: 8),
                          const Text('Adidas',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          const Text('Pointures 42-43',
                              style: TextStyle(fontSize: 14)),
                          const SizedBox(height: 3),
                          const Text('30.000 Fcfa',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

  // Fonction pour créer un widget représentant un article avec une photo et un nom à droite
  Widget _buildTopArticle(String imagePath, String name) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(width: 10),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Fonction pour créer un widget image de produit
  Widget _buildProductImage(String imagePath) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: 120,
          width: double.infinity,
        ),
      ),
    );
  }
}
