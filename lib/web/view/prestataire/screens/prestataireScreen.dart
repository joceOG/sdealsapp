import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../widget/Footer.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../prestatairebloc/prestataireBloc.dart';


const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PrestataireScreen extends StatelessWidget {

  final List<Map<String, String>> serviceProviders = [
    {
      'name': 'Kouadio   Jean',
      'service': 'Coiffeur',
      'location': 'Abidjan,       Côte d’Ivoire',
      'experiance':'Coiffeur depuis plus de 10ans',
      'prix': '5000 FCFA',
      'image': 'assets/coiffeur.jpeg', // Placeholder image
    },
    {
      'name': 'Yao   Koffi',
      'service': 'Électricien',
      'location': 'Bouaké,       Côte d’Ivoire',
      'experiance':'Coiffeur depuis plus de 10ans',
      'prix': '4000 FCFA',
      'image': 'assets/coiffuer2.jpeg',
    },
    {
      'name': 'Koné   Mariam',
      'service': 'Coiffeuse',
      'location': 'Yamoussoukro,       Côte d’Ivoire',
      'experiance':'Coiffeur depuis plus de 10ans',
      'prix': '2000 FCFA',
      'image': 'assets/coiffeur.jpeg',
    },
    // Ajoutez plus de prestataires ici
  ];

  @override
  Widget build(BuildContext context) {
    final prestataireBloc = BlocProvider.of<PrestataireBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin:
                const EdgeInsets.only(top: 20, bottom: 20, right: 110, left: 110),
            child: Column(
              children: [
                Container(
                  color: Colors.green,
                  child: const Center(
                    child: Column(
                      children: [
                        Text(
                          'SOUTRALI DEALS',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(
                                  thickness: 4, // Épaisseur du trait
                                  color: Colors.white, // Couleur du trait
                                  endIndent:
                                      15, // Espacement entre le trait et le texte
                                ),
                              ),
                              Text("Prestataire",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)), // Texte au milieu
                              Expanded(
                                child: Divider(
                                  thickness: 4, // Épaisseur du trait
                                  color: Colors.white, // Couleur du trait
                                  indent: 15, // Espacement entre le texte et le trait
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      child: DropdownMenu<String>(
                        width: 300,
                        initialSelection: list.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          print('Select');
                        },
                        dropdownMenuEntries:
                        list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    Text("2000 prestaires pour Coiffure à domicile",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 800,
                    child: ListView.builder(
                      itemCount: serviceProviders.length,
                      itemBuilder: (context, index) {
                        final provider = serviceProviders[index];
                        return GestureDetector(
                          onTap: () {
                            context.go('/detailsprestataire');
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: <Widget>[
                                  // Image à gauche
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      provider['image']!,
                                      width: 400.0,
                                      height: 180.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 50), // Espacement entre l'image et le container
                                  // Container à droite
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Ligne supérieure avec détails à gauche et à droite

                                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider['name']!,
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 20.0),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on),
                                              SizedBox(width: 10.0),
                                              Text(
                                                provider['location']!,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),

                                              SizedBox(height: 20.0),

                                              Text(
                                                provider['experiance']!,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 10.0),

                                          Row(
                                            children: [
                                              const Expanded(child: Row(
                                                children: [

                                                  SizedBox( width: 4,),
                                                  Icon(Icons.star, color: Colors.amberAccent,),
                                                  Icon(Icons.star, color: Colors.amberAccent,),
                                                  Icon(Icons.star, color: Colors.amberAccent,),
                                                  Icon(Icons.star_border,
                                                    color: Colors.amberAccent,),

                                                  Text(
                                                    " 3",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black45,
                                                        fontFamily: 'arial',
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              ElevatedButton(onPressed: (){},
                                                child: Text(
                                                provider['prix']!,
                                                style: const TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),)
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Footer(),
        
        
        ]),
      ),
    );
  }
}
