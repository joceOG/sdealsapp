import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 100.0,
      ),
      padding: const EdgeInsets.all(40.0),
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
                child: Text(
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
                child: Text('Gagner de l’argent',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Jost', fontSize: 16)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {},
                child: Text('Moyens de paiement Soutrali ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Jost', fontSize: 16)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {},
                child: Text('Besoin d’aide ?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Jost', fontSize: 16)),
              ),

            ],
          )),

                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Newslettter',
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
        

/*

                  Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 555,
                            height: 100,
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () {
                                    // Action à effectuer lors du clic
                                  },
                                  child: Text('Subscribe',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),*/

        ],
      ),
    );
  }
}
