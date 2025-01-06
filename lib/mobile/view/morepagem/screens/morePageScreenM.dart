
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../morepageblocm/morePageBlocM.dart';
import '../morepageblocm/morePageEventM.dart';

class MorePageScreenM extends StatefulWidget {
  const MorePageScreenM({super.key});
  @override
  State<MorePageScreenM> createState() => _MorePagePageScreenStateM();
}

class _MorePagePageScreenStateM extends State<MorePageScreenM> {
  @override
  void initState() {
    BlocProvider.of<MorePageBlocM>(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        // Augmente la hauteur de l'AppBar pour inclure le bouton
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 50.0),
                child: Row(

                  children: [
                    Icon(Icons.menu, size: 25,),

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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 5.0),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 100.0, vertical: 5.0),
                //
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Corps principal de la page
          ],
        ),
      ),
    );
  }

}

