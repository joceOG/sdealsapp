import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/homepagem/homepageblocm/homePageStateM.dart';
import '../homepageblocm/homePageBlocM.dart';
import '../homepageblocm/homePageEventM.dart';

class HomePageScreenM extends StatefulWidget {
  const HomePageScreenM({super.key});
  @override
  State<HomePageScreenM> createState() => _HomePageScreenStateM();
}

class _HomePageScreenStateM extends State<HomePageScreenM> {
  @override
  void initState() {
    BlocProvider.of<HomePageBlocM>(context).add(LoadCategorieDataM());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            180.0), // Augmente la hauteur de l'AppBar pour inclure le bouton
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 17.0,
                      left: 17.0,
                      right: 17.0,
                    ),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        //border: Border.all(),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/photo_profile.png',))
                    ),
                  ),
                  const SizedBox(width: 270.0,),
                  const Icon(Icons.notifications, size: 34.0,color: Colors.white,)
                ],
              ),

              Column(
                children: [
                  const Text('SOUTRALI DEALS',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(height: 2.0,),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 1.0,),
                        const Icon(Icons.search, color: Colors.black12, size: 20.0,),
                        const SizedBox(width: 2.0,),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 2.0,
                              right: 2.0,
                              bottom: 9.0),
                          width: 250.0,
                          height: 30.0,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Recherchez sur soutrali',
                            ),
                          ),
                        ),
                        const Icon(Icons.location_searching, color: Colors.black12, size: 20.0,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),

                  Container(
                    padding: EdgeInsets.only(
                      left: 4.0,
                      right: 4.0,
                    ),
                    width: 190.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.lightGreenAccent.shade700,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.map,size:20.0, color: Colors.white),
                        SizedBox(height: 4.0,),
                        Text("Toute la Côte d'Ivoire"),
                        SizedBox(width: 4.0,),
                        Icon(Icons.my_location,size: 20.0, color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                      width: 10.0,
                      child: Image.asset('assets/rectanglered.png')),
                  SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    "Services Populaires",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'raf',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Image.asset('assets/_acceuil_.jpeg'),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                      width: 10.0,
                      child: Image.asset('assets/rectanglered.png')),
                  const SizedBox(width: 4.0),
                  const Text(
                    "Top Catégories",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'raf',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider.builder(
              itemCount: categoriesSoutraliData.length,
              options: CarouselOptions(

                height: 140.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              itemBuilder: (context, index, realIndex) {
                final item = categoriesSoutraliData[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12.0),
                          ),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                            width: 300.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 5.0, bottom: 2.0),
                        child: Text(
                          item['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'rif',
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                      width: 10.0,
                      child: Image.asset('assets/rectanglered.png')),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    "Top Services",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'raf',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Liste des données du carousel (à remplacer par les données réelles) soutralideals
const List<Map<String, String>> categoriesSoutraliData = [
  {
    "image": "assets/categories/Image1.png",
    "title": "Plombier",
  },
  {
    "image": "assets/categories/Image2.png",
    "title": "Coiffeurs",
  },
  {
    "image": "assets/categories/Image3.png",
    "title": "Photographes",
  },
  {
    "image": "assets/categories/Image4.png",
    "title": "Nettoyage",
  },
  {
    "image": "assets/categories/Image5.png",
    "title": "Menuiserie",
  },
  // Ajoutez les autres éléments ici...
];