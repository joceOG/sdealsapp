
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

import '../../../widget/Footer.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
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
                            'assets/accueil_.jpeg'), // Chemin de l'image
                        fit: BoxFit
                            .fill, // Adapte l'image à la taille du container
                      ),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            const Text(
                              "Métiers" ,
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(height: 38),
                            SizedBox(
                              width: 275, // Largeur du bouton
                              height: 65,
                              child: FilledButton(
                                onPressed: () {
                                  // Action à effectuer lors du clic sur le bouton
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.green, // Couleur de fond verte
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5), // Marges internes
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15), // Bords arrondis
                                  ),
                                ),
                                child: const Text(
                                  'Devenir prestataire',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold), // Couleur du texte
                                ),
                              ),
                            ),

                          ],
                        )),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 550,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 50.0,
                        ),
                        child: const Text(
                            'Que vous recherchiez un DJ, un plombier ou un avocat... '
                                'Nous vous trouvons les meilleurs, gratuitement.',
                            style: TextStyle(
                                fontFamily: 'Krona One', fontSize: 24)),
                      ),
                      Container(
                        width: 550,
                        height: 50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.only(bottom: 3),
                        child: const Text(
                            'Consultez les profils, discutez avec les professionnels, aussi depuis notre application mobile.',
                            style: TextStyle(
                                fontFamily: 'Kumbh Sans', fontSize: 15)
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceEvenly, // Espacement égal entre les widgets
                              children: [
                                Container(
                                  width: 260,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(
                                        10), // Coins arrondis
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/apple.png',
                                        width: 65,
                                        height: 63,
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'Télécharger sur AppStore',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Arial'),
                                          ),
                                          Text(
                                            'AppStore',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontFamily: 'Arial Black'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 260,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(
                                        10), // Coins arrondis
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/playstore.png',
                                        width: 65,
                                        height: 63,
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'Télécharger sur PlayStore',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Arial'),
                                          ),
                                          Text(
                                            'PlayStore',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontFamily: 'Arial Black'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 50.0
                      ),
                    child: Image.asset(
                      'assets/image2.png',
                      width: 400,
                      height: 300,
                    )),
                    )
              ],
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}