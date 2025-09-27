import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../widget/Footer.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../emarchebloc/emarcheBloc.dart';
import '../emarchebloc/emarcheState.dart';
import '../emarchebloc/emarcheEvent.dart';

class EmarcheScreen extends StatefulWidget {
  const EmarcheScreen({super.key});

  @override
  State<EmarcheScreen> createState() => _EmarcheScreenState();
}

class _EmarcheScreenState extends State<EmarcheScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les données au démarrage
    context.read<EmarcheBloc>().add(LoadCategorieEData());
    context.read<EmarcheBloc>().add(LoadServiceEData());
    context.read<EmarcheBloc>().add(LoadVendeursEData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎯 HERO SECTION
            _buildHeroSection(),

            // 🖼️ BANNER IMAGE
            _buildBannerSection(),

            // 🔄 CHIPS DE NAVIGATION (WEB VERSION)
            _buildNavigationChips(),

            // 📂 TOP CATÉGORIES EMARCHE
            _buildTopCategoriesSection(),

            // 🛍️ MEILLEURS PRODUITS
            _buildBestProductsSection(),

            // 🏪 VENDEURS POPULAIRES
            _buildPopularVendeursSection(),

            // 💰 OFFRES SPÉCIALES
            _buildSpecialOffersSection(),

            // 📱 CALL-TO-ACTION SECTION
            _buildCallToActionSection(),

            // 🦶 FOOTER
            Footer(),
          ],
        ),
      ),
    );
  }

  // 🎯 HERO SECTION
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red.shade50,
            Colors.orange.shade50,
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Découvrez notre e-marché',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Trouvez les meilleurs produits aux meilleurs prix',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🖼️ BANNER SECTION
  Widget _buildBannerSection() {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/emarche.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );
  }

  // 🔄 CHIPS DE NAVIGATION (WEB VERSION - SANS SOUTRAPAY ET COMPARAISON)
  Widget _buildNavigationChips() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavigationChip(
            'Produits',
            Icons.shopping_bag_outlined,
            true,
            () {},
          ),
          const SizedBox(width: 20),
          _buildNavigationChip(
            'Vendeurs',
            Icons.storefront_outlined,
            false,
            () {},
          ),
          const SizedBox(width: 20),
          _buildNavigationChip(
            'Panier',
            Icons.shopping_cart,
            false,
            () {},
          ),
        ],
      ),
    );
  }

  // 📂 TOP CATÉGORIES EMARCHE
  Widget _buildTopCategoriesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Catégories',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Top Catégories',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Explorez nos catégories de produits',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 280,
            child: BlocBuilder<EmarcheBloc, EmarcheState>(
              builder: (context, state) {
                if (state.listItems == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.listItems!.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(state.listItems![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🛍️ MEILLEURS PRODUITS
  Widget _buildBestProductsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Ce mois',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Meilleurs Produits',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.go('/connexion');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Voir tout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            height: 400,
            child: BlocBuilder<EmarcheBloc, EmarcheState>(
              builder: (context, state) {
                if (state.listItems2 == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.listItems2!.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(state.listItems2![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🏪 VENDEURS POPULAIRES
  Widget _buildPopularVendeursSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.purple.shade50,
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Vendeurs Populaires',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Découvrez nos vendeurs les mieux notés',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Grille des vendeurs populaires
          BlocBuilder<EmarcheBloc, EmarcheState>(
            builder: (context, state) {
              if (state.listItems3 == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: state.listItems3!.length,
                itemBuilder: (context, index) {
                  return _buildVendeurCard(state.listItems3![index]);
                },
              );
            },
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.go('/connexion');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 4,
            ),
            child: const Text(
              'Voir tous les vendeurs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 💰 OFFRES SPÉCIALES
  Widget _buildSpecialOffersSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Column(
        children: [
          const Text(
            'Offres Spéciales',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Profitez de nos meilleures offres du moment',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSpecialOfferCard(
                title: 'Réduction 50%',
                description: 'Sur tous les produits électroniques',
                color: Colors.red,
                icon: Icons.electrical_services,
              ),
              _buildSpecialOfferCard(
                title: 'Livraison Gratuite',
                description: 'Pour toute commande supérieure à 50,000 FCFA',
                color: Colors.green,
                icon: Icons.local_shipping,
              ),
              _buildSpecialOfferCard(
                title: 'Nouveautés',
                description: 'Découvrez nos derniers produits',
                color: Colors.blue,
                icon: Icons.new_releases,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 📱 CALL-TO-ACTION SECTION
  Widget _buildCallToActionSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red.shade50,
            Colors.orange.shade50,
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Commencez vos achats dès maintenant !',
                  style: TextStyle(
                    fontFamily: 'Krona One',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Découvrez des milliers de produits de qualité aux meilleurs prix.',
                  style: TextStyle(
                    fontFamily: 'Krona One',
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Livraison rapide et sécurisée partout en Côte d\'Ivoire.',
                  style: TextStyle(
                    fontFamily: 'Kumbh Sans',
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.go('/connexion');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Commencer les achats',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {
                        context.go('/connexion');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red, width: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Vendre sur la plateforme',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 1,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/emarche.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📂 CARTE DE CATÉGORIE
  Widget _buildCategoryCard(dynamic category) {
    return GestureDetector(
      onTap: () {
        context.go('/detailsarticle');
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Image de fond
              Positioned.fill(
                child: Image.network(
                  category.imagecategorie,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.red.shade100,
                      child: const Icon(
                        Icons.category,
                        size: 50,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
              // Overlay avec gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              // Nom de la catégorie
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    category.nomcategorie,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🛍️ CARTE DE PRODUIT
  Widget _buildProductCard(dynamic article) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/detailsarticle',
          extra: article,
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du produit
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(article.photoArticle),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // Gestion d'erreur pour l'image
                    },
                  ),
                ),
                child: article.photoArticle.isEmpty
                    ? Container(
                        color: Colors.red.shade100,
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 50,
                          color: Colors.red,
                        ),
                      )
                    : null,
              ),
            ),
            // Informations du produit
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.nomArticle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article.prixArticle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '(65)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🏪 CARTE DE VENDEUR
  Widget _buildVendeurCard(dynamic vendeur) {
    return GestureDetector(
      onTap: () {
        context.go('/connexion');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Logo du vendeur
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  color: Colors.blue.shade100,
                ),
                child: vendeur.shopLogo != null && vendeur.shopLogo.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: Image.network(
                          vendeur.shopLogo,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.storefront,
                              size: 50,
                              color: Colors.blue,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.storefront,
                        size: 50,
                        color: Colors.blue,
                      ),
              ),
            ),
            // Informations du vendeur
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      vendeur.shopName ?? 'Boutique',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${vendeur.rating.toStringAsFixed(1)} ⭐',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${vendeur.completedOrders} ventes',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
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
  }

  // 💰 CARTE D'OFFRE SPÉCIALE
  Widget _buildSpecialOfferCard({
    required String title,
    required String description,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🔄 CHIP DE NAVIGATION
  Widget _buildNavigationChip(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [Colors.red.shade100, Colors.red.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.grey.shade100, Colors.grey.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.red.shade400 : Colors.grey.shade300,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSelected ? Colors.red : Colors.grey).withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.red.shade700 : Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.red.shade800 : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
