import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/jobpagem/screens/jobPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/screens/shoppingPageScreenM.dart';
import '../../freelancepagem/screens/freelancePageScreen.dart';
import '../../profilpagem/screens/profilPageScreenM.dart';
import '../homepageblocm/homePageBlocM.dart';
import '../homepageblocm/homePageEventM.dart';

class HomePageScreenM extends StatefulWidget {
  const HomePageScreenM({super.key});
  @override
  State<HomePageScreenM> createState() => _HomePageScreenStateM();
}

class _HomePageScreenStateM extends State<HomePageScreenM> with TickerProviderStateMixin {
  // État utilisateur (à remplacer par la vraie logique d'authentification)
  bool isLoggedIn = false;
  
  // État pour la géolocalisation
  bool isLocationEnabled = false;
  bool isLoading = false;
  Map<String, double>? userLocation; // Simulation de Position avec lat/lng
  String lastFilterLocation = '';
  
  // Contrôleur pour le TabBar
  late TabController _tabController;

  @override
  void initState() {
    BlocProvider.of<HomePageBlocM>(context).add(LoadCategorieDataM());
    super.initState();
    _tabController = TabController(length: tabsData.length, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  // Méthode pour activer/désactiver la géolocalisation (simulée)
  Future<void> toggleLocation() async {
    if (isLocationEnabled) {
      setState(() {
        isLocationEnabled = false;
        userLocation = null;
      });
      return;
    }
    
    // Simuler la vérification du service
    setState(() {
      isLoading = true;
    });
    
    // Simuler un délai réseau
    await Future.delayed(const Duration(seconds: 1));
    
    // 80% de chance que le service est activé
    bool serviceEnabled = (DateTime.now().millisecond % 10) < 8;
    if (!serviceEnabled) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Services de localisation désactivés')),
      );
      return;
    }

    // Simuler un délai réseau pour demande de permission
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simuler la permission accordée
    try {
      // Simuler une position GPS (coordonnées d'Abidjan)
      final position = {'latitude': 5.3364, 'longitude': -4.0267};
      setState(() {
        userLocation = position;
        isLocationEnabled = true;
        isLoading = false;
      });
      _filterByLocation();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de géolocalisation: ${e.toString()}')),
      );
    }
  }
  
  // Méthode pour filtrer les résultats par localisation
  void _filterByLocation() async {
    if (!isLocationEnabled || userLocation == null) {
      // Si la localisation est désactivée, annuler le filtrage
      setState(() {
        // Réinitialiser les données (à implémenter avec les données API réelles)
      });
      return;
    }
    
    try {
      // Simuler un chargement pour l'interface utilisateur
      setState(() {
        isLoading = true;
      });
      
      // Dans une implémentation réelle, vous appelleriez une méthode de repository
      // ou un service pour obtenir les données filtrées par localisation
      // par exemple:
      // final filteredData = await myRepository.getItemsNearby(
      //   userLocation!.latitude,
      //   userLocation!.longitude, 
      //   radius: 5000, // 5 km de rayon par exemple
      // );
      
      // Simuler une requête réseau
      await Future.delayed(const Duration(seconds: 1));
      
      // À remplacer par un vrai appel réseau plus tard
      setState(() {
        isLoading = false;
        lastFilterLocation = '${userLocation!['latitude']!.toStringAsFixed(2)}, ${userLocation!['longitude']!.toStringAsFixed(2)}';
      });
      
      // Afficher une notification de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Résultats filtrés pour votre position : $lastFilterLocation'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors du filtrage : ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  final List<Map<String, dynamic>> tabsData = [
    {"label": "Métiers", "icon": Icons.work, "page": JobPageScreenM()},
    {"label": "Freelance", "icon": Icons.person, "page": FreelancePageScreen()},
    {
      "label": "Marketplace",
      "icon": Icons.shopping_cart,
      "page": ShoppingPageScreenM()
    },
    {
      "label": "Prestataires",
      "icon": Icons.person, 
      "page": FreelancePageScreen()
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          // Menu burger
                          const Icon(Icons.menu, color: Colors.white, size: 32),
                          
                          // Partie droite : utilisateur connecté ou boutons d'authentification
                          isLoggedIn 
                              ? Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.notifications,
                                          color: Colors.white, size: 28),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.account_balance_wallet,
                                          color: Colors.white, size: 28),
                                      tooltip: 'SoutraPay',
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/wallet');
                                      },
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
                                        radius: 18,
                                        backgroundImage:
                                            AssetImage('assets/profile_picture.jpg'),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        // Navigation vers la page d'inscription
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Colors.white),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        minimumSize: const Size(85, 30),
                                      ),
                                      child: const Text('S\'inscrire', 
                                        style: TextStyle(fontSize: 12)),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigation vers la page de connexion
                                        // Après authentification réussie, setState(() => isLoggedIn = true);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        minimumSize: const Size(85, 30),
                                      ),
                                      child: const Text('Se connecter', 
                                        style: TextStyle(fontSize: 12)),
                                    ),
                                  ],
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
              preferredSize: const Size.fromHeight(60),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                        tabs: List.generate(tabsData.length, (index) {
                          final tab = tabsData[index];
                          return Tab(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _tabController.animateTo(index);
                              },
                              icon: Icon(tab["icon"], color: Colors.white),
                              label: Text(
                                tab["label"],
                                style: const TextStyle(color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Bouton "Autour de moi"
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: OutlinedButton.icon(
                        onPressed: isLoading ? null : toggleLocation,
                        icon: isLoading
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Icon(
                            Icons.location_on,
                            color: isLocationEnabled ? Colors.amber : Colors.white,
                            size: 16,
                          ),
                        label: Text(
                          'Autour de moi',
                          style: TextStyle(
                            color: isLocationEnabled ? Colors.amber : Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: isLocationEnabled ? Colors.amber : Colors.white),
                          backgroundColor: isLocationEnabled 
                              ? Colors.white.withOpacity(0.2) 
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabsData.map((tab) => tab["page"] as Widget).toList(),
        ),
    );
  }
}
