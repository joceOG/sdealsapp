import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';

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
            // Stack with Image
            Stack(
              children: [
                  Container(
                    width: 2000,
                    height: 300,
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
              child: Container(
                padding: const EdgeInsets.only(
                  left: 80.0,
                  right: 40.0,
                  top: 20.0,
                  bottom: 5.0,
                ),
                child: const Text(
                  'Catégories',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold ),
                ),
              ),
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
                  'Top catégories',
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
                          child: Image.network(
                            'https://via.placeholder.com/150', // Replace with your image URLs
                            width: 220,
                            height: 280,
                            fit: BoxFit.cover,
                          ),
                        ),
                    )
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
