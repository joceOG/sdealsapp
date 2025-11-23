import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';
import 'package:sdealsapp/data/services/authCubit.dart';

import '../../../widget/Footer.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../homepagebloc/homePageBloc.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key}); // Test modification

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
                          // 🎯 BOUTON DÉCOUVRIR LES SERVICES MODERNE
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF1CBF3F).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                              context.go('/prestataire');
                            },
                                child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.explore,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                              'Découvrir les services',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // 🎯 BOUTON DEVENIR PRESTATAIRE MODERNE
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  // Vérifier l'état d'authentification
                                  final authState = context.read<AuthCubit>().state;
                                  if (authState is AuthAuthenticated) {
                                    // Utilisateur connecté - aller vers l'inscription prestataire
                                    context.go('/prestataire/inscription');
                                  } else {
                                    // Utilisateur non connecté - aller vers la connexion
                                    context.go('/connexion');
                                  }
                                },
                                child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.handyman,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                              'Devenir prestataire',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                          color: Colors.white,
                              ),
                            ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 16,
                          ),
                        ],
                                  ),
                                ),
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
            // 🎯 SECTION CATÉGORIES MODERNE 2025
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 48.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header avec espacement cohérent
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Top catégories',
                    style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                  const Text(
                    'Explorez nos services par catégorie',
                    style: TextStyle(
                      fontSize: 16,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
                      // Bouton "Voir tout" avec animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: TextButton(
                          onPressed: () => context.go('/prestataire'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF1CBF3F),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Voir tout',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🎨 GRILLE DE CATÉGORIES MODERNE
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              height: 200, // Réduit de 260 à 200
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state.listItems == null) {
                    return _buildModernLoadingState();
                  }

                  return ListView.builder(
                          scrollDirection: Axis.horizontal,
                    itemCount: state.listItems!.length,
                          itemBuilder: (context, index) {
                      return _buildAnimatedCategoryCard(
                        category: state.listItems![index],
                        index: index,
                        onTap: () => context.go('/prestataire'),
                      );
                          },
                        );
                },
              ),
            ),

            // 👥 SECTION PRESTATAIRES POPULAIRES MODERNE 2025
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 64.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade50,
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Header moderne avec bouton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prestataires Populaires',
                    style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                  const Text(
                    'Découvrez nos prestataires les mieux notés',
                    style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                          ),
                        ],
                      ),
                      // Bouton "Voir tout" avec animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: TextButton.icon(
                          onPressed: () => context.go('/prestataire'),
                          icon: const Icon(Icons.arrow_forward, size: 16),
                          label: const Text('Voir tout'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF1CBF3F),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Grille responsive des prestataires
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 3;
                      double crossAxisSpacing = 24;
                      double mainAxisSpacing = 24;
                      double childAspectRatio = 1.05; // Ratio plus compact (presque carré)

                      // Responsive breakpoints "Pro Expert"
                      if (constraints.maxWidth < 700) {
                        crossAxisCount = 1;
                        crossAxisSpacing = 16;
                        mainAxisSpacing = 16;
                        childAspectRatio = 1.2; // Plus large sur mobile
                      } else if (constraints.maxWidth < 1100) {
                        crossAxisCount = 2;
                        crossAxisSpacing = 20;
                        mainAxisSpacing = 20;
                        childAspectRatio = 0.95;
                      } else if (constraints.maxWidth < 1400) {
                        crossAxisCount = 3;
                        childAspectRatio = 0.9;
                      } else {
                        crossAxisCount = 4; // 4 colonnes sur grands écrans
                        childAspectRatio = 1.0;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: crossAxisSpacing,
                          mainAxisSpacing: mainAxisSpacing,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return _buildModernProviderCard(index);
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Bouton CTA moderne
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1CBF3F).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => context.go('/prestataire'),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                      'Voir tous les prestataires',
                      style: TextStyle(
                        fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🗺️ SECTION GÉOLOCALISATION MODERNE 2025
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 64.0, horizontal: 40.0),
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
                  // Header moderne
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Géolocalisation Prestataires',
                    style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                  const Text(
                    'Trouvez facilement les prestataires autour de vous grâce à notre système de géolocalisation en temps réel',
                    style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                          ),
                        ],
                      ),
                      // Bouton "Voir la carte" avec animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: TextButton.icon(
                          onPressed: () => context.go('/prestataire'),
                          icon: const Icon(Icons.map, size: 16),
                          label: const Text('Voir la carte'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF1CBF3F),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Carte interactive moderne
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _InteractiveMapWidget(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Statistiques et fonctionnalités
                  Row(
                        children: [
                      Expanded(
                        child: _buildLocationFeature(
                          icon: Icons.location_on,
                          title: 'Géolocalisation précise',
                          description:
                              'Trouvez les prestataires les plus proches',
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildLocationFeature(
                          icon: Icons.directions,
                          title: 'Itinéraires intégrés',
                          description:
                              'Navigation directe vers les prestataires',
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildLocationFeature(
                          icon: Icons.access_time,
                          title: 'Temps de réponse',
                          description: 'Estimation du temps d\'arrivée',
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🔧 SECTION TOP SERVICES MODERNE 2025
                          Container(
                            width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 64.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
              ),
                              child: Column(
                                children: [
                  // Header moderne
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Top Services',
                                    style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Découvrez nos services les plus populaires',
                                    style: TextStyle(
                                      fontSize: 16,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                      // Bouton "Voir tout" avec animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: TextButton.icon(
                          onPressed: () => context.go('/prestataire'),
                          icon: const Icon(Icons.arrow_forward, size: 16),
                          label: const Text('Voir tout'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF1CBF3F),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Liste des services avec BlocBuilder
                  BlocBuilder<HomePageBloc, HomePageState>(
                    builder: (context, state) {
                      if (state.listItems2 == null) {
                        return _buildModernLoadingState();
                      }

                      if (state.listItems2!.isEmpty) {
                        return _buildEmptyState();
                      }

                      return _buildServicesList(state.listItems2!);
                    },
                  ),
                ],
              ),
            ),

            // 🔍 SECTION "COMMENT ÇA MARCHE" MODERNE 2025
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade50,
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Header moderne
                  const Text(
                    'Comment ça marche ?',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '3 étapes simples pour obtenir le service dont vous avez besoin',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),

                  // Étapes avec layout responsive
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 768) {
                        // Layout mobile : vertical
                        return Column(
                          children: [
                            _buildModernStepCard(
                              icon: Icons.search,
                              title: '1. Trouver',
                              description: 'Recherchez un prestataire qualifié',
                              color: const Color(0xFF3B82F6),
                              index: 0,
                            ),
                            const SizedBox(height: 32),
                            _buildModernStepCard(
                              icon: Icons.book_online,
                              title: '2. Réserver',
                              description: 'Planifiez votre service en ligne',
                              color: const Color(0xFFF59E0B),
                              index: 1,
                            ),
                            const SizedBox(height: 32),
                            _buildModernStepCard(
                              icon: Icons.payment,
                              title: '3. Payer',
                              description: 'Paiement sécurisé avec SoutraPay',
                              color: const Color(0xFF1CBF3F),
                              index: 2,
                            ),
                          ],
                        );
                      } else {
                        // Layout desktop : horizontal avec flèches
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildModernStepCard(
                              icon: Icons.search,
                              title: '1. Trouver',
                              description: 'Recherchez un prestataire qualifié',
                              color: const Color(0xFF3B82F6),
                              index: 0,
                            ),
                            _buildModernStepArrow(),
                            _buildModernStepCard(
                              icon: Icons.book_online,
                              title: '2. Réserver',
                              description: 'Planifiez votre service en ligne',
                              color: const Color(0xFFF59E0B),
                              index: 1,
                            ),
                            _buildModernStepArrow(),
                            _buildModernStepCard(
                              icon: Icons.payment,
                              title: '3. Payer',
                              description: 'Paiement sécurisé avec SoutraPay',
                              color: const Color(0xFF1CBF3F),
                              index: 2,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            // 🛠️ SECTION "NOS MÉTIERS" MODERNE 2025
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
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
                  // Header moderne
                  const Text(
                    'Nos Métiers',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Découvrez plus de 100 métiers organisés en 10+ catégories',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),

                  // Métiers avec layout responsive
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 768) {
                        // Layout mobile : 2 colonnes
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildModernMetierCard(
                                  'Coiffure',
                                  Icons.content_cut,
                                  const Color(0xFFEC4899),
                                  0,
                                ),
                                _buildModernMetierCard(
                                  'Plomberie',
                                  Icons.build,
                                  const Color(0xFF3B82F6),
                                  1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildModernMetierCard(
                                  'Électricité',
                                  Icons.electrical_services,
                                  const Color(0xFFF59E0B),
                                  2,
                                ),
                                _buildModernMetierCard(
                                  'Nettoyage',
                                  Icons.cleaning_services,
                                  const Color(0xFF1CBF3F),
                                  3,
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // Layout desktop : horizontal
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildModernMetierCard(
                              'Coiffure',
                              Icons.content_cut,
                              const Color(0xFFEC4899),
                              0,
                            ),
                            _buildModernMetierCard(
                              'Plomberie',
                              Icons.build,
                              const Color(0xFF3B82F6),
                              1,
                            ),
                            _buildModernMetierCard(
                              'Électricité',
                              Icons.electrical_services,
                              const Color(0xFFF59E0B),
                              2,
                            ),
                            _buildModernMetierCard(
                              'Nettoyage',
                              Icons.cleaning_services,
                              const Color(0xFF1CBF3F),
                              3,
                            ),
                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 64),

                  // Bouton CTA moderne
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF1CBF3F)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => context.go('/prestataire'),
                        child: Padding(
                                padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Voir tous nos métiers',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                            ),
                          ),
                        ],
                      ),
                    ),

            // 📱 SECTION "QUE VOUS RECHERCHIEZ UN DJ" MODERNE 2025
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 768) {
                    // Layout mobile : vertical
                    return Column(
                      children: [
                        _buildModernHeroContent(),
                        const SizedBox(height: 40),
                        _buildModernAppImage(),
                      ],
                    );
                  } else {
                    // Layout desktop : horizontal
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildModernHeroContent(),
                        ),
                        const SizedBox(width: 60),
                        Expanded(
                          flex: 1,
                          child: _buildModernAppImage(),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),

            // ⭐ SECTION "POURQUOI CHOISIR SOUTRALI DEALS" MODERNE 2025
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
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
                  // Header moderne
                  const Text(
                    'Pourquoi choisir Soutrali Deals ?',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Découvrez les avantages qui nous différencient',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),

                  // Avantages avec layout responsive
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 768) {
                        // Layout mobile : 2 colonnes
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildModernAdvantageCard(
                                  icon: Icons.security,
                                  title: 'Sécurité',
                                  description:
                                      'Transactions protégées et sécurisées',
                                  color: const Color(0xFFEF4444),
                                  index: 0,
                                ),
                                _buildModernAdvantageCard(
                                  icon: Icons.location_on,
                                  title: 'Proximité',
                                  description:
                                      'Prestataires locaux à votre service',
                                  color: const Color(0xFF3B82F6),
                                  index: 1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildModernAdvantageCard(
                                  icon: Icons.speed,
                                  title: 'Rapidité',
                                  description: 'Service express et réactif',
                                  color: const Color(0xFFF59E0B),
                                  index: 2,
                                ),
                                _buildModernAdvantageCard(
                                  icon: Icons.diversity_3,
                                  title: 'Diversité',
                                  description:
                                      'Large choix de services et métiers',
                                  color: const Color(0xFF8B5CF6),
                                  index: 3,
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // Layout desktop : horizontal
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildModernAdvantageCard(
                              icon: Icons.security,
                              title: 'Sécurité',
                              description:
                                  'Transactions protégées et sécurisées',
                              color: const Color(0xFFEF4444),
                              index: 0,
                            ),
                            _buildModernAdvantageCard(
                              icon: Icons.location_on,
                              title: 'Proximité',
                              description:
                                  'Prestataires locaux à votre service',
                              color: const Color(0xFF3B82F6),
                              index: 1,
                            ),
                            _buildModernAdvantageCard(
                              icon: Icons.speed,
                              title: 'Rapidité',
                              description: 'Service express et réactif',
                              color: const Color(0xFFF59E0B),
                              index: 2,
                            ),
                            _buildModernAdvantageCard(
                              icon: Icons.diversity_3,
                              title: 'Diversité',
                              description: 'Large choix de services et métiers',
                              color: const Color(0xFF8B5CF6),
                              index: 3,
                            ),
                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 80),

                  // 💳 SECTION SOUTRAPAY MODERNE
                  _buildModernSoutraPaySection(),
                ],
              ),
            ),

            Footer()
          ],
        ),
      ),
    );
  }

  // 🎨 MÉTHODES HELPER POUR LES CATÉGORIES MODERNES

  Widget _buildModernLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1CBF3F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                      child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1CBF3F)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Chargement des catégories...',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
                      ),
                    );
                  }

  // 🎨 WIDGET ANIMÉ POUR LES CARTES DE CATÉGORIES
  Widget _buildAnimatedCategoryCard({
    required dynamic category,
    required int index,
    required VoidCallback onTap,
  }) {
    return _AnimatedCategoryCard(
      category: category,
      index: index,
      onTap: onTap,
    );
  }
}

