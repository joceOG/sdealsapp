import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';
import 'package:sdealsapp/web/widget/Footer2.dart';

import '../../../widget/Footer.dart';
import '../homepagebloc/homePageBloc.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homePageBloc = BlocProvider.of<HomePageBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
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
              child: Container(
                padding: const EdgeInsets.only(
                  left: 80.0,
                  right: 40.0,
                  top: 20.0,
                  bottom: 5.0,
                ),
                child: const Text(
                  'Top catégorie',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              height: 300, // Set a height for the container
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20, // Number of images
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          context.go('/prestataire');
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              40.0), // Half of the container's height for a circular image
                          child: Image.asset(
                            'assets/art1.jpeg', // Replace with your image URLs
                            width: 220,
                            height: 280,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ));
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
                        child: Text(
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
                        child: Text(
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
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/apple.png',
                                        width: 65,
                                        height: 63,
                                      ),
                                      Column(
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
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(
                                        10), // Coins arrondis
                                  ),
                                ),
                                Container(
                                  width: 260,
                                  height: 80,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/playstore.png',
                                        width: 65,
                                        height: 63,
                                      ),
                                      Column(
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
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(
                                        10), // Coins arrondis
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
                    child: Image.asset(
                  'assets/image2.png',
                  width: 400,
                  height: 300,
                ))
              ],
            ),

            Footer(),
            Footer2()
          ],
        ),
      ),
    );
  }
}
