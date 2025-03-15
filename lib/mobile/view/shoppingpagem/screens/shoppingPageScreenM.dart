
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
        preferredSize: Size.fromHeight(
            180.0), // Augmente la hauteur de l'AppBar pour inclure le bouton
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 17.0,
                      left: 17.0,
                      right: 17.0,
                    ),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        //border: Border.all(),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/photo_profile.png',))
                    ),
                  ),
                  const SizedBox(width: 270.0,),
                  const Icon(Icons.notifications, size: 34.0,color: Colors.white,)
                ],
              ),

              Column(
                children: [
                  const Text('SOUTRALI DEALS',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 2.0,),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 1.0,),
                        const Icon(Icons.search, color: Colors.black12, size: 20.0,),
                        const SizedBox(width: 2.0,),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 2.0,
                              right: 2.0,
                              bottom: 9.0),
                          width: 250.0,
                          height: 30.0,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Recherchez sur soutrali',
                            ),
                          ),
                        ),
                        const Icon(Icons.location_searching, color: Colors.black12, size: 20.0,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),

                  Container(
                    padding: EdgeInsets.only(
                      left: 4.0,
                      right: 4.0,
                    ),
                    width: 190.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.lightGreenAccent.shade700,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.map,size:20.0, color: Colors.white),
                        SizedBox(height: 4.0,),
                        Text("Toute la Côte d'Ivoire"),
                        SizedBox(width: 4.0,),
                        Icon(Icons.my_location,size: 20.0, color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ajout de la section catégories
              Row(
                children: [
                  Container(
                      width: 10.0,
                      child: Image.asset('assets/rectanglered.png')),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Top Catégories',
                    style: TextStyle(fontSize: 24,
                        fontFamily:'Arial',
                        fontWeight: FontWeight.bold),
                  ),
                ],
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
              SizedBox(height: 20),
              // Section Top Articles
              Row(
                children: [
                  Container(
                      width: 10.0,
                      child: Image.asset('assets/rectanglered.png')),
                  SizedBox(
                    width: 4.0,
                  ),

                  Text(
                    'Top Articles',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
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
                      Text('Nike', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Pointures 42-43', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 3),
                      Text('25.000 Fcfa', style: TextStyle(fontSize: 14, color: Colors.green)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductImage('assets/adidas2.jpg'),
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