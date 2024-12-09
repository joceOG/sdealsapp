import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 100.0,
          ),
          padding: const EdgeInsets.only(
            top: 40.0
          ),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Pour mieux nous connaître',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Jost', fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text('Gagner de l’argent',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Jost', fontSize: 16)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text('Moyens de paiement Soutrali ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Jost', fontSize: 16)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text('Besoin d’aide ?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Jost', fontSize: 16)),
                  ),

                ],
              )),

                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Newsletter',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: 'Jost'),
                        ),

                       Row(
                         children: [
                           Container(
                             width: 250,
                             child: TextField(
                               decoration: InputDecoration(
                                 border: OutlineInputBorder(),
                                 hintText: 'E-mail',
                               ),
                             ),
                           ),

                           Container(
                             margin: EdgeInsets.all(10.0),
                             width: 150,
                             height: 50,
                             child: ElevatedButton(
                               style: ElevatedButton.styleFrom(

                                 backgroundColor: Colors.green,
                               ),
                               onPressed: () {
                                 // Action à effectuer lors du clic
                               },
                               child: Text('Subscribe',
                                   style: TextStyle(color: Colors.white)),
                             ),
                           )

                         ],
                       ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/facebook.png',
                              width: 50,
                            ),
                            Image.asset(
                              'assets/insta.png',
                              width: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                    ),


            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.only(
              top: 20.0
          ),
          color: Colors.black,
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 4, // Épaisseur du trait
                      color: Colors.white, // Couleur du trait
                      endIndent: 15, // Espacement entre le trait et le texte
                    ),
                  ),

                  Image.asset('assets/logo1.png',
                    width: 300,),

                  const SizedBox(width: 15.0,),
                  const Expanded(
                    child: Divider(
                      thickness: 4, // Épaisseur du trait
                      color: Colors.white, // Couleur du trait
                      //endIndent: 15, // Espacement entre le trait et le texte
                    ),
                  ),

                ],
              ),

              const Text('© Soutrali Deals 2024',
                style: TextStyle(
                  fontFamily: 'Jost',
                  color: Colors.white,
                  fontSize: 15,
                ),)
            ],
          ),
        )
        
      ],
    );
  }
}
