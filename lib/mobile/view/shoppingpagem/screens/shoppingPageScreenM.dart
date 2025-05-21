import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../shoppingpageblocm/shoppingPageBlocM.dart';
import '../shoppingpageblocm/shoppingPageEventM.dart';
import 'productDetailsScreenM.dart';

class ShoppingPageScreenM extends StatefulWidget {
  const ShoppingPageScreenM({super.key});
  @override
  State<ShoppingPageScreenM> createState() => _ShoppingPageScreenStateM();
}

class _ShoppingPageScreenStateM extends State<ShoppingPageScreenM> {
  @override
  void initState() {
    BlocProvider.of<ShoppingPageBlocM>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(165),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu, color: Colors.white, size: 32),
                        IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.white, size: 32),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'SOUTRALI DEALS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: Colors.green.shade200, width: 1.4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.07),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Material(
                                color: Colors.green,
                                shape: const CircleBorder(),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Icon(Icons.search_rounded,
                                      color: Colors.white, size: 22),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: TextField(
                                  style: TextStyle(fontSize: 16),
                                  cursorColor: Colors.green,
                                  decoration: InputDecoration(
                                    hintText: 'Rechercher sur soutralideals',
                                    hintStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
      width: MediaQuery.of(context).size.width * 0.45,
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
