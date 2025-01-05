import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/AppBarWidget.dart';
import 'package:sdealsapp/web/widget/Footer.dart';

import '../../../data/models/article.dart';
import '../detailsarticlebloc/detailsarticleBloc.dart';

class DetailsArticleScreen extends StatelessWidget {
  final Article article;
  const DetailsArticleScreen({required this.article});

  @override
    Widget build(BuildContext context) {
    final detailsPrestataireBloc = BlocProvider.of<DetailsArticleBloc>(context);
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
              width: 2000,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/emarche.png'), // Chemin de l'image
                  fit: BoxFit.fill, // Adapte l'image à la taille du container
                ),
              ),
            ),
            // You can add other widgets like buttons or overlays here
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 800,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Card(
                                elevation: 4,
                                child: Image.network(
                                  article.photoArticle,
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                  const SizedBox(width: 16.0),
                  // Section gauche : Image et description
                  Expanded(
                    flex: 2,
                    child: Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Grande image
                           Image.asset(
                              'assets/prestataire.jpeg',
                              width: 600, // Largeur de l'image en pixels
                              height: 470,
                              fit: BoxFit.fill,
                            ),

                          // const SizedBox(height: 16.0),
                          // Texte de description
                         /* Text(
                            article.nomArticle,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Section droite : Détails et bouton contacter
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Tondeuse',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),),
                          Row(
                            children: [
                              Text('25 000cfa',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.redAccent
                                ),),
                              SizedBox(width: 10.0,),
                              Text('35 000cfa',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey,
                                  decorationThickness: 2,
                                ),),
                            ],
                          ),
                         const Row(
                           children: [
                             Icon(Icons.star_purple500_sharp,
                             color: Colors.yellow,),
                             Icon(Icons.star_purple500_sharp,
                               color: Colors.yellow,),
                             Icon(Icons.star_purple500_sharp,
                               color: Colors.yellow,),
                             Icon(Icons.star_outline_sharp,
                               color: Colors.yellow,),
                             Text('(63)',
                             style: TextStyle(
                               color: Colors.grey,
                               fontSize: 15,
                             ),)
                           ],
                         ),
                         SizedBox(height: 20.0,),
                         const Text("Cette tondeuse à cheveux professionnelle est équipée d'un moteur ",
                         style: TextStyle(
                           fontSize: 20,
                         ),),
                          SizedBox(height: 10.0,),
                          const Text("puissant et silencieux, offrant une coupe précise et régulière grâce à ses lames en ",
                            style: TextStyle(
                              fontSize: 20,
                            ),),
                          SizedBox(height: 10.0,),
                         const Text("acier inoxydable de haute qualité.",
                           style: TextStyle(
                             fontSize: 20,
                           ),),
                          Row(
                            children: [
                              Container(

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(50, 50),
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0),
                                            )
                                        ),
                                        onPressed: (){},
                                        child: Icon(Icons.exposure_minus_1)),
                                    SizedBox(width: 10.0,),
                                    const Text('1'),
                                    SizedBox(width: 10.0,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(50, 50),
                                            backgroundColor: Colors.redAccent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0)

                                            )
                                        ),
                                        onPressed: (){},
                                        child: Icon(Icons.plus_one)),
                                  ],
                                ),
                              ),
                                  SizedBox(width: 20.0,),
                              Container(
                                width: 150.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text('Achetez maintenant',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white

                                    ),),
                                )
                              ),
                              SizedBox(width: 20.0,),

                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(50, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        backgroundColor: Colors.white
                                      ),
                                      onPressed: (){},
                                      child: Icon(Icons.favorite_border,
                                        color: Colors.black45,
                                      )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                const SizedBox(width: 50.0,),
                Image.asset('assets/rectanglered.png'),
                const SizedBox(width: 5.0,),
                const Text('Article similaire',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
             const SizedBox(height: 13.0,),
             Row(
               children: [
                 const SizedBox(width: 70,),
                 Container(
                   decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.black38,
                           width: 2.0
                       ),
                       borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: Column(
                     children: [
                       Image.asset('assets/autreArticle1.png',
                         width: 200.0,
                         height: 220.0,),
                       const Divider(thickness: 4,
                       color: Colors.black38,),
                       const Text('Perceuse', style: TextStyle( fontSize: 13),),
                       const Text('25 000cfa', style: TextStyle( color: Colors.red,fontSize: 13),),
                       const Row(
                         children: [
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star_border, color: Colors.amberAccent,),
                         ],
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(width: 80,),
                 Container(
                   decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.black38,
                           width: 2.0
                       ),
                       borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: Column(
                     children: [
                       Image.asset('assets/autreArticle2.png',
                         width: 200.0,
                         height: 220.0,),
                       const Divider(thickness: 4,
                         color: Colors.black38,),
                       const Text('Tondeuse', style: TextStyle( fontSize: 13),),
                       const Text('25 000cfa', style: TextStyle( color: Colors.red,fontSize: 13),),
                       const Row(
                         children: [
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star_border, color: Colors.amberAccent,),
                         ],
                       ),
                     ],
                   ),
                 ),
                 SizedBox(width: 80,),
                 Container(
                   decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.black38,
                           width: 2.0
                       ),
                     borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: Column(
                     children: [
                       Image.asset('assets/autreArticle3.png',
                         width: 200.0,
                         height: 220.0,),
                       const Divider(thickness: 4,
                         color: Colors.black38,),
                       const Text('Fil à coudre', style: TextStyle( fontSize: 13),),
                       const Text('25 000cfa', style: TextStyle( color: Colors.red,fontSize: 13),),
                       const Row(
                         children: [
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star_border, color: Colors.amberAccent,),
                         ],
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(width: 80,),
                 Container(
                   decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.black38,
                           width: 2.0
                       ),
                       borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: Column(
                     children: [
                       Image.asset('assets/autreArticle4.png',
                         width: 200.0,
                         height: 220.0,),
                       const Divider(thickness: 4,
                         color: Colors.black38,),
                       const Text('Lampe de table', style: TextStyle( fontSize: 13),),
                       const Text('25 000cfa', style: TextStyle( color: Colors.red,fontSize: 13),),
                       const Row(
                         children: [
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star_border, color: Colors.amberAccent,),
                         ],
                       ),
                     ],
                   ),
                 ),

                 const SizedBox(width: 80,),
                 Container(
                   decoration: BoxDecoration(
                     border: Border.all(
                       color: Colors.black38,
                       width: 2.0
                     ),
                       borderRadius: BorderRadius.circular(5.0)
                   ),
                   child: Column(
                     children: [
                       Image.asset('assets/autreArticle4.png',
                         width: 200.0,
                       height: 220.0,),
                       const Divider(
                         thickness: 4,
                         color: Colors.black38,),
                       const Text('Lampe de table', style: TextStyle( fontSize: 13),),
                       const Text('25 000cfa', style: TextStyle( color: Colors.red,fontSize: 13),),
                       const Row(
                         children: [
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star, color: Colors.amberAccent,),
                           Icon(Icons.star_border, color: Colors.amberAccent,),
                         ],
                       ),
                     ],
                   ),
                 ),
               ],
             ),

             /*ListView.builder(
                scrollDirection:
                Axis.horizontal, // Définit la direction du défilement
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,

                    color: Colors.green,
                    child: Text("Item $index"),
                  );
                },
              ),
            */
            Footer(),
          ],
        ),
      ),
    );
  }
}
