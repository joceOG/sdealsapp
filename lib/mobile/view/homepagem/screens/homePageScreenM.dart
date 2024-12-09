
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/homepagem/homepageblocm/homePageStateM.dart';

import '../homepageblocm/homePageBlocM.dart';


class HomePageScreenM extends StatefulWidget {
  const HomePageScreenM({super.key});
  @override
  State<HomePageScreenM> createState() => _HomePageScreenStateM();
}

class _HomePageScreenStateM extends State<HomePageScreenM> {
  @override
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
                      backgroundImage: AssetImage('assets/images/logo.png'), // Exemple d'image
                    ),
                    SizedBox(width: 20),
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
                  child: Row(
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

        padding: EdgeInsets.all(1.0),
        child: Column(
          children: [
            SizedBox(height: 10),
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
                      Container(
                        child: Image.asset('assets/images/chat.png' ,fit: BoxFit.cover,),
                        width: 70,
                        height: 50,
                      ),
                      Container(
                        child: Image.asset('assets/images/cuisinier.png' ,fit: BoxFit.cover,),
                        width: 70,
                        height: 50,
                      ),
                      Container(
                        child: Image.asset('assets/images/photographe.png' ,fit: BoxFit.cover,),
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,
                      ),
                      Container(

                        child: Image.asset('assets/images/peintre.png' ,fit: BoxFit.cover,),
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,
                      ),
                      Container(

                        child: Image.asset('assets/images/phone.png' ,fit: BoxFit.cover,),
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,
                      ),Container(

                        child: Image.asset('assets/images/profil.png' ,fit: BoxFit.cover,),
                        width: MediaQuery.of(context).size.width / 10.0,
                        height: MediaQuery.of(context).size.width / 10.0,
                      ),

                    ],

                  ),


                ],


              ),

            ),
            SizedBox(height: 10, child: Container(
              child: Text(
                "Nos Produits",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),),




          ],
        ),

      ),
    );

  }
}