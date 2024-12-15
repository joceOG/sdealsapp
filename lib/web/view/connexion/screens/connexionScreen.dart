import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';
import 'package:sdealsapp/web/widget/Footer.dart';

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
                        height: 550,
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
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Connecté vous pour decouvrir toutes nos fonctionnalités',
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 15.0,),
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
                              SizedBox(height: 20), // Espacement entre les champs
                              const Text(
                                'Password *',
                                style: TextStyle(fontSize: 18),
                              ),
                              passwordFileidExample(),
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
                                      SizedBox(width: 90.0,),
                                      Icon(Icons.navigation,
                                      size: 30.0,),
                                      SizedBox(width: 30.0,),
                                      Text(
                                        'Se connecter',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  side: BorderSide(color: Colors.black12),

                                ),
                                onPressed: (){},
                                child: Row(
                                  children: [
                                    SizedBox(width: 60.0,),
                                    Image.asset('assets/google.png',
                                    width: 40.0,),

                                    SizedBox(width: 30.0,),

                                    const Text(
                                      'Continuez avec Google',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                      ), // Couleur du texte
                                    ),
                                  ],
                                ),),
                              SizedBox(height: 20.0,),

                              Row(
                                children: [
                                  SizedBox(width: 70.0,),
                                  Text('Vous n’avez pas de compte ? '),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                      onPressed: (){
                                      context.go('/inscription');
                                      },
                                      child: Text('Créer un compte'))
                                ],
                              )

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

class passwordFileid extends State<passwordFileidExample> {
  bool textVue=true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Container(

      child: TextField(
        obscureText: textVue,
        decoration: InputDecoration(
            hintText: 'Entrez le mot de passe',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(onPressed: (){
              setState(() {
                textVue=!textVue;
              });
            },
                icon: Icon(
                    textVue?
                    Icons.visibility:
                    Icons.visibility_off
                ))
        ),
      ),
    );

  }



}

class passwordFileidExample  extends StatefulWidget{
  @override
  passwordFileid createState()=> passwordFileid();
}