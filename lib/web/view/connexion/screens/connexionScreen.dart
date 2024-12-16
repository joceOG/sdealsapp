import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/Footer.dart';

import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../connexionbloc/connexionBloc.dart';

class ConnexionScreen extends StatelessWidget {
  const ConnexionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final connrexionBloc = BlocProvider.of<ConnexionBloc>(context);
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
                  padding: EdgeInsets.only(
                    top: 50.0
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/cnx.jpg',
                        width: 650,
                        height: 500,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 80.0,),
                      Container(
                        width: 500,
                        height: 500,
                        padding: const EdgeInsets.all(25.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              offset: Offset(0, 2), // Décalage pour créer l'élévation
                            ),
                          ],
                        ),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Bienvenue',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black),
                              ),
                              const Text(
                                'Connecté vous pour decouvrir toutes nos fonctionnalités',
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const Text(
                                'Nom *',
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
                                'Email *',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Entrez votre email',
                                ),
                              ),
                              const SizedBox(height: 20),

                              FilledButton(
                                  onPressed: () {
                                    context.go('/connexion');
                                    // Action à effectuer lors du clic sur le bouton
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor:
                                    Colors.green, // Couleur de fond verte
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15), // Marges internes
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15), // Bords arrondis
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(width: 10.0,),
                                      Icon(Icons.navigation),
                                      SizedBox(width: 120.0,),
                                      Text(
                                        'Se connecter',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold), // Couleur du texte
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 30.0,
                              ),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 4, // Épaisseur du trait
                                      color: Colors.black12, // Couleur du trait
                                      //endIndent: 15, // Espacement entre le trait et le texte
                                    ),
                                  ),
                                  Text(' OU '),
                                  Expanded(
                                    child: Divider(
                                      thickness: 4, // Épaisseur du trait
                                      color: Colors.black12, // Couleur du trait
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              ElevatedButton(onPressed: (){},
                                child: Row(
                                  children: [
                                    Image.asset('assets/google.png'),

                                    SizedBox(width: 30.0,),

                                    const Text(
                                      'Continuez avec Google',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ), // Couleur du texte
                                    ),
                                  ],
                                ),)
                            ],
                          ),
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
