import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';

import '../../../widget/Footer.dart';
import '../prestatairebloc/prestataireBloc.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PrestataireScreen extends StatelessWidget {

  final List<Map<String, String>> serviceProviders = [
    {
      'name': 'Kouadio Jean',
      'service': 'Mécanicien',
      'location': 'Abidjan, Côte d’Ivoire',
      'image': 'https://via.placeholder.com/150', // Placeholder image
    },
    {
      'name': 'Yao Koffi',
      'service': 'Électricien',
      'location': 'Bouaké, Côte d’Ivoire',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Koné Mariam',
      'service': 'Coiffeuse',
      'location': 'Yamoussoukro, Côte d’Ivoire',
      'image': 'https://via.placeholder.com/150',
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
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: <Widget>[
                                // Image à gauche
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    provider['image']!,
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16), // Espacement entre l'image et le container
                                // Container à droite
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        // Ligne supérieure avec détails à gauche et à droite
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              provider['name']! + ', ' +  provider['location']!,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                     "3",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.grey[600],
                                                        ),
                                                      ),
                                  SizedBox( width: 4,),
                                  Icon(Icons.star),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20), // Espacement entre les détails et le bouton
                                        // Bouton centré
                                        Center(
                                          child: FilledButton(
                                            onPressed: () {
                                              context.go('/detailsprestataire');
                                              // Action à effectuer lors du clic sur le bouton
                                            },
                                            style: FilledButton.styleFrom(
                                              backgroundColor: Colors.blue, // Couleur de fond verte
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 15), // Marges internes
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15), // Bords arrondis
                                              ),
                                            ),
                                            child: const Text(
                                              'Voir les détails',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold), // Couleur du texte
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
