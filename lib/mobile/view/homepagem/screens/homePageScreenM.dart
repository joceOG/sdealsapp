import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/jobpagem/screens/jobPageScreenM.dart';
import 'package:sdealsapp/mobile/view/searchpagem/screens/searchPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/screens/shoppingPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageBlocM.dart';
// L'import du modèle Categorie est déjà fait via des importations relatives
// ApiClient est géré directement dans ShoppingPageBlocM
import 'package:sdealsapp/mobile/view/auth/screens/loginPageScreenM.dart';
import 'package:sdealsapp/mobile/view/auth/screens/registerPageScreenM.dart';
import '../../freelancepagem/screens/freelancePageScreen.dart';
import '../homepageblocm/homePageBlocM.dart';
import '../homepageblocm/homePageEventM.dart';
import '../homepageblocm/homePageStateM.dart';

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
  
  // Contrôleur de recherche
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialiser le contrôleur avec le nombre d'onglets par défaut
    _tabController = TabController(length: 4, vsync: this);
    // Déclencher le chargement des catégories
    BlocProvider.of<HomePageBlocM>(context).add(LoadCategorieDataM());
    
    // Initialiser les données d'onglets
    _tabsData = [
      {
        "label": "Métiers", 
        "icon": Icons.work, 
        "page": null
      },
      {
        "label": "Freelance", 
        "icon": Icons.person, 
        "page": null
      },
      {
        "label": "Marketplace",
        "icon": Icons.shopping_cart,
        "page": null
      },
      {
        "label": "Prestataires",
        "icon": Icons.person, 
        "page": null
      },
    ];
    
    // Ajouter un listener au tabController pour gérer correctement les changements d'onglets
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Vérifier si les catégories ont changé et les mettre à jour
    final state = BlocProvider.of<HomePageBlocM>(context).state;
    if (state.listItems != null && state.isLoading == false) {
      // Mettre à jour les pages dans les onglets
      _updateTabsPages(state.listItems);
    }
  }
  
  // Mettre à jour les pages dans les données d'onglets avec les catégories
  void _updateTabsPages(dynamic categories) {
    if (categories == null) return;
    
    try {
      // Métiers - filtrer par groupe spécifique
      _tabsData[0]["page"] = JobPageScreenM(categories: categories.where((cat) => 
        cat.groupe == "66dcaf6ccb96c35a997df14d" // ID du groupe "Métiers"
      ).toList() ?? []);
      
      // Freelance - toutes les catégories
      _tabsData[1]["page"] = FreelancePageScreen(categories: categories ?? []);
      
      // Marketplace - fournir le bloc pour les catégories E-marché
      _tabsData[2]["page"] = BlocProvider<ShoppingPageBlocM>(
        create: (context) => ShoppingPageBlocM(),
        child: const ShoppingPageScreenM(),
      );
      
      // Prestataires - toutes les catégories
      _tabsData[3]["page"] = FreelancePageScreen(categories: categories ?? []);
      
      setState(() {}); // Déclencher une reconstruction de l'interface
    } catch (e) {
      print("Erreur lors de la mise à jour des onglets: $e");
    }
  }
  
  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    _searchController.dispose();
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
        userLocation = {'lat': 12.3696, 'lng': -1.5247}; // Coordonnées de Ouagadougou
        lastFilterLocation = 'Ouagadougou, Burkina Faso';
      });
    } catch (e) {
      // Gérer les erreurs potentielles
      setState(() {
        isLoading = false;
      });
      print('Erreur lors de la géolocalisation: $e');
    }
  }

<<<<<<< Updated upstream
  // Méthode pour naviguer vers la page de recherche
  void _toggleSearch() {
    // Navigation vers SearchPageScreenM
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const SearchPageScreenM())
    );
  }

  // Méthode pour gérer les notifications
  void _openNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications à venir'))
    );
    // Dans une version finale, naviguer vers la page des notifications
    // Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
  }

  // Méthode pour gérer les favoris
  void _openFavorites() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Favoris à venir'))
    );
    // Dans une version finale, naviguer vers la page des favoris
    // Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen()));
  }

  // Méthode pour effectuer la recherche
  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recherche: $query'))
      );
      // Dans une version finale, lancer la recherche avec l'API
      // BlocProvider.of<SearchBloc>(context).add(SearchEvent(query));
    }
    setState(() {
      _isSearchVisible = false;
    });
  }
  
  // Cette liste est créée une seule fois dans initState et réutilisée
  late final List<Map<String, dynamic>> _tabsData;
  
  // Méthode qui initialise les données des onglets avec les pages associées
  void _initTabsData() {
    // Récupérer les catégories depuis le BLoC
    final state = BlocProvider.of<HomePageBlocM>(context).state;
    final categories = state.listItems;
    
    // Affichage du nombre de catégories récupérées pour le débogage
    try {
      print('Récupération des catégories: ${categories?.length ?? 0}');
      if (categories != null && categories.isNotEmpty) {
        print('Exemple de catégorie - Groupe: ${categories.first.groupe}');
      }
    } catch (e) {
      print('Erreur lors de l\'affichage des catégories: $e');
    }
    
    _tabsData = [
      {
        "label": "Métiers", 
        "icon": Icons.work, 
        "page": JobPageScreenM(categories: categories?.where((cat) => 
          cat.groupe == "66dcaf6ccb96c35a997df14d" // ID du groupe "Métiers"
        ).toList() ?? [])
      },
      {
        "label": "Freelance", 
        "icon": Icons.person, 
        "page": FreelancePageScreen(categories: categories ?? [])
      },
      {
        "label": "Marketplace",
        "icon": Icons.shopping_cart,
        "page": const ShoppingPageScreenM()
      },
      {
        "label": "Prestataires",
        "icon": Icons.person, 
        "page": FreelancePageScreen(categories: categories ?? [])
      },
    ];
  }
  
