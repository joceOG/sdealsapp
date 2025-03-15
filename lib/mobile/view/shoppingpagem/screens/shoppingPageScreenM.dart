
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../shoppingpageblocm/shoppingPageBlocM.dart';
import '../shoppingpageblocm/shoppingPageEventM.dart';

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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
                child: Row(
                  children: [
                    const Icon(Icons.menu, size: 25),
                    const SizedBox(width: 80),
                    const Text(
                      "SOUTRALI DEALS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                  ],
               ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            hintText: "Rechercher sur Soutralideals",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.gps_fixed, color: Colors.grey),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
              SizedBox(height: 10),
              // Liste horizontale de catégories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryCard('Automobile & Moto', Icons.directions_car),
                    _buildCategoryCard('Immobilier', Icons.house),
                    _buildCategoryCard('Électronique', Icons.electrical_services),
                    _buildCategoryCard('Mode', Icons.style),
                    // Ajoute autant de catégories que nécessaire ici
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Section Top Articles
              const Text(
                'Top Articles',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              // Section pour les images avec noms à droite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopArticle('assets/molly.jpg', 'Molly'),
                  _buildTopArticle('assets/esty.jpg', 'Esty'),
                ],
              ),
              SizedBox(height: 20),
              // Ajout des widgets carrés avec détails produits
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductImage('assets/adidas.jpg'),
                      SizedBox(height: 8),
                      const Text('Nike', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      const Text('Pointures 42-43', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 3),
                      const Text('25.000 Fcfa', style: TextStyle(fontSize: 14, color: Colors.green)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductImage('assets/images/nike-sb.png'),
                      SizedBox(height: 8),
                      Text('Adidas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Pointures 42-43', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 3),
                      Text('30.000 Fcfa', style: TextStyle(fontSize: 14, color: Colors.green)),
                    ],
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
            backgroundColor: Colors.green.withOpacity(0.2),
            child: Icon(icon, size: 30, color: Colors.green),
          ),
          SizedBox(height: 5),
          Text(categoryName, style: TextStyle(fontSize: 16)),
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
        SizedBox(width: 10),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
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




