import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';

import '../connexionbloc/connexionBloc.dart';

class ConnexionScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final connrexionBloc = BlocProvider.of<ConnexionBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 180,
        backgroundColor: Colors.white,
        title: Container(
            height: 155,
            child:
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          tooltip: 'Show Snackbar',
                          onPressed: () {
                            context.go('/');
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0 , bottom: 20.0),
                              child: Image.asset(
                                'assets/logo.jpeg',
                                width: 78, // Largeur de l'image en pixels
                                height: 60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 2.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.0,
                            offset: Offset(0, 2), // Décalage pour créer l'élévation
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
             ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 80,
            left: screenWidth/3,
            child: Image.asset(
              'assets/imageconnexion.png',
              width: 650,
              height: 500,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 35,
            left: screenWidth/4,
            child:
                Container (
            width: 500,
            height: 500,
            padding: const EdgeInsets.all(25.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  offset: Offset(0, 2), // Décalage pour créer l'élévation
                ),
              ],
            ),
            child:  Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Nom',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Entrez votre nom',
                    ),
                  ),
                  SizedBox(height: 20), // Espacement entre les champs
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Entrez votre email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: FilledButton(
                      onPressed: () {
                        context.go('/connexion');
                        // Action à effectuer lors du clic sur le bouton
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green, // Couleur de fond verte
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15), // Marges internes
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Bords arrondis
                        ),
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // Couleur du texte
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          )

        ],
      )
    );
  }
}


