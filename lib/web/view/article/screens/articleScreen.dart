import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/Footer.dart';

import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../articlebloc/articleBloc.dart';

class DetailsArticleScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 2000,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/emarche.png'), // Chemin de l'image
                  fit: BoxFit
                      .fill, // Adapte l'image à la taille du container
                ),
              ),
            ),
            Container(
              width: 2000,
              height: 200,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 1150,
                    height: 180,
                    padding: EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/emarche.png'), // Chemin de l'image
                        fit: BoxFit
                            .fill, // Adapte l'image à la taille du container
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 600,
                    height: 180,
                    padding: EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/emarche.png'), // Chemin de l'image
                        fit: BoxFit
                            .fill, // Adapte l'image à la taille du container
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // You can add other widgets like buttons or overlays here
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: <Widget>[
                  // Section gauche : Image et description
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Grande image
                          SizedBox(
                            height: 480.0,
                            child : Image.asset(
                              'assets/prestataire.jpeg',
                              width: 600, // Largeur de l'image en pixels
                              height: 470,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // Texte de description
                          const Text(
                            'Description du Prestataire',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const SizedBox(
                            width: 300,
                            child: Text(
                              'Voici une brève description du prestataire. Ce texte peut contenir des informations sur les services offerts, les compétences spécifiques, et d\'autres détails pertinents.',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Section droite : Détails et bouton contacter
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Nom : Jean Dupont',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Téléphone : +225 01 23 45 67 89',
                          style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Email : jean.dupont@example.com',
                          style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Adresse : Cocody, Abidjan',
                          style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold),
                        ),
                        const SizedBox( height: 20,),
                        // Bouton Contacter
                        ElevatedButton(
                          onPressed: () {
                            // Action lors du clic sur le bouton
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                            textStyle: const TextStyle(fontSize: 16.0),
                          ),
                          child: const Text('Contacter'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}


