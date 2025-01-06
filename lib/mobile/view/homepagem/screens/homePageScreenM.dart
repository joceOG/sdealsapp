
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/homepagem/homepageblocm/homePageStateM.dart';
import '../homepageblocm/homePageBlocM.dart';
import '../homepageblocm/homePageEventM.dart';

class HomePageScreenM extends StatefulWidget {
  const HomePageScreenM({super.key});
  @override
  State<HomePageScreenM> createState() => _HomePageScreenStateM();
}

class _HomePageScreenStateM extends State<HomePageScreenM> {
  @override
  void initState() {
    BlocProvider.of<HomePageBlocM>(context).add(LoadCategorieDataM());
    super.initState();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180.0), // Augmente la hauteur de l'AppBar pour inclure le bouton
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.jpeg'), // Exemple d'image
                    ),
                    SizedBox(width: 20),
                    const Text(
                      "SOUTRALI DEALS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
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
                      const Expanded(
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
                        icon: Icon(Icons.map, color: Colors.grey),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green, // Couleur du texte et des icônes
                    backgroundColor: Colors.transparent, // Couleur de fond
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    elevation: 5,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map),
                      SizedBox(width: 0),
                      Text(
                        "Toute la Cote d'ivoire",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Icon(Icons.gps_fixed),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                      height: 3,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green)
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0,
                    children: [
                      SizedBox(
                        child: Image.asset('assets/chat.png' ,fit: BoxFit.cover,),
                        width: 70,
                        height: 50,
                      ),
                      SizedBox(
                        child: Image.asset('assets/cuisinier.png' ,fit: BoxFit.cover,),
                        width: 70,
                        height: 50,
                      ),
                      SizedBox(
                        child: Image.asset('assets/photographe.png' ,fit: BoxFit.cover,),
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,

                        child: Image.asset('assets/peintre.png' ,fit: BoxFit.cover,),
                      ),
                      SizedBox(

                        child: Image.asset('assets/phone.png' ,fit: BoxFit.cover,),
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,
                      ),SizedBox(
                        child: Image.asset('assets/profil.png' ,fit: BoxFit.cover,),
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10, child: Text(
              "Nos Produits",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),),
          ],
        ),

      ),
    );

  }
}