// 🎨 WIDGET ANIMÉ POUR LES CARTES DE CATÉGORIES
class _AnimatedCategoryCard extends StatefulWidget {
  final dynamic category;
  final int index;
  final VoidCallback onTap;

  const _AnimatedCategoryCard({
    required this.category,
    required this.index,
    required this.onTap,
  });

  @override
  State<_AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<_AnimatedCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 4.0,
      end: 12.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.08),
      end: Colors.black.withOpacity(0.20),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _animationController.forward();
  }

  void _onHoverExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: MouseRegion(
        onEnter: (_) => _onHoverEnter(),
        onExit: (_) => _onHoverExit(),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                          color: _shadowColorAnimation.value ??
                              Colors.black.withOpacity(0.08),
                          blurRadius: _elevationAnimation.value * 2,
                          offset: Offset(0, _elevationAnimation.value),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                          // Image de fond avec gradient overlay
                                Positioned.fill(
                                  child: Image.network(
                              widget.category.imagecategorie,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF1CBF3F)
                                            .withOpacity(0.8),
                                        const Color(0xFF16A34A)
                                            .withOpacity(0.9),
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.category,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          // Gradient overlay pour la lisibilité
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                    Colors.black
                                        .withOpacity(_isHovered ? 0.8 : 0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          // Contenu de la carte avec animation
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.all(_isHovered ? 20 : 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Nom de la catégorie
                                  Text(
                                    widget.category.nomcategorie,
                                    style: TextStyle(
                                      fontSize: _isHovered ? 17 : 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: -0.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  // Indicateur d'action avec animation
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Découvrir',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _isHovered
                                                ? Colors.white
                                                : Colors.white70,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        AnimatedRotation(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          turns: _isHovered ? 0.25 : 0.0,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 12,
                                            color: _isHovered
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Badge de popularité avec animation
                          if (widget.index < 3)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                  horizontal: _isHovered ? 10 : 8,
                                  vertical: _isHovered ? 6 : 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1CBF3F),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _isHovered
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFF1CBF3F)
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                    child: Text(
                                  'Populaire',
                                  style: TextStyle(
                                    fontSize: _isHovered ? 11 : 10,
                                    fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          // Overlay de hover avec animation
                          if (_isHovered)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFF1CBF3F)
                                        .withOpacity(0.5),
                                    width: 2,
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
                  );
                },
              ),
            ),
    );
  }
}

