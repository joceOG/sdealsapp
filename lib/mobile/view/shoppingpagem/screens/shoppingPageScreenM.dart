import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../shoppingpageblocm/shoppingPageBlocM.dart';
import '../shoppingpageblocm/shoppingPageEventM.dart';
import 'productDetailsScreenM.dart';

// Exemple de modèle produit (à remplacer par nos modèles API)
class Product {
  final String name;
  final String image;
  final String size;
  final String price;

  Product({
    required this.name,
    required this.image,
    required this.size,
    required this.price,
  });
}

class ShoppingPageScreenM extends StatelessWidget {
  //const ShoppingPageScreenM({super.key});

  // Liste de produits fictifs (remplacer par nos données API)
  List<Product> get products => [
        Product(
            name: 'Nike',
            image: 'assets/products/1.png',
            size: 'Pointures 42-43',
            price: '25.000 Fcfa'),
        Product(
            name: 'Adidas',
            image: 'assets/products/2.png',
            size: 'Pointures 42-43',
            price: '30.000 Fcfa'),
        Product(
            name: 'Puma',
            image: 'assets/products/3.png',
            size: 'Pointures 40-44',
            price: '22.000 Fcfa'),
        Product(
            name: 'Reebok',
            image: 'assets/products/4.png',
            size: 'Pointures 41-45',
            price: '28.000 Fcfa'),
        Product(
            name: 'Fila',
            image: 'assets/products/5.png',
            size: 'Pointures 39-43',
            price: '20.000 Fcfa'),
        Product(
            name: 'Converse',
            image: 'assets/products/6.png',
            size: 'Pointures 38-42',
            price: '27.000 Fcfa'),
        Product(
            name: 'Vans',
            image: 'assets/products/7.png',
            size: 'Pointures 40-44',
            price: '24.000 Fcfa'),
        Product(
            name: 'New Balance',
            image: 'assets/products/8.png',
            size: 'Pointures 41-45',
            price: '29.000 Fcfa'),
        Product(
            name: 'Asics',
            image: 'assets/products/9.png',
            size: 'Pointures 40-43',
            price: '23.000 Fcfa'),
        Product(
            name: 'Jordan',
            image: 'assets/products/10.png',
            size: 'Pointures 42-46',
            price: '35.000 Fcfa'),
      ];

  // Liste de catégories fictives (remplacer par nos données API)
  final List<Map<String, dynamic>> categories = [
    {'name': 'Auto & Moto', 'icon': Icons.directions_car},
    {'name': 'Immobilier', 'icon': Icons.house},
    {'name': 'Électronique', 'icon': Icons.electrical_services},
    {'name': 'Mode', 'icon': Icons.style},
    {'name': 'Maison', 'icon': Icons.chair},
    {'name': 'Sport', 'icon': Icons.sports_soccer},
    {'name': 'Jeux', 'icon': Icons.videogame_asset},
    {'name': 'Santé', 'icon': Icons.health_and_safety},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => ShoppingPageBlocM()..add(LoadCategorieDataM()),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Liste horizontale de catégories
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return _buildCategoryCard(cat['name'], cat['icon']);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Grille de produits scrollable
                Expanded(
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 produits par ligne
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.72, // Ajuste la hauteur des cartes
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(context, product);
                    },
                  ),
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
          backgroundColor: Colors.green.withOpacity(0.15),
          child: Icon(icon, size: 28, color: Colors.green),
        ),
        const SizedBox(height: 6),
        Text(
          categoryName,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  /// Widget pour une carte produit minimaliste
  Widget _buildProductCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        // Naviguer vers la page de détails du produit
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetails(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.07),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image produit
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.image,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            // Nom produit
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Taille ou description courte
            Text(
              product.size,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Prix
            Text(
              product.price,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
