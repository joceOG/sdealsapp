
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/searchpagem/searchpageblocm/searchPageStateM.dart';
import '../searchpageblocm/searchPageBlocM.dart';
import '../searchpageblocm/searchPageEventM.dart';


class SearchPageScreenM extends StatefulWidget {
  const SearchPageScreenM({super.key});
  @override
  State<SearchPageScreenM> createState() => _SearchPageScreenStateM();
}

class _SearchPageScreenStateM extends State<SearchPageScreenM> {
  @override
  void initState() {
    BlocProvider.of<SearchPageBlocM>(context);
    super.initState();
  }
  Widget build(BuildContext context) {

    return  Scaffold(
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
                    Icon(Icons.menu, size: 25),
                    SizedBox(width: 80),
                    Text(
                      "SOUTRALI DEALS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.notifications),
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
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            hintText: "Rechercher sur Soutralideals",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.gps_fixed, color: Colors.grey),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 5.0),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Les boutons de navigation (Prestation de service, E-commerce, Crypto Store, Petite annonce)
            SizedBox(
              height: 100, // Adjust height if needed
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildNavigationButton("Prestation de service", Icons.build, Colors.blue),
                    _buildNavigationButton("E-commerce", Icons.shopping_cart, Colors.red),
                    _buildNavigationButton("Crypto Store", Icons.currency_bitcoin, Colors.orange),
                    _buildNavigationButton("Petite annonce", Icons.announcement, Colors.purple),
                    // Add more buttons here if needed
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),  // Espacement entre les sections

            // Section Métiers
            Text(
              'Métiers',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildCategoryItem('Maçonnerie', 'Catégorie', 'assets/images/maconnerie.png'),
                  _buildCategoryItem('Mécanique', 'Catégorie', 'assets/images/mecanique.png'),
                  _buildCategoryItem('Plomberie', 'Catégorie', 'assets/images/plomberie.jpg'),
                  _buildCategoryItem('Menuisier', 'Catégorie', 'assets/images/menuisier.png'),

                  SizedBox(height: 20),

                  // Section Prestataires
                  Text(
                    'Prestataires',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProviderItem('Marc', '1000 FCFA', 'assets/images/marc.jpg'),
                      _buildProviderItem('Elie', '1000 FCFA', 'assets/images/elie.jpg'),
                      _buildProviderItem('Tratra', '1000 FCFA', 'assets/images/tratra.jpg'),
                      _buildProviderItem('OLI', '1000 FCFA', 'assets/images/oli.jpg'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}


// Fonction pour créer un bouton de navigation en haut
Widget _buildNavigationButton(String title, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0), // Espacement entre les boutons
    child: Column(
      mainAxisSize: MainAxisSize.min,  // Limite la taille au minimum requis
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, size: 25, color: color),
        ),
        SizedBox(height: 8),  // Espacement ajusté entre l'icône et le texte
        Text(
          title,
          textAlign: TextAlign.center,  // Centrage du texte
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),  // Espace supplémentaire entre les éléments
      ],
    ),
  );
}

// Fonction pour créer un item de catégorie (Métiers)
Widget _buildCategoryItem(String title, String subtitle, String imagePath) {
  return ListTile(
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage(imagePath), // Assurez-vous que les images sont dans votre dossier assets
    ),
    title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
    onTap: () {
      // Action à faire quand on clique sur l'item
    },
  );
}

// Fonction pour créer un item de prestataire
Widget _buildProviderItem(String name, String price, String imagePath) {
  return Column(
    children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage(imagePath), // Assurez-vous que les images sont dans votre dossier assets
      ),
      SizedBox(height: 5),
      Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(price, style: TextStyle(color: Colors.green)),
    ],
  );
}
