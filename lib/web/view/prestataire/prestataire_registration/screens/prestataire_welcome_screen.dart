import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 🎯 ÉCRAN D'ACCUEIL PRESTATAIRE MODERNE 2025
class PrestataireWelcomeScreen extends StatelessWidget {
  const PrestataireWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Bouton fixe en bas de l'écran
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4CAF50).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                context.push('/prestataire/registration');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.rocket_launch,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'COMMENCER MON INSCRIPTION',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section moderne
            _buildHeaderSection(context),

            // Avantages section moderne
            _buildAdvantagesSection(),

            // Métiers section moderne
            _buildCategoriesSection(context),

            // Espace supplémentaire en bas pour éviter que le bouton fixe ne cache du contenu
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 🎯 HEADER SECTION MODERNE
  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2E7D32),
            const Color(0xFF4CAF50),
            const Color(0xFF66BB6A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          // Pattern décoratif
          Positioned(
            top: 50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Contenu principal
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 100, 40, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre principal
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.handyman,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Devenir Prestataire',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sous-titre
                  const Text(
                    'Rejoignez notre communauté de prestataires professionnels et développez votre activité',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Badges de confiance
                  Row(
                    children: [
                      _buildTrustBadge('✓ Vérifiés', Icons.verified),
                      const SizedBox(width: 16),
                      _buildTrustBadge('✓ Sécurisés', Icons.security),
                      const SizedBox(width: 16),
                      _buildTrustBadge('✓ Payés', Icons.payment),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 BADGE DE CONFIANCE
  Widget _buildTrustBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 SECTION AVANTAGES MODERNE
  Widget _buildAdvantagesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de section
          const Text(
            'Pourquoi devenir prestataire ?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Découvrez tous les avantages de rejoindre notre plateforme',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 48),

          // Grille des avantages
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 1200 ? 3 : 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.2,
                ),
                itemCount: _advantages.length,
                itemBuilder: (context, index) {
                  return _buildAdvantageCard(_advantages[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // 🎯 CARTE D'AVANTAGE MODERNE
  Widget _buildAdvantageCard(Map<String, dynamic> advantage) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (advantage['index'] as int) * 100),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: advantage['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      advantage['icon'],
                      color: advantage['color'],
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    advantage['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    advantage['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 🎯 SECTION MÉTIERS MODERNE
  Widget _buildCategoriesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de section
          const Text(
            'Nos métiers',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Choisissez votre domaine d\'expertise',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 48),

          // Grille des métiers
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 1200 ? 4 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.1,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(_categories[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // 🎯 CARTE DE MÉTIER MODERNE
  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (category['index'] as int) * 100),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: category['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      category['icon'],
                      color: category['color'],
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 🎯 DONNÉES DES AVANTAGES
  static final List<Map<String, dynamic>> _advantages = [
    {
      'icon': Icons.trending_up,
      'title': 'Développez votre activité',
      'description': 'Accédez à de nouveaux clients et augmentez vos revenus',
      'color': const Color(0xFF4CAF50),
      'index': 0,
    },
    {
      'icon': Icons.schedule,
      'title': 'Gérez votre planning',
      'description': 'Organisez vos missions selon vos disponibilités',
      'color': const Color(0xFF2196F3),
      'index': 1,
    },
    {
      'icon': Icons.payment,
      'title': 'Paiements sécurisés',
      'description': 'Recevez vos paiements rapidement et en toute sécurité',
      'color': const Color(0xFF9C27B0),
      'index': 2,
    },
    {
      'icon': Icons.verified_user,
      'title': 'Profil vérifié',
      'description':
          'Bénéficiez de la confiance des clients avec un profil vérifié',
      'color': const Color(0xFFFF9800),
      'index': 3,
    },
    {
      'icon': Icons.support_agent,
      'title': 'Support dédié',
      'description': 'Une équipe à votre écoute pour vous accompagner',
      'color': const Color(0xFFE91E63),
      'index': 4,
    },
    {
      'icon': Icons.analytics,
      'title': 'Statistiques détaillées',
      'description': 'Suivez vos performances et optimisez votre activité',
      'color': const Color(0xFF00BCD4),
      'index': 5,
    },
  ];

  // 🎯 DONNÉES DES CATÉGORIES
  static final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.build,
      'name': 'Bricolage',
      'color': const Color(0xFF4CAF50),
      'index': 0,
    },
    {
      'icon': Icons.cleaning_services,
      'name': 'Ménage',
      'color': const Color(0xFF2196F3),
      'index': 1,
    },
    {
      'icon': Icons.directions_car,
      'name': 'Transport',
      'color': const Color(0xFFFF9800),
      'index': 2,
    },
    {
      'icon': Icons.computer,
      'name': 'Informatique',
      'color': const Color(0xFF9C27B0),
      'index': 3,
    },
    {
      'icon': Icons.psychology,
      'name': 'Coaching',
      'color': const Color(0xFFE91E63),
      'index': 4,
    },
    {
      'icon': Icons.music_note,
      'name': 'Musique',
      'color': const Color(0xFF00BCD4),
      'index': 5,
    },
    {
      'icon': Icons.camera_alt,
      'name': 'Photographie',
      'color': const Color(0xFF795548),
      'index': 6,
    },
    {
      'icon': Icons.school,
      'name': 'Formation',
      'color': const Color(0xFF607D8B),
      'index': 7,
    },
  ];
}