// 👥 WIDGET ANIMÉ POUR LES CARTES DE PRESTATAIRES
class _AnimatedProviderCard extends StatefulWidget {
  final int index;
  final VoidCallback onTap;

  const _AnimatedProviderCard({
    required this.index,
    required this.onTap,
  });

  @override
  State<_AnimatedProviderCard> createState() => _AnimatedProviderCardState();
}

class _AnimatedProviderCardState extends State<_AnimatedProviderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;
  late Animation<double> _borderAnimation;

  bool _isHovered = false;

  final List<Map<String, dynamic>> _providers = [
    {
      'name': 'Kouadio Jean',
      'service': 'Coiffeur',
      'rating': 4.8,
      'image': 'assets/coiffeur.jpeg',
      'verified': true,
      'reviews': 24,
      'location': 'Abidjan, Cocody',
      'price': 'À partir de 5 000 FCFA',
      'responseTime': '2h',
    },
    {
      'name': 'Yao Koffi',
      'service': 'Électricien',
      'rating': 4.9,
      'image': 'assets/coiffuer2.jpeg',
      'verified': true,
      'reviews': 18,
      'location': 'Abidjan, Yopougon',
      'price': 'À partir de 8 000 FCFA',
      'responseTime': '1h',
    },
    {
      'name': 'Koné Mariam',
      'service': 'Coiffeuse',
      'rating': 4.7,
      'image': 'assets/coiffeur.jpeg',
      'verified': false,
      'reviews': 12,
      'location': 'Abidjan, Marcory',
      'price': 'À partir de 4 500 FCFA',
      'responseTime': '3h',
    },
    {
      'name': 'Traoré Ali',
      'service': 'Plombier',
      'rating': 4.9,
      'image': 'assets/coiffeur.jpeg',
      'verified': true,
      'reviews': 31,
      'location': 'Abidjan, Plateau',
      'price': 'À partir de 7 000 FCFA',
      'responseTime': '1h',
    },
    {
      'name': 'Ouattara Fatou',
      'service': 'Nettoyage',
      'rating': 4.8,
      'image': 'assets/coiffeur.jpeg',
      'verified': true,
      'reviews': 15,
      'location': 'Abidjan, Riviera',
      'price': 'À partir de 3 000 FCFA',
      'responseTime': '2h',
    },
    {
      'name': 'Diabaté Ibrahim',
      'service': 'Jardinier',
      'rating': 4.6,
      'image': 'assets/coiffeur.jpeg',
      'verified': false,
      'reviews': 8,
      'location': 'Abidjan, Angré',
      'price': 'À partir de 6 000 FCFA',
      'responseTime': '4h',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: Colors.black.withOpacity(0.25),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _borderAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _animationController.forward();
  }

  void _onHoverExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final provider = _providers[widget.index];

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (widget.index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: MouseRegion(
              onEnter: (_) => _onHoverEnter(),
              onExit: (_) => _onHoverExit(),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24), // Coins plus arrondis
                        border: Border.all(
                          color: Color.lerp(
                            Colors.grey.shade200,
                            const Color(0xFF1CBF3F),
                            _borderAnimation.value,
                          )!,
                          width: _isHovered ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _shadowColorAnimation.value ??
                                Colors.black.withOpacity(0.05),
                            blurRadius: _elevationAnimation.value,
                            offset: Offset(0, _elevationAnimation.value * 0.4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: widget.onTap,
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center, // Centré pour le look "Pro"
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Photo et Badge
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: _isHovered ? 85 : 80, // Photo plus grande
                                    height: _isHovered ? 85 : 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF1CBF3F),
                                        width: _isHovered ? 3 : 2,
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            provider['image'] as String),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (provider['verified'] as bool)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.verified,
                                          color: Color(0xFF1CBF3F),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Nom et Service
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  children: [
                                    Text(
                                      provider['name'] as String,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1E293B),
                                        letterSpacing: -0.5,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        provider['service'] as String,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF64748B),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Infos (Note & Localisation)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star_rounded,
                                      size: 16, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${provider['rating']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFCBD5E1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Icon(Icons.location_on,
                                      size: 14, color: Color(0xFF94A3B8)),
                                  const SizedBox(width: 2),
                                  Flexible(
                                    child: Text(
                                      (provider['location'] as String).split(',')[1].trim(), // Juste la ville/quartier
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF64748B),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Bouton "Voir Profil" (Apparaît au survol ou discret)
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: _isHovered ? 1.0 : 0.0, // Visible seulement au survol
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 24),
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF1CBF3F).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Voir le profil',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Si pas survolé, afficher le prix à la place
                              if (!_isHovered)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    provider['price'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1CBF3F),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

// 🗺️ WIDGET DE CARTE INTERACTIVE MODERNE
class _InteractiveMapWidget extends StatefulWidget {
  @override
  State<_InteractiveMapWidget> createState() => _InteractiveMapWidgetState();
}

class _InteractiveMapWidgetState extends State<_InteractiveMapWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _isLoading = true;
  String? _userLocation;
  List<Map<String, dynamic>> _nearbyProviders = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _initializeMap();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeMap() async {
    // Simuler le chargement des données
    await Future.delayed(const Duration(milliseconds: 500));

    // Simuler la géolocalisation utilisateur
    _userLocation = "Abidjan, Côte d'Ivoire";

    // Simuler les prestataires à proximité
    _nearbyProviders = [
      {
        'name': 'Kouadio Jean',
        'service': 'Coiffeur',
        'distance': '0.8 km',
        'rating': 4.8,
        'verified': true,
        'available': true,
      },
      {
        'name': 'Yao Koffi',
        'service': 'Électricien',
        'distance': '1.2 km',
        'rating': 4.9,
        'verified': true,
        'available': true,
      },
      {
        'name': 'Koné Mariam',
        'service': 'Coiffeuse',
        'distance': '2.1 km',
        'rating': 4.7,
        'verified': false,
        'available': false,
      },
    ];

    setState(() {
      _isLoading = false;
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade100,
                    Colors.green.shade100,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Fond de carte stylisé
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade50,
                    Colors.green.shade50,
                  ],
                ),
              ),
                      child: CustomPaint(
                        painter: _MapBackgroundPainter(),
                      ),
                    ),
                  ),

                  // Marqueurs de prestataires
                  ..._buildProviderMarkers(),

                  // Marqueur utilisateur (centre)
                  Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1CBF3F),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1CBF3F).withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Contrôles de la carte
                  Positioned(
                    top: 16,
                    right: 16,
              child: Column(
                children: [
                        _buildMapControl(
                          icon: Icons.my_location,
                          onTap: () => _centerOnUser(),
                        ),
                        const SizedBox(height: 8),
                        _buildMapControl(
                          icon: Icons.zoom_in,
                          onTap: () => _zoomIn(),
                        ),
                        const SizedBox(height: 8),
                        _buildMapControl(
                          icon: Icons.zoom_out,
                          onTap: () => _zoomOut(),
                        ),
                      ],
                    ),
                  ),

                  // Informations de localisation
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: _buildLocationInfo(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1CBF3F)),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
                  const Text(
              'Chargement de la carte...',
                    style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
                  const Text(
              'Localisation des prestataires à proximité',
                    style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProviderMarkers() {
    return _nearbyProviders.asMap().entries.map((entry) {
      final index = entry.key;
      final provider = entry.value;
      final angle =
          (index * 120.0) * (3.14159 / 180); // 120° entre chaque marqueur
      final radius = 80.0;

      return Positioned(
        left: 200 + radius * cos(angle) - 15,
        top: 200 + radius * sin(angle) - 15,
        child: _buildProviderMarker(provider, index),
      );
    }).toList();
  }

  Widget _buildProviderMarker(Map<String, dynamic> provider, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: provider['verified']
                  ? const Color(0xFF1CBF3F)
                  : Colors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: (provider['verified']
                          ? const Color(0xFF1CBF3F)
                          : Colors.orange)
                      .withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              provider['verified'] ? Icons.verified : Icons.person,
              color: Colors.white,
              size: 16,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMapControl(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Icon(
            icon,
            color: const Color(0xFF1CBF3F),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
                    children: [
              Icon(
                Icons.location_on,
                color: const Color(0xFF1CBF3F),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Votre position: $_userLocation',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${_nearbyProviders.length} prestataires à proximité',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  void _centerOnUser() {
    // Animation pour centrer sur l'utilisateur
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Centré sur votre position')),
    );
  }

  void _zoomIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Zoom avant')),
    );
  }

  void _zoomOut() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Zoom arrière')),
    );
  }
}

// 🎨 PAINTER POUR LE FOND DE CARTE
class _MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 1.0;

    // Dessiner des lignes de grille
    for (int i = 0; i < size.width; i += 40) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    for (int i = 0; i < size.height; i += 40) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 🔧 MÉTHODES HELPER POUR LES SECTIONS

// 🔍 MÉTHODES POUR LA SECTION "COMMENT ÇA MARCHE"
Widget _buildModernStepCard({
  required IconData icon,
  required String title,
  required String description,
  required Color color,
  required int index,
}) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 600 + (index * 200)),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(
          opacity: value,
          child: _AnimatedStepCard(
            icon: icon,
            title: title,
            description: description,
            color: color,
            index: index,
          ),
        ),
      );
    },
  );
}

Widget _buildModernStepArrow() {
  return TweenAnimationBuilder<double>(
    duration: const Duration(milliseconds: 800),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.scale(
        scale: value,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF1CBF3F).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward,
            color: const Color(0xFF1CBF3F),
            size: 20,
          ),
        ),
      );
    },
  );
}

// 🎨 WIDGET ANIMÉ POUR LES CARTES D'ÉTAPES
class _AnimatedStepCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final int index;

  const _AnimatedStepCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.index,
  });

  @override
  State<_AnimatedStepCard> createState() => _AnimatedStepCardState();
}

class _AnimatedStepCardState extends State<_AnimatedStepCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: Colors.black.withOpacity(0.25),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _animationController.forward();
  }

  void _onHoverExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _shadowColorAnimation.value ??
                        Colors.black.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Icône avec animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _isHovered ? 80 : 70,
                    height: _isHovered ? 80 : 70,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: widget.color.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: _isHovered ? 36 : 32,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Titre
                  Text(
                    widget.title,
                      style: TextStyle(
                      fontSize: _isHovered ? 20 : 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                      letterSpacing: -0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 🛠️ MÉTHODES POUR LA SECTION "NOS MÉTIERS"
Widget _buildModernMetierCard(
    String title, IconData icon, Color color, int index) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 600 + (index * 150)),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(
          opacity: value,
          child: _AnimatedMetierCard(
            title: title,
            icon: icon,
            color: color,
            index: index,
          ),
        ),
      );
    },
  );
}

// 🎨 WIDGET ANIMÉ POUR LES CARTES DE MÉTIERS
class _AnimatedMetierCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int index;

  const _AnimatedMetierCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.index,
  });

  @override
  State<_AnimatedMetierCard> createState() => _AnimatedMetierCardState();
}

class _AnimatedMetierCardState extends State<_AnimatedMetierCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 24.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: Colors.black.withOpacity(0.3),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _animationController.forward();
  }

  void _onHoverExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 160,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _shadowColorAnimation.value ??
                        Colors.black.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => context.go('/prestataire'),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
              children: [
                        // Icône avec animation
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: _isHovered ? 60 : 50,
                          height: _isHovered ? 60 : 50,
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: _isHovered
                                ? [
                                    BoxShadow(
                                      color: widget.color.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            widget.icon,
                            color: widget.color,
                            size: _isHovered ? 28 : 24,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Titre
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: _isHovered ? 16 : 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                            letterSpacing: -0.2,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 📱 MÉTHODES POUR LA SECTION "QUE VOUS RECHERCHIEZ UN DJ"
Widget _buildModernHeroContent() {
  return TweenAnimationBuilder<double>(
    duration: const Duration(milliseconds: 800),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(
          opacity: value,
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              // Titre principal
              const Text(
                'Que vous recherchiez un DJ, un plombier ou un avocat...',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),

              // Sous-titre
              const Text(
                            'Nous vous trouvons les meilleurs, gratuitement.',
                            style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1CBF3F),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 24),

              // Description
              const Text(
                            'Consultez les profils, discutez avec les professionnels, aussi depuis notre application mobile.',
                            style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Boutons de téléchargement
              _buildModernDownloadButtons(),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildModernAppImage() {
  return TweenAnimationBuilder<double>(
    duration: const Duration(milliseconds: 1000),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.scale(
        scale: value,
        child: Opacity(
          opacity: value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/image2.png',
                width: 400,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1CBF3F).withOpacity(0.8),
                          const Color(0xFF16A34A).withOpacity(0.9),
                                    ],
                                  ),
                                ),
                    child: const Center(
                      child: Icon(
                        Icons.phone_android,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildModernDownloadButtons() {
  return Row(
    children: [
      Expanded(
        child: _buildModernAppStoreButton(),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildModernPlayStoreButton(),
      ),
    ],
  );
}

Widget _buildModernAppStoreButton() {
  return _AnimatedDownloadButton(
    icon: 'assets/apple.png',
    title: 'Télécharger sur',
    storeName: 'App Store',
    color: Colors.black,
    onTap: () {
      // Navigation vers App Store
    },
  );
}

Widget _buildModernPlayStoreButton() {
  return _AnimatedDownloadButton(
    icon: 'assets/playstore.png',
    title: 'Télécharger sur',
    storeName: 'Play Store',
    color: Colors.black,
    onTap: () {
      // Navigation vers Play Store
    },
  );
}

// 🎨 WIDGET ANIMÉ POUR LES BOUTONS DE TÉLÉCHARGEMENT
class _AnimatedDownloadButton extends StatefulWidget {
  final String icon;
  final String title;
  final String storeName;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedDownloadButton({
    required this.icon,
    required this.title,
    required this.storeName,
    required this.color,
    required this.onTap,
  });

  @override
  State<_AnimatedDownloadButton> createState() =>
      _AnimatedDownloadButtonState();
}

class _AnimatedDownloadButtonState extends State<_AnimatedDownloadButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 16.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _animationController.forward();
  }

  void _onHoverExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: widget.onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                        // Icône
                                      Image.asset(
                          widget.icon,
                          width: 48,
                          height: 48,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.smartphone,
                                color: Colors.white,
                                size: 24,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),

                        // Texte
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                widget.title,
                                style: const TextStyle(
                                                color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                          ),
                                          Text(
                                widget.storeName,
                                style: const TextStyle(
                                                color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ⭐ MÉTHODES POUR LA SECTION "POURQUOI CHOISIR SOUTRALI DEALS"
Widget _buildModernAdvantageCard({
  required IconData icon,
  required String title,
  required String description,
  required Color color,
  required int index,
}) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 600 + (index * 150)),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(
          opacity: value,
          child: _AnimatedAdvantageCard(
            icon: icon,
            title: title,
            description: description,
            color: color,
            index: index,
          ),
        ),
      );
    },
  );
}

// 🎨 WIDGET ANIMÉ POUR LES CARTES D'AVANTAGES
class _AnimatedAdvantageCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final int index;

  const _AnimatedAdvantageCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.index,
  });

  @override
  State<_AnimatedAdvantageCard> createState() => _AnimatedAdvantageCardState();
}

class _AnimatedAdvantageCardState extends State<_AnimatedAdvantageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: Colors.black.withOpacity(0.25),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _animationController.forward();
  }

  void _onHoverExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _shadowColorAnimation.value ??
                        Colors.black.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Icône avec animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _isHovered ? 80 : 70,
                    height: _isHovered ? 80 : 70,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: widget.color.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: _isHovered ? 36 : 32,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Titre
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: _isHovered ? 20 : 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                      letterSpacing: -0.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 💳 MÉTHODES POUR LA SECTION SOUTRAPAY
Widget _buildModernSoutraPaySection() {
  return TweenAnimationBuilder<double>(
    duration: const Duration(milliseconds: 1000),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(
          opacity: value,
          child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
              borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 768) {
                  // Layout mobile : vertical
                  return Column(
                    children: [
                      _buildSoutraPayContent(),
                      const SizedBox(height: 32),
                      _buildSoutraPayVisual(),
                    ],
                  );
                } else {
                  // Layout desktop : horizontal
                  return Row(
                      children: [
                        Expanded(
                          flex: 2,
                        child: _buildSoutraPayContent(),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 1,
                        child: _buildSoutraPayVisual(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildSoutraPayContent() {
  return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
      // Header avec icône
                              Row(
                                children: [
                                  Container(
            padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
              color: const Color(0xFF1CBF3F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
                                    ),
            child: const Icon(
                                      Icons.account_balance_wallet,
              color: Color(0xFF1CBF3F),
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'SoutraPay',
                                    style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
      const SizedBox(height: 24),

      // Titre
                              const Text(
                                'Vos paiements sécurisés',
                                style: TextStyle(
          fontSize: 24,
                                  fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
          letterSpacing: -0.2,
                                ),
                              ),
      const SizedBox(height: 16),

      // Description
                              const Text(
                                'Avec SoutraPay, payez vos prestations et services en toute sécurité via mobile money ou carte bancaire. Vos transactions sont protégées et rapides.',
                                style: TextStyle(
                                  fontSize: 16,
          color: Color(0xFF64748B),
          height: 1.6,
                                ),
                              ),
      const SizedBox(height: 24),

      // Méthodes de paiement
                              Row(
                                children: [
          _buildPaymentMethod(
            icon: Icons.credit_card,
            label: 'Cartes bancaires',
            color: const Color(0xFF1CBF3F),
          ),
          const SizedBox(width: 32),
          _buildPaymentMethod(
            icon: Icons.phone_android,
            label: 'Mobile Money',
            color: const Color(0xFF1CBF3F),
                              ),
                            ],
                          ),
    ],
  );
}

Widget _buildSoutraPayVisual() {
  return Container(
                            height: 200,
                            decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF1CBF3F).withOpacity(0.1),
          const Color(0xFF16A34A).withOpacity(0.1),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment,
            size: 64,
            color: Color(0xFF1CBF3F),
                                  ),
          SizedBox(height: 16),
                                  Text(
                                    'Paiement Sécurisé',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPaymentMethod({
  required IconData icon,
  required String label,
  required Color color,
}) {
  return Row(
    children: [
      Icon(icon, color: color, size: 20),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1E293B),
        ),
      ),
    ],
  );
}

// 📋 MÉTHODES POUR LA SECTION SERVICES
Widget _buildModernLoadingState() {
  return Container(
    height: 280,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1CBF3F).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1CBF3F)),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Chargement des services...',
                                    style: TextStyle(
                                      fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Récupération des services populaires',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
  );
}

Widget _buildEmptyState() {
  return Container(
    height: 280,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.work_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Aucun service disponible',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Les services seront bientôt disponibles',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
    ),
  );
}

Widget _buildServicesList(List<dynamic> services) {
  return SizedBox(
    height: 280,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildModernServiceCard(service, index);
      },
    ),
  );
}

Widget _buildModernServiceCard(dynamic service, int index) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 400 + (index * 100)),
    tween: Tween(begin: 0.0, end: 1.0),
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: Opacity(
          opacity: value,
          child: Container(
            width: 200,
            margin: const EdgeInsets.only(right: 24),
            child: _AnimatedServiceCard(
              service: service,
              index: index,
              onTap: () {
                // Navigation vers prestataire
              },
            ),
          ),
        ),
      );
    },
  );
}

// 🎨 WIDGET ANIMÉ POUR LES CARTES DE SERVICES
class _AnimatedServiceCard extends StatefulWidget {
  final dynamic service;
  final int index;
  final VoidCallback onTap;

  const _AnimatedServiceCard({
    required this.service,
    required this.index,
    required this.onTap,
  });

  @override
  State<_AnimatedServiceCard> createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<_AnimatedServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: Colors.black.withOpacity(0.25),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _animationController.forward();
  }

  void _onHoverExit() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _shadowColorAnimation.value ??
                        Colors.black.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Image du service
                        Positioned.fill(
                          child: Image.network(
                            widget.service.imageservice,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFF1CBF3F).withOpacity(0.8),
                                      const Color(0xFF16A34A).withOpacity(0.9),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.work,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black
                                      .withOpacity(_isHovered ? 0.8 : 0.7),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Badge "Populaire" pour les premiers services
                        if (widget.index < 3)
                          Positioned(
                            top: 12,
                            right: 12,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: _isHovered ? 10 : 8,
                                vertical: _isHovered ? 6 : 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1CBF3F),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: _isHovered
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF1CBF3F)
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Text(
                                'Populaire',
                                style: TextStyle(
                                  fontSize: _isHovered ? 11 : 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                        // Contenu de la carte
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.all(_isHovered ? 20 : 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Nom du service
                                Text(
                                  widget.service.nomservice,
                                  style: TextStyle(
                                    fontSize: _isHovered ? 18 : 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: -0.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),

                                // Indicateur d'action avec animation
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Découvrir',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _isHovered
                                              ? Colors.white
                                              : Colors.white70,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      AnimatedRotation(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        turns: _isHovered ? 0.25 : 0.0,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: 12,
                                          color: _isHovered
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Overlay de hover avec animation
                        if (_isHovered)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      const Color(0xFF1CBF3F).withOpacity(0.5),
                                  width: 2,
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
          );
        },
      ),
    );
  }
}

Widget _buildLocationFeature({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
      borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          offset: const Offset(0, 4),
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
            borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: color,
            size: 28,
            ),
          ),
        const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
          textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
            color: Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

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
Widget _buildModernProviderCard(int index) {
  return _AnimatedProviderCard(
    index: index,
    onTap: () {
      // Navigation vers prestataire
    },
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
