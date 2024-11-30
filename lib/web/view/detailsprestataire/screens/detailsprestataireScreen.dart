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
              width: 800,
              margin: EdgeInsets.only(top: 100.0),
              padding: EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(),
              ),
              child: Row(
                children: [
                  // Section gauche : Image et description

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/prestataire.jpeg',),
                    ],
                  ),
                  SizedBox(width: 50.0,),
                  // Section droite : Détails et bouton contacter

                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voici une brève description du prestataire. Ce texte peut contenir des informations sur les services offerts, les compétences spécifiques, et d\'autres détails pertinents.',
                        style: TextStyle(fontSize: 18.0, fontFamily: 'arial'),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Text('Prix'),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('5000 FCFA')
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Image.asset(
                            'assets/coiffeur.jpeg',
                            width: 50.0,
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            children: [
                              Text('Kouassi Vincent'),
                              SizedBox(height: 5.0),
                              Text('Cooiffeur')
                            ],
                          ),
                          SizedBox(width: 10.0),
                          Icon(Icons.call),
                          SizedBox(width: 10.0),
                          Icon(Icons.perm_phone_msg),
                        ],
                      )
                    ],
                  ))
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
