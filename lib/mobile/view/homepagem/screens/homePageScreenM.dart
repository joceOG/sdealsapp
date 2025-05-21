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
        preferredSize: const Size.fromHeight(165),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu, color: Colors.white, size: 32),
                        IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.white, size: 32),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'SOUTRALI DEALS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: Colors.green.shade200, width: 1.4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.07),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Material(
                                color: Colors.green,
                                shape: const CircleBorder(),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Icon(Icons.search_rounded,
                                      color: Colors.white, size: 22),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: TextField(
                                  style: TextStyle(fontSize: 16),
                                  cursorColor: Colors.green,
                                  decoration: InputDecoration(
                                    hintText: 'Rechercher sur soutralideals',
                                    hintStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
