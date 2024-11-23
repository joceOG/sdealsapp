import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../widget/AppBarWidget.dart';
import '../../../widget/Footer.dart';
import '../emarchebloc/emarcheBloc.dart';
import '../emarchebloc/emarcheState.dart';



class EmarcheScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emarcheBloc = BlocProvider.of<EmarcheBloc>(context);

    return Scaffold(
      appBar:  AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack with Image
            Stack(
              children: [
                Container(
                  width: 2000,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/emarche.png'), // Chemin de l'image
                      fit: BoxFit
                          .fill, // Adapte l'image à la taille du container
                    ),
                  ),
                ),
                // You can add other widgets like buttons or overlays here
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 80.0,
                right: 40.0,
                top: 20.0,
                bottom: 5.0,
              ),
              child:  Row(
                children: [
                  Image.asset(
                    'assets/rectanglered.png',
                    width: 20,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Catégories',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.red),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 80.0,
                right: 40.0,
                top: 20.0,
                bottom: 5.0,
              ),
              child: const Text(
                'Top catégories',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0 , right: 40.0,),
              height: 260, // Set a height for the container
              child:
              BlocBuilder<EmarcheBloc, EmarcheState>(
                builder: (context, state) {
                  return
                    state.listItems == null ?
                    Center(child: CircularProgressIndicator()) :
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listItems!.length, // Number of images
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              context.go('/prestataire');
                            },
                            child:
                            Stack(
                                children: [
                                  FractionallySizedBox(
                                      alignment: Alignment.bottomCenter, // Aligner en haut à gauche
                                      // Prendre la moitié de la largeur
                                      heightFactor: 0.7, // Prendre la moitié de la hauteur
                                      child: Image.network(
                                        state.listItems![index].imagecategorie, // Replace with your image URLs
                                        width: 215,
                                        height: 240,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Text('Failed to render image');
                                        },
                                      )
                                  ),
                                  // Half of the container's height for a circular image
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 20.0),
                                      child: Container(
                                        width: 200,
                                        padding: EdgeInsets.all(16),
                                        color: Colors.white,
                                        child:
                                        Text(state.listItems![index].nomcategorie , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ),
                                ]
                            )

                        );
                      },
                    );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 80.0,
                right: 40.0,
                top: 20.0,
                bottom: 5.0,
              ),
              child:  Row(
                children: [
                  Image.asset(
                    'assets/rectanglered.png',
                    width: 20,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Ce mois',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.red),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 80.0,
                right: 40.0,
                top: 20.0,
                bottom: 5.0,
              ),
              child: Row(
                children: [
                  const Text(
                    'Meilleurs produits',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () {
                      context.go('/connexion');
                      // Action à effectuer lors du clic sur le bouton
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red, // Couleur de fond verte
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15), // Marges internes
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Bords arrondis
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Voir tout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), // Couleur du texte
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              height: 400, // Set a height for the container
              child:
              BlocBuilder<EmarcheBloc, EmarcheState>(
                builder: (context, state) {
                  return
                    state.listItems2 == null ?
                    Center(child: CircularProgressIndicator()) :
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listItems2!.length, // Number of images
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              context.go('/prestataire');
                            },
                            child:
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Half of the container's height for a circular image
                                    child: Image.network(
                                      state.listItems2![index].photoArticle, // Replace with your image URLs
                                      width: 220,
                                      height: 305,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(state.listItems2![index].nomArticle , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                Text(state.listItems2![index].prixArticle , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.red),),
                                Container(

                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:
                                      [
                                        Row(
                                          children: List.generate(5, (index) {
                                            return Icon(
                                              index < 4 ? Icons.star : Icons.star_border,
                                              color: Colors.yellow[700],
                                              size: 16,
                                            );
                                          }),
                                        ),

                                        const Text(' ( 65 ) '),
                                      ]
                                  ),
                                ),
                              ],
                            ),

                        );
                      },
                    );
                },
              ),
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}