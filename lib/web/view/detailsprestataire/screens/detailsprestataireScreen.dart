import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';
import 'package:sdealsapp/web/widget/Footer.dart';

import '../detailsprestatairebloc/detailsprestataireBloc.dart';

class DetailsPrestataireScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final detailsPrestataireBloc =
        BlocProvider.of<DetailsPrestataireBloc>(context);
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
              margin: EdgeInsets.only(
                top: 50.0,
                  left: 50.0,
                  right: 50.0,
                  bottom: 50.0,

              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('assets/img haut.jpeg',
                      width: 1300,
                      height: 200,
                      fit: BoxFit.cover,),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 50.0,
                  left: 50.0,
                  right: 50.0,
                  bottom: 50.0),

              child: Row(
                children: [
                  // Section gauche : Image et description
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                      child : Image.asset(
                          'assets/prestataire.jpeg',
                          width: 600.0,
                          height: 300,
                          fit: BoxFit.cover,),
                      )
                    ],
                  ),
                  const SizedBox(width: 30.0,),
                  // Section droite : Détails et bouton contacter

                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Voici une brève description du prestataire. Ce texte peut contenir des informations sur les services offerts, les compétences spécifiques, et d\'autres détails pertinents.',
                        style: TextStyle(fontSize: 20.0, fontFamily: 'arial'),
                      ),
                      const SizedBox(height: 15.0),
                      const Row(
                        children: [
                          Text('Prix',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'Neohead'
                          ),),
                          SizedBox(
                            width: 35.0,
                          ),
                          Text('5000 FCFA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: 'Neohead'
                            ),)
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                           child: Image.asset(
                              'assets/coiffeur.jpeg',
                              width: 70,
                            ),
                          ),
                          const SizedBox(width: 50.0),
                          const Column( crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kouassi Vincent',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 25.0,

                              ),),
                              SizedBox(height: 10.0),
                              Text('Cooiffeur',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),)
                            ],
                          ),
                          const SizedBox(width: 50.0),

                          ElevatedButton(onPressed: (){},
                            child: const Icon(Icons.phone,
                            color: Colors.green,
                            size: 45,),),

                          const SizedBox(width: 20.0),

                          ElevatedButton(onPressed: (){},
                            child: const Icon(Icons.message,
                            color: Colors.green,
                            size: 45.0,),)
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 50.0
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('assets/map.png',
                    width: 1300,
                    height: 300,
                    fit: BoxFit.cover,),
                  )
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
