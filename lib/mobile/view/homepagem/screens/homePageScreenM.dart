import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import 'package:sdealsapp/mobile/view/jobpagem/screens/jobPageScreenM.dart';
import 'package:sdealsapp/mobile/view/searchpagem/screens/searchPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/screens/shoppingPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageBlocM.dart';
import '../../freelancepagem/screens/freelancePageScreen.dart';
import '../../loginpagem/screens/loginPageScreenM.dart';
import '../homepageblocm/homePageBlocM.dart';
import '../homepageblocm/homePageEventM.dart';
import '../homepageblocm/homePageStateM.dart';

class HomePageScreenM extends StatefulWidget {
  const HomePageScreenM({super.key});
  @override
  State<HomePageScreenM> createState() => _HomePageScreenStateM();
}

class _HomePageScreenStateM extends State<HomePageScreenM>
    with TickerProviderStateMixin {
  bool isLocationEnabled = false;
  bool isLoading = false;
  Map<String, double>? userLocation;
  String lastFilterLocation = '';

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;

  late List<Map<String, dynamic>> _tabsData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    BlocProvider.of<HomePageBlocM>(context).add(LoadCategorieDataM());

    _tabsData = [
      {"label": "Métiers", "icon": Icons.work, "page": null},
      {"label": "Freelance", "icon": Icons.person, "page": null},
      {"label": "Marketplace", "icon": Icons.shopping_cart, "page": null},
    ];

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = BlocProvider.of<HomePageBlocM>(context).state;
    if (state.listItems != null && state.isLoading == false) {
      _updateTabsPages(state.listItems);
    }
  }

  void _updateTabsPages(dynamic categories) {
    if (categories == null) return;
    try {
      _tabsData[0]["page"] = const JobPageScreenM();

      _tabsData[1]["page"] = FreelancePageScreen(categories: categories);

      _tabsData[2]["page"] = BlocProvider<ShoppingPageBlocM>(
        create: (context) => ShoppingPageBlocM(),
        child: const ShoppingPageScreenM(),
      );

      setState(() {});
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

  Future<void> toggleLocation() async {
    if (isLocationEnabled) {
      setState(() {
        isLocationEnabled = false;
        userLocation = null;
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
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
    await Future.delayed(const Duration(milliseconds: 500));
    try {
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

  void _filterByLocation() async {
    if (!isLocationEnabled || userLocation == null) {
      setState(() {});
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoading = false;
        userLocation = {'lat': 12.3696, 'lng': -1.5247};
        lastFilterLocation = 'Ouagadougou, Burkina Faso';
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erreur lors de la géolocalisation: $e');
    }
  }

  void _toggleSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPageScreenM()),
    );
  }

  void _openNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications à venir')),
    );
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recherche: $query')),
      );
    }
    setState(() {
      _isSearchVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBlocM, HomePageStateM>(
      listener: (context, state) {
        if (state.listItems != null && state.isLoading == false) {
          _updateTabsPages(state.listItems);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_isSearchVisible ? 200 : 140),
            child: AppBar(
              backgroundColor: Colors.green,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: _buildAppBarContent(),
            ),
          ),
          body: state.isLoading == true && state.listItems == null
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.green))
              : state.error != null && state.error!.isNotEmpty
                  ? _buildError(state.error!)
                  : TabBarView(
                      controller: _tabController,
                      children: _tabsData
                          .map<Widget>((tab) => tab["page"] != null
                              ? tab["page"] as Widget
                              : const Center(
                                  child: Text("Chargement des données...")))
                          .toList(),
                    ),
        );
      },
    );
  }

  Widget _buildAppBarContent() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight - 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      "SOUTRALI DEALS",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildRoleSwitcher(),
                      const SizedBox(width: 8),
                      _buildAuthButtons(),
                    ],
                  ),
                ],
              ),
              if (_isSearchVisible) _buildSearchField(),
              const SizedBox(height: 8),
              _buildTabBar(),
              const SizedBox(height: 2),
              _buildLocationButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSwitcher() {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is! AuthAuthenticated) return const SizedBox.shrink();
      final roles = state.roles;
      if (roles.isEmpty) return const SizedBox.shrink();
      final active = state.activeRole ?? roles.first;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: Colors.green,
            value: active,
            iconEnabledColor: Colors.white,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            items: roles
                .map((r) => DropdownMenuItem(
                      value: r,
                      child:
                          Text(r, style: const TextStyle(color: Colors.white)),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                context.read<AuthCubit>().switchActiveRole(val);
              }
            },
          ),
        ),
      );
    });
  }

  Widget _buildAuthButtons() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final utilisateur = state.utilisateur;
          final initials = ((utilisateur.nom.isNotEmpty ||
                  utilisateur.prenom.isNotEmpty))
              ? '${utilisateur.nom.isNotEmpty ? utilisateur.nom[0] : ''}'
                      '${utilisateur.prenom.isNotEmpty ? utilisateur.prenom[0] : ''}'
                  .toUpperCase()
              : '';

          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  initials,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (_hasAnyPendingRole(context)) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'PENDING',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 20),
                onPressed: _toggleSearch,
              ),
              IconButton(
                icon: const Icon(Icons.notifications,
                    color: Colors.white, size: 20),
                onPressed: _openNotifications,
              ),
            ],
          );
        } else {
          return Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPageScreenM()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  minimumSize: const Size(70, 30),
                ),
                child: const Text(
                  'Se connecter',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 6),
              OutlinedButton(
                onPressed: () {
                  context.push('/register');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  minimumSize: const Size(70, 30),
                ),
                child: const Text(
                  'S\'inscrire',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 20),
                onPressed: _toggleSearch,
              ),
              IconButton(
                icon: const Icon(Icons.notifications,
                    color: Colors.white, size: 20),
                onPressed: _openNotifications,
              ),
            ],
          );
        }
      },
    );
  }

  bool _hasAnyPendingRole(BuildContext context) {
    final state = context.read<AuthCubit>().state;
    if (state is! AuthAuthenticated) return false;
    final d = state.roleDetails;
    if (d == null) return false;
    final prestPending = (d['prestataire']?['verifier'] == false);
    final freePending = ((d['freelance']?['accountStatus']) == 'Pending');
    final vendPending = (d['vendeur']?['verifier'] == false);
    return prestPending || freePending || vendPending;
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher un service, un produit...',
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => setState(() => _isSearchVisible = false),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onSubmitted: (_) => _performSearch(),
      ),
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      height: 30,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        tabs: _tabsData
            .map((tab) => Tab(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        _tabController.animateTo(_tabsData.indexOf(tab)),
                    icon: Icon(tab["icon"] as IconData,
                        color: Colors.white, size: 16),
                    label: Text(tab["label"] as String,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLocationButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          minimumSize: const Size(120, 32),
        ),
        onPressed: isLoading ? null : toggleLocation,
        icon: isLoading
            ? const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Icon(Icons.location_on,
                size: 18,
                color: isLocationEnabled ? Colors.amber : Colors.white),
        label: Text('Autour de moi',
            style: TextStyle(
                color: isLocationEnabled ? Colors.amber : Colors.white,
                fontSize: 11)),
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text('Erreur: $error', style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => BlocProvider.of<HomePageBlocM>(context)
                .add(LoadCategorieDataM()),
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }
}