=======
  final List<Map<String, dynamic>> tabsData = [
    {"label": "Métiers", "icon": Icons.work, "page": JobPageScreenM()},
    {"label": "Freelance", "icon": Icons.person, "page": FreelancePageScreen()},
    {
      "label": "Marketplace",
      "icon": Icons.shopping_cart,
      "page": ShoppingPageScreenM()
    },
  ];
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBlocM, HomePageStateM>(
      listener: (context, state) {
        // Mettre à jour les pages dans les onglets quand les données sont disponibles
        if (state.listItems != null && state.isLoading == false) {
          _updateTabsPages(state.listItems);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_isSearchVisible ? 240 : 190),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kToolbarHeight - 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Nom de l'application stylisé entièrement en blanc
                            Flexible(
                              child: Text(
                                "SOUTRALI DEALS",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // Afficher les boutons de connexion et d'inscription si l'utilisateur n'est pas connecté
                                if (!isLoggedIn) ...[                                 
                                  ElevatedButton(
                                    onPressed: () {
                                      // Navigation vers la page de connexion
                                      Navigator.push(
                                        context, 
                                        MaterialPageRoute(builder: (context) => const LoginPageScreenM()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    ),
                                    child: const Text('Se connecter', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton(
                                    onPressed: () {
                                      // Navigation vers la page d'inscription
                                      Navigator.push(
                                        context, 
                                        MaterialPageRoute(builder: (context) => const RegisterPageScreenM()),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    ),
                                    child: const Text('S\'inscrire', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ] else ...[  // Noter le ... ici pour spread les éléments
                                  // Si l'utilisateur est connecté, afficher un avatar ou un bouton de profil
                                  IconButton(
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.orange,
                                        child: Icon(Icons.person, color: Colors.white, size: 20),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Navigation vers la page de profil
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Navigation vers le profil')),
                                      );
                                      // Implémentation future: Navigator.pushNamed(context, '/profile');
                                    },
                                    tooltip: 'Profil',
                                  ),
                                ],
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.search, color: Colors.white),
                                  onPressed: _toggleSearch,
                                  tooltip: 'Rechercher',
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.notifications, color: Colors.white),
                                  onPressed: _openNotifications,
                                  tooltip: 'Notifications',
                                ),
                                SizedBox(width: 8),
                                // Icône de favoris supprimée comme demandé
                              ],
                            ),
                          ],
                        ),
                        // Barre de recherche (conditionnellement affichée)
                        if (_isSearchVisible)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Rechercher un service, un produit...',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                                prefixIcon: const Icon(Icons.search, color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  onPressed: () => setState(() {
                                    _searchController.clear();
                                    _isSearchVisible = false;
                                  }),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              style: const TextStyle(color: Colors.white),
                              onSubmitted: (_) => _performSearch(),
                              textInputAction: TextInputAction.search,
                            ),
                          ),
                        const SizedBox(height: 12),
                        // Tab bar
                        SizedBox(
                          height: 32,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                indicatorColor: Colors.transparent,
                                labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                tabs: _tabsData.map((tab) => Tab(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      final index = _tabsData.indexOf(tab);
                                      if (index >= 0 && index < _tabController.length) {
                                        _tabController.animateTo(index);
                                      }
                                    },
                                    icon: Icon(tab["icon"] as IconData, color: Colors.white),
                                    label: Text(
                                      tab["label"] as String,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Colors.white38),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                      // Pas d'élévation pour un style plat
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Bouton "Autour de moi"
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
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
            ),
          ),
          // Corps de l'application
          body: state.isLoading == true && state.listItems == null
              // Affichage du chargement
              ? const Center(child: CircularProgressIndicator(color: Colors.green))
              // Affichage d'une erreur si nécessaire
              : state.error != null && state.error!.isNotEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text('Erreur: ${state.error}', style: const TextStyle(color: Colors.red)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => BlocProvider.of<HomePageBlocM>(context).add(LoadCategorieDataM()),
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    )
                  // Affichage des onglets et du contenu
                  : TabBarView(
                      controller: _tabController,
                      children: _tabsData.map((tab) => 
                        tab["page"] != null ? tab["page"] as Widget : 
                        const Center(child: Text("Chargement des données..."))
                      ).toList(),
                    ),
        );
      },
    );
  }
}
