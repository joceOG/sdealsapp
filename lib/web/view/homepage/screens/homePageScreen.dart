
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';

import '../../../widget/Footer.dart';
import '../homepagebloc/homePageBloc.dart';


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container with text
            Container(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(40.0),
                  child: const Text(
                    'Des centaines de services et autant de prestations de qualités',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // Stack with Image
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 1200,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/accueil.jpg'), // Chemin de l'image
                        fit: BoxFit
                            .fill, // Adapte l'image à la taille du container
                      ),
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
              BlocBuilder<HomePageBloc, HomePageState>(
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
              ),
              child: const Text(
                'Top services',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0 , right: 40.0,),
              height: 260, // Set a height for the container
              child:
              BlocBuilder<HomePageBloc, HomePageState>(
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
            Footer()
          ],
        ),
      ),
    );
  }
}
