import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/homepagem/homepageblocm/homePageStateM.dart';
import 'package:sdealsapp/mobile/view/jobpagem/screens/jobPageScreenM.dart';
import 'package:sdealsapp/mobile/view/rondpagem/screens/rondPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/screens/shoppingPageScreenM.dart';
import '../../freelancepagem/screens/freelancePageScreen.dart';
import '../../profilpagem/screens/profilPageScreenM.dart';
import '../../rondpagem/screens/rondPageScreenMVO.dart';
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

  final List<Map<String, dynamic>> tabsData = [
    {"label": "Métiers", "icon": Icons.work , "page": JobPageScreenM()},
    {"label": "Freelance", "icon": Icons.person , "page": FreelancePageScreen()},
    {"label": "Articles", "icon": Icons.shopping_cart , "page": ShoppingPageScreenM()},
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsData.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(165),
          child: AppBar(
            backgroundColor: Colors.green,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
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
                          const Icon(Icons.menu, color: Colors.white, size: 32),
                          IconButton(
                            icon: const Icon(Icons.notifications,
                                color: Colors.white, size: 32),
                            onPressed: () {},
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const ProfilPageScreenM(),
                                ),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                              AssetImage('assets/profile_picture.jpg'),
                            ),
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
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  tabs: tabsData.map((tab) {
                    return Tab(
                      child: OutlinedButton.icon(
                        onPressed: null,
                        icon: Icon(tab["icon"], color: Colors.white),
                        label: Text(
                          tab["label"],
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),

        body: TabBarView(
          children: tabsData.map((tab) => tab["page"] as Widget).toList(),
        ),
      ),
    );
  }

  // Fonction pour créer une carte de catégorie
  Widget _buildCategoryCard(String categoryName, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            // ignore: deprecated_member_use
            backgroundColor: Colors.green.withOpacity(0.2),
            child: Icon(icon, size: 30, color: Colors.green),
          ),
          const SizedBox(height: 5),
          Text(categoryName, style: const TextStyle(fontSize: 16)),
        ],
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