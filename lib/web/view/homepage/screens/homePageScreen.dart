import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

import '../../../widget/Footer.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../homepagebloc/homePageBloc.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section avec gradient et animation
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green.shade50,
                    Colors.blue.shade50,
                    Colors.purple.shade50,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Des centaines de services et autant de prestations de qualités',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Trouvez le prestataire parfait pour tous vos besoins',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Bannière principale avec overlay moderne
            Container(
              width: double.infinity,
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/accueil_.jpeg'),
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Métiers",
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Découvrez nos prestataires qualifiés",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.go('/prestataire');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                            ),
                            child: const Text(
                              'Découvrir les services',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: () {
                              // Action pour devenir prestataire
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Colors.white, width: 2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Devenir prestataire',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Section catégories avec design moderne
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
              child: Column(
                children: [
                  const Text(
                    'Top catégories',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Explorez nos services par catégorie',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 40.0,
                right: 40.0,
              ),
              height: 260, // Set a height for the container
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  return state.listItems == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              state.listItems!.length, // Number of images
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  context.go('/prestataire');
                                },
                                child: Stack(children: [
                                  FractionallySizedBox(
                                      alignment: Alignment
                                          .bottomCenter, // Aligner en haut à gauche
                                      // Prendre la moitié de la largeur
                                      heightFactor:
                                          0.7, // Prendre la moitié de la hauteur
                                      child: Image.network(
                                        state.listItems![index]
                                            .imagecategorie, // Replace with your image URLs
                                        width: 215,
                                        height: 240,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Text('Failed to render image');
                                        },
                                      )),
                                  // Half of the container's height for a circular image
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Container(
                                        width: 200,
                                        padding: EdgeInsets.all(16),
                                        color: Colors.white,
                                        child: Text(
                                          state.listItems![index].nomcategorie,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]));
                          },
                        );
                },
              ),
            ),

            // 👥 SECTION PRESTATAIRES POPULAIRES
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
              ),
              child: Column(
                children: [
                  const Text(
                    'Prestataires Populaires',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Découvrez nos prestataires les mieux notés',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Grille des prestataires populaires
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 6, // Top 6 prestataires
                    itemBuilder: (context, index) {
                      return _buildPopularProviderCard(index);
                    },
                  ),

                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/prestataire');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                      'Voir tous les prestataires',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🗺️ SECTION GÉOLOCALISATION PRESTATAIRES
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade50,
                    Colors.green.shade50,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Géolocalisation Prestataires',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Trouvez facilement les prestataires autour de vous grâce à notre système de géolocalisation en temps réel',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
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
                      child: Stack(
                        children: [
                          // Carte de fond (placeholder)
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.map,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Carte Interactive',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Prestataires autour de vous',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Overlay avec bouton d'action
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.go('/prestataire');
                              },
                              icon: const Icon(Icons.location_on),
                              label: const Text('Voir sur la carte'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.only(
                left: 80.0,
                right: 40.0,
                top: 20.0,
              ),
              child: const Text(
                'Top services',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            // 🔧 SECTION TOP SERVICES AVEC LES BONNES DONNÉES
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              height: 260,
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state.listItems2 == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.listItems2!.length,
                    itemBuilder: (context, index) {
                      final service = state.listItems2![index];
                      return GestureDetector(
                        onTap: () {
                          context.go('/prestataire');
                        },
                        child: Container(
                          width: 215,
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
                                // Image du service
                                Positioned.fill(
                                  child: Image.network(
                                    service.imageservice,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.work,
                                          size: 50,
                                          color: Colors.grey,
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
                                // Nom du service
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      service.nomservice,
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
                    },
                  );
                },
              ),
            ),

            // 🔍 SECTION "COMMENT ÇA MARCHE" (3 ÉTAPES)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
              ),
              child: Column(
                children: [
                  const Text(
                    'Comment ça marche ?',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '3 étapes simples pour obtenir le service dont vous avez besoin',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStepCard(
                        icon: Icons.search,
                        title: '1. Trouver',
                        description: 'Recherchez un prestataire qualifié',
                        color: Colors.blue,
                      ),
                      _buildStepArrow(),
                      _buildStepCard(
                        icon: Icons.book_online,
                        title: '2. Réserver',
                        description: 'Planifiez votre service en ligne',
                        color: Colors.orange,
                      ),
                      _buildStepArrow(),
                      _buildStepCard(
                        icon: Icons.payment,
                        title: '3. Payer',
                        description: 'Paiement sécurisé avec SoutraPay',
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🛠️ SECTION "NOS MÉTIERS" (TEASER)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade50,
                    Colors.green.shade50,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Nos Métiers',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Découvrez plus de 100 métiers organisés en 10+ catégories.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Métiers mis en avant
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMetierCard(
                          'Coiffure', Icons.content_cut, Colors.pink),
                      _buildMetierCard('Plomberie', Icons.build, Colors.blue),
                      _buildMetierCard('Électricité', Icons.electrical_services,
                          Colors.orange),
                      _buildMetierCard(
                          'Nettoyage', Icons.cleaning_services, Colors.green),
                    ],
                  ),

                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/prestataire');
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
                      'Voir tous nos métiers',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 550,
                        height: 100,
                        margin: const EdgeInsets.only(
                          top: 50.0,
                        ),
                        child: const Text(
                            'Que vous recherchiez un DJ, un plombier ou un avocat... '
                            'Nous vous trouvons les meilleurs, gratuitement.',
                            style: TextStyle(
                                fontFamily: 'Krona One', fontSize: 24)),
                      ),
                      Container(
                        width: 550,
                        height: 50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.only(bottom: 3),
                        child: const Text(
                            'Consultez les profils, discutez avec les professionnels, aussi depuis notre application mobile.',
                            style: TextStyle(
                                fontFamily: 'Kumbh Sans', fontSize: 15)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceEvenly, // Espacement égal entre les widgets
                              children: [
                                Container(
                                  width: 260,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(
                                        10), // Coins arrondis
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/apple.png',
                                        width: 65,
                                        height: 63,
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'Télécharger sur AppStore',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Arial'),
                                          ),
                                          Text(
                                            'AppStore',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontFamily: 'Arial Black'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 260,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(
                                        10), // Coins arrondis
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/playstore.png',
                                        width: 65,
                                        height: 63,
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'Télécharger sur PlayStore',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Arial'),
                                          ),
                                          Text(
                                            'PlayStore',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontFamily: 'Arial Black'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(top: 50.0),
                      child: Image.asset(
                        'assets/image2.png',
                        width: 400,
                        height: 300,
                      )),
                )
              ],
            ),

            // ⭐ SECTION AVANTAGES + SOUTRAPAY
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green.shade50,
                    Colors.blue.shade50,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Pourquoi choisir Soutrali Deals ?',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Découvrez les avantages qui nous différencient',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAdvantageCard(
                        icon: Icons.security,
                        title: 'Sécurité',
                        description: 'Transactions protégées et sécurisées',
                        color: Colors.red,
                      ),
                      _buildAdvantageCard(
                        icon: Icons.location_on,
                        title: 'Proximité',
                        description: 'Prestataires locaux à votre service',
                        color: Colors.blue,
                      ),
                      _buildAdvantageCard(
                        icon: Icons.speed,
                        title: 'Rapidité',
                        description: 'Service express et réactif',
                        color: Colors.orange,
                      ),
                      _buildAdvantageCard(
                        icon: Icons.diversity_3,
                        title: 'Diversité',
                        description: 'Large choix de services et métiers',
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),

                  // 💳 SECTION SOUTRAPAY
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.green.shade700,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'SoutraPay',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Vos paiements sécurisés',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Avec SoutraPay, payez vos prestations et services en toute sécurité via mobile money ou carte bancaire. Vos transactions sont protégées et rapides.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(Icons.credit_card,
                                      color: Colors.green.shade600),
                                  const SizedBox(width: 8),
                                  const Text('Cartes bancaires',
                                      style: TextStyle(fontSize: 14)),
                                  const SizedBox(width: 20),
                                  Icon(Icons.phone_android,
                                      color: Colors.green.shade600),
                                  const SizedBox(width: 8),
                                  const Text('Mobile Money',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Paiement Sécurisé',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Footer()
          ],
        ),
      ),
    );
  }

  // 🔧 MÉTHODES HELPER POUR LES SECTIONS
  Widget _buildStepCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      width: 200,
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
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              size: 40,
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

  Widget _buildStepArrow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.grey.shade400,
        size: 30,
      ),
    );
  }

  Widget _buildAdvantageCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      width: 200,
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
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              size: 40,
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

  // 👥 MÉTHODE POUR LES PRESTATAIRES POPULAIRES
  Widget _buildPopularProviderCard(int index) {
    final providers = [
      {
        'name': 'Kouadio Jean',
        'service': 'Coiffeur',
        'rating': 4.8,
        'image': 'assets/coiffeur.jpeg'
      },
      {
        'name': 'Yao Koffi',
        'service': 'Électricien',
        'rating': 4.9,
        'image': 'assets/coiffuer2.jpeg'
      },
      {
        'name': 'Koné Mariam',
        'service': 'Coiffeuse',
        'rating': 4.7,
        'image': 'assets/coiffeur.jpeg'
      },
      {
        'name': 'Traoré Ali',
        'service': 'Plombier',
        'rating': 4.9,
        'image': 'assets/coiffeur.jpeg'
      },
      {
        'name': 'Ouattara Fatou',
        'service': 'Nettoyage',
        'rating': 4.8,
        'image': 'assets/coiffeur.jpeg'
      },
      {
        'name': 'Diabaté Ibrahim',
        'service': 'Jardinier',
        'rating': 4.6,
        'image': 'assets/coiffeur.jpeg'
      },
    ];

    final provider = providers[index];

    return GestureDetector(
      onTap: () {
        context.go('/prestataire');
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
            // Photo du prestataire
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage(provider['image'] as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Informations
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      provider['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider['service'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${provider['rating']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
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

  // 🛠️ MÉTHODE POUR LES MÉTIERS
  Widget _buildMetierCard(String title, IconData icon, Color color) {
    return Container(
      width: 150,
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
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
