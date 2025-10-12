import 'package:flutter/material.dart';

class AproposScreen extends StatefulWidget {
  const AproposScreen({Key? key}) : super(key: key);

  @override
  State<AproposScreen> createState() => _AproposScreenState();
}

class _AproposScreenState extends State<AproposScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Démarrer les animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(),
          _buildMissionSection(),
          _buildHistoireSection(),
          _buildEquipeSection(),
          _buildServicesSection(),
          _buildSdealsIdentificationSection(),
          _buildValeursSection(),
          _buildContactSection(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F),
            const Color(0xFF16A34A),
            const Color(0xFF059669),
          ],
        ),
        image: const DecorationImage(
          image: AssetImage('assets/accueil.jpg'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Stack(
        children: [
          // Particules flottantes animées
          ...List.generate(20, (index) => _buildFloatingParticle(index)),

          // Contenu principal
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo animé
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.public,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Titre principal avec effet de texte
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.white, Colors.yellow, Colors.white],
                          ).createShader(bounds),
                          child: const Text(
                            'Qui sommes-nous ?',
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sous-titre avec animation
                        AnimatedBuilder(
                          animation: _fadeAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset:
                                  Offset(0, 20 * (1 - _fadeAnimation.value)),
                              child: Opacity(
                                opacity: _fadeAnimation.value,
                                child: const Text(
                                  'La révolution digitale de l\'artisanat ivoirien',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),

                        // Description avec effet de révélation
                        AnimatedBuilder(
                          animation: _fadeAnimation,
                          builder: (context, child) {
                            return Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Soutrali Deals est une plateforme numérique ivoirienne innovante qui relie les artisans, prestataires indépendants, commerçants et clients dans un écosystème unique.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Nous facilitons la visibilité, la promotion et la gestion digitale des métiers artisanaux et informels, tout en créant des opportunités d\'emploi et de revenus durables à travers la technologie.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),

                        // Bouton CTA animé
                        AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.white, Colors.yellow],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Découvrir notre mission',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1CBF3F),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Positioned(
          left: (index * 50.0) % MediaQuery.of(context).size.width,
          top: (index * 30.0) % MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: (1 - _fadeAnimation.value) * 0.6,
            child: Container(
              width: 4 + (index % 3) * 2,
              height: 4 + (index % 3) * 2,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMissionSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[50]!,
            Colors.white,
            Colors.grey[100]!,
          ],
        ),
      ),
      child: Column(
        children: [
          // Titre avec animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOutCubic,
              )),
              child: Column(
                children: [
                  const Text(
                    'Notre Mission',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Section Mission améliorée
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1CBF3F).withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: const Color(0xFF1CBF3F).withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Titre de la mission
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _fadeController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1CBF3F),
                                    Color(0xFF16A34A)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF1CBF3F)
                                        .withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              'Notre Mission',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Notre mission est claire :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Points de mission avec animations
                Row(
                  children: [
                    Expanded(
                      child: _buildMissionPoint(
                        'Donner une identité numérique à chaque artisan et prestataire',
                        Icons.badge,
                        const Color(0xFF1CBF3F),
                        0,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildMissionPoint(
                        'Simplifier l\'accès aux services et produits locaux',
                        Icons.accessibility_new,
                        const Color(0xFF16A34A),
                        1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildMissionPoint(
                        'Stimuler la confiance et la transparence dans les échanges',
                        Icons.verified_user,
                        const Color(0xFF059669),
                        2,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildMissionPoint(
                        'Créer des ponts entre innovation technologique et économie réelle',
                        Icons.link,
                        const Color(0xFF0D9488),
                        3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Citation inspirante
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1CBF3F).withOpacity(0.1),
                          const Color(0xFF16A34A).withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF1CBF3F).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.format_quote,
                          size: 40,
                          color: Color(0xFF1CBF3F),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Chez Soutrali Deals, nous croyons que chaque talent mérite d\'être vu, soutenu et connecté au monde.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF1E293B),
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 60,
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionPoint(
      String text, IconData icon, Color color, int delay) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        final delayedAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            delay * 0.15,
            (delay * 0.15) + 0.7,
            curve: Curves.easeOutCubic,
          ),
        ));

        return Transform.translate(
          offset: Offset(0, 30 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: delayedAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
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
  }

  Widget _buildHistoireSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.05),
            Colors.white,
            const Color(0xFF16A34A).withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          // Titre avec animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOutCubic,
              )),
              child: Column(
                children: [
                  const Text(
                    'Notre Histoire',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Histoire complète avec timeline
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1CBF3F).withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: const Color(0xFF1CBF3F).withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Header avec icône
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _fadeController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1CBF3F).withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Notre Histoire',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Timeline verticale
                _buildTimelineItem(
                  '2023',
                  'Naissance à Abidjan',
                  'Né en 2023 à Abidjan, Soutrali Deals est parti d\'un constat simple : des milliers d\'artisans et de travailleurs indépendants talentueux restent invisibles faute d\'outils numériques adaptés.',
                  Icons.location_on,
                  const Color(0xFF1CBF3F),
                  0,
                ),

                _buildTimelineItem(
                  'Équipe Fondatrice',
                  'Sous l\'impulsion de Sidney Jordan, Jocelyn Boka, Theby Markovitch et Yann Landry',
                  'Passionnés de technologie et d\'innovation sociale, Soutrali Deals s\'est donné pour mission de transformer cette réalité.',
                  Icons.people,
                  const Color(0xFF16A34A),
                  1,
                ),

                _buildTimelineItem(
                  'Évolution',
                  'D\'abord un projet communautaire',
                  'La plateforme a évolué en un véritable écosystème digital mêlant e-commerce, services à la personne, métiers artisanaux, prestations freelance, géolocalisation, et bientôt crypto-paiements.',
                  Icons.trending_up,
                  const Color(0xFF059669),
                  2,
                ),

                _buildTimelineItem(
                  'Aujourd\'hui',
                  'Plus de 40 membres actifs',
                  'Répartis entre développement, marketing, design, et coordination terrain, œuvrant à bâtir une solution conçue par et pour l\'Afrique.',
                  Icons.flag,
                  const Color(0xFF0D9488),
                  3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String period, String title, String description,
      IconData icon, Color color, int delay) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        final delayedAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            delay * 0.2,
            (delay * 0.2) + 0.8,
            curve: Curves.easeOutCubic,
          ),
        ));

        return Transform.translate(
          offset: Offset(0, 50 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: delayedAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ligne de timeline et icône
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withOpacity(0.8)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      if (delay < 3) // Pas de ligne pour le dernier élément
                        Container(
                          width: 3,
                          height: 80,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                color,
                                color.withOpacity(0.3),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 20),

                  // Contenu
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Période
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              period,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: color,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Titre
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Description
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                              height: 1.6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
  }

  Widget _buildEquipeSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.05),
            Colors.white,
            const Color(0xFF16A34A).withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          // Titre avec animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOutCubic,
              )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1CBF3F).withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Notre Équipe',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Une équipe jeune, ambitieuse et passionnée, guidée par la vision d\'un avenir numérique inclusif',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Membres de l'équipe
          Column(
            children: [
              // Première ligne - Fondateurs
              Row(
                children: [
                  Expanded(
                    child: _buildTeamMember(
                      'Sidney Jordan',
                      'CO-founder CEO & COO',
                      'Visionnaire, organise et coordonne tous les départements, assure la cohérence stratégique et opérationnelle.',
                      'assets/profile_picture.jpg',
                      const Color(0xFF1CBF3F),
                      0,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildTeamMember(
                      'Jocelyn Boka',
                      'CO-founder CTO Head of Development',
                      'Supervise la conception technique, le développement des applications et l\'intégration des technologies.',
                      'assets/profile_picture.jpg',
                      const Color(0xFF16A34A),
                      1,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildTeamMember(
                      'Yann Landry',
                      'CO-founder CMO Head of Communication',
                      'Pilote la stratégie de communication, le marketing digital et les relations publiques.',
                      'assets/profile_picture.jpg',
                      const Color(0xFF059669),
                      2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Deuxième ligne - Équipe
              Row(
                children: [
                  Expanded(
                    child: _buildTeamMember(
                      'Theby Markovitch',
                      'Communication & Market Researcher',
                      'Analyse les tendances du marché et les besoins utilisateurs pour guider la stratégie d\'innovation.',
                      'assets/profile_picture.jpg',
                      const Color(0xFF0D9488),
                      3,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildTeamMember(
                      'Charles Gnahoure',
                      'Design UI/UX & Community Manager',
                      'Design UI/UX designer et community manager, créateur d\'expériences utilisateur exceptionnelles.',
                      'assets/profile_picture.jpg',
                      const Color(0xFF7C3AED),
                      4,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildTeamMember(
                      'Afisu Bamidele',
                      'Développeur Mobile Flutter',
                      'Expert en développement mobile Flutter, créateur d\'applications performantes et innovantes.',
                      'assets/profile_picture.jpg',
                      const Color(0xFFDC2626),
                      5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Troisième ligne - Gestion
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildTeamMember(
                      'Gouton Fabienne',
                      'Assistante de Gestion',
                      'Chargée de coordonner tous les emplois du temps et d\'assurer la gestion administrative de l\'équipe.',
                      'assets/profile_picture.jpg',
                      const Color(0xFFEA580C),
                      6,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50),

          // Citation d'équipe
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1CBF3F).withOpacity(0.1),
                    const Color(0xFF16A34A).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF1CBF3F).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.format_quote,
                    size: 40,
                    color: Color(0xFF1CBF3F),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Ensemble, nous combinons tech, créativité et impact social pour bâtir l\'un des écosystèmes numériques les plus prometteurs de Côte d\'Ivoire.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1E293B),
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String description,
      String imagePath, Color color, int delay) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        final delayedAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            delay * 0.1,
            (delay * 0.1) + 0.8,
            curve: Curves.easeOutCubic,
          ),
        ));

        return Transform.translate(
          offset: Offset(0, 40 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: delayedAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 25,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Photo de profil avec animation
                  AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 0.9 + (0.1 * _scaleAnimation.value),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                color,
                                color.withOpacity(0.8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Nom
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Rôle avec badge coloré
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      role,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),

                  // Boutons de contact
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // LinkedIn pour tous
                      _buildSocialButton(
                        icon: Icons.work,
                        color: color,
                        onTap: () {
                          // Action LinkedIn
                        },
                      ),
                      const SizedBox(width: 8),

                      // GitHub pour les développeurs
                      if (name == 'Charles Gnahoure' ||
                          name == 'Afisu Bamidele' ||
                          name == 'Jocelyn Boka' ||
                          name == 'Sidney Jordan')
                        _buildSocialButton(
                          icon: Icons.code,
                          color: color,
                          onTap: () {
                            // Action GitHub
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildServicesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.05),
            Colors.white,
            const Color(0xFF16A34A).withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          // Titre avec animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOutCubic,
              )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1CBF3F).withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.business,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Nos Services',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Soutrali Deals est une plateforme multisectorielle qui offre plusieurs pôles de services',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Services en grille
          Column(
            children: [
              // Première ligne
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      'E-commerce & Annonces',
                      'Achat, vente et mise en avant de produits locaux, artisanaux ou professionnels avec système de référencement intelligent.',
                      Icons.shopping_cart,
                      const Color(0xFF1CBF3F),
                      0,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildServiceCard(
                      'Prestations Artisanales & Freelance',
                      'Réservation de services dans les métiers artisanaux, informels et freelance, géolocalisés selon la zone de l\'utilisateur.',
                      Icons.build,
                      const Color(0xFF16A34A),
                      1,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildServiceCard(
                      'Application Mobile & Web',
                      'Interface intuitive disponible sur mobile et web, avec tableau de bord professionnel, notifications, et gestion des prestations.',
                      Icons.phone_android,
                      const Color(0xFF059669),
                      2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Deuxième ligne
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      'Référencement & SEO',
                      'Optimisation de la visibilité en ligne des artisans et TPE sur les moteurs de recherche.',
                      Icons.search,
                      const Color(0xFF0D9488),
                      3,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildServiceCard(
                      'Services aux Entreprises',
                      'Création de sites, logos, applications mobiles, et accompagnement à la digitalisation.',
                      Icons.business_center,
                      const Color(0xFF7C3AED),
                      4,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildServiceCard(
                      'Communauté & Partenariats',
                      'Espace d\'échange, d\'entraide et de collaboration entre utilisateurs, prestataires et partenaires.',
                      Icons.people,
                      const Color(0xFFDC2626),
                      5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Troisième ligne - Services innovants
              Row(
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      'Soutra Pay & Crypto Exchange',
                      'Solution de paiement intégrée avec support des cryptomonnaies, transferts instantanés, et échange de devises numériques pour faciliter les transactions transfrontalières.',
                      Icons.account_balance_wallet,
                      const Color(0xFFEA580C),
                      6,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildServiceCard(
                      'Intelligence Artificielle',
                      'IA pour recommandations personnalisées, chatbots multilingues, analyse prédictive des tendances, et automatisation des processus métier pour optimiser l\'expérience utilisateur.',
                      Icons.psychology,
                      const Color(0xFF8B5CF6),
                      7,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      String title, String description, IconData icon, Color color, int delay) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        final delayedAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            delay * 0.1,
            (delay * 0.1) + 0.8,
            curve: Curves.easeOutCubic,
          ),
        ));

        return Transform.translate(
          offset: Offset(0, 30 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: delayedAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 25,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Icône avec animation
                  AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 0.9 + (0.1 * _scaleAnimation.value),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                color.withOpacity(0.1),
                                color.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: color.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            icon,
                            size: 40,
                            color: color,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Titre
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Bouton d'action
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Découvrir',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
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
  }

  Widget _buildSdealsIdentificationSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.05),
            Colors.white,
            const Color(0xFF16A34A).withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          // Titre avec animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOutCubic,
              )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1CBF3F).withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.fingerprint,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'SDeals Identification',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Application mobile de recensement et d\'identification pour les prestataires, freelances et vendeurs',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Fonctionnalités principales
          Row(
            children: [
              Expanded(
                child: _buildIdentificationFeature(
                  'Recensement Digital',
                  'Collecte et enregistrement des données des prestataires, freelances et vendeurs avec géolocalisation précise.',
                  Icons.person_add,
                  const Color(0xFF1CBF3F),
                  0,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildIdentificationFeature(
                  'Classification Intelligente',
                  'Système de classification automatique par métiers, catégories et services pour une organisation optimale.',
                  Icons.category,
                  const Color(0xFF16A34A),
                  1,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildIdentificationFeature(
                  'Synchronisation Cloud',
                  'Synchronisation automatique des données avec le backend pour une gestion centralisée et sécurisée.',
                  Icons.cloud_sync,
                  const Color(0xFF059669),
                  2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Types d'utilisateurs
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1CBF3F).withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: const Color(0xFF1CBF3F).withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Types d\'utilisateurs recensés',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: _buildUserTypeCard(
                        'Prestataires',
                        'Artisans, réparateurs, services à domicile',
                        Icons.build,
                        const Color(0xFF3B82F6),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildUserTypeCard(
                        'Freelances',
                        'Travailleurs indépendants, consultants',
                        Icons.work,
                        const Color(0xFFF59E0B),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildUserTypeCard(
                        'Vendeurs',
                        'Commerçants, boutiques, e-commerce',
                        Icons.store,
                        const Color(0xFF8B5CF6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Avantages
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1CBF3F).withOpacity(0.1),
                  const Color(0xFF16A34A).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF1CBF3F).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Avantages de SDeals Identification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: _buildAdvantageItem(
                        'Géolocalisation précise',
                        Icons.location_on,
                        const Color(0xFF1CBF3F),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildAdvantageItem(
                        'Stockage local sécurisé',
                        Icons.security,
                        const Color(0xFF16A34A),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildAdvantageItem(
                        'Interface intuitive',
                        Icons.phone_android,
                        const Color(0xFF059669),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildAdvantageItem(
                        'Synchronisation automatique',
                        Icons.sync,
                        const Color(0xFF0D9488),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentificationFeature(
      String title, String description, IconData icon, Color color, int delay) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        final delayedAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            delay * 0.15,
            (delay * 0.15) + 0.8,
            curve: Curves.easeOutCubic,
          ),
        ));

        return Transform.translate(
          offset: Offset(0, 40 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: delayedAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 25,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(0.1),
                          color.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: color.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      height: 1.5,
                      fontWeight: FontWeight.w400,
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

  Widget _buildUserTypeCard(
      String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantageItem(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValeursSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.03),
            Colors.white,
            const Color(0xFF16A34A).withOpacity(0.03),
          ],
        ),
      ),
      child: Column(
        children: [
          // Titre avec animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOutCubic,
              )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1CBF3F).withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Nos Valeurs',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Les principes qui guident notre mission et façonnent notre vision',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Citation inspirante
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1CBF3F).withOpacity(0.1),
                  const Color(0xFF16A34A).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF1CBF3F).withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1CBF3F).withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1CBF3F).withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.format_quote,
                        size: 40,
                        color: Color(0xFF1CBF3F),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '"Chez Soutrali Deals, nous croyons que chaque artisan mérite d\'être vu, chaque talent d\'être valorisé, et chaque rêve d\'être réalisé. Notre mission est de créer des ponts entre tradition et innovation, entre local et global, entre présent et avenir."',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF1E293B),
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 60,
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                          ),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        '— Sidney Jordan, Fondateur & CEO',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // Valeurs principales
          Row(
            children: [
              Expanded(
                child: _buildValueCard(
                  'Innovation',
                  'Nous utilisons la technologie pour moderniser l\'artisanat traditionnel et créer de nouvelles opportunités.',
                  Icons.lightbulb,
                  const Color(0xFF3B82F6),
                  0,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildValueCard(
                  'Authenticité',
                  'Nous valorisons le savoir-faire local, les traditions et l\'identité culturelle ivoirienne.',
                  Icons.favorite,
                  const Color(0xFFEF4444),
                  1,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildValueCard(
                  'Excellence',
                  'Nous nous engageons pour la qualité, la satisfaction client et l\'amélioration continue.',
                  Icons.star,
                  const Color(0xFFF59E0B),
                  2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Valeurs secondaires
          Row(
            children: [
              Expanded(
                child: _buildValueCard(
                  'Transparence',
                  'Nous privilégions la confiance, l\'honnêteté et la communication ouverte dans tous nos échanges.',
                  Icons.visibility,
                  const Color(0xFF8B5CF6),
                  3,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildValueCard(
                  'Solidarité',
                  'Nous croyons en la force du collectif et en l\'entraide pour construire un écosystème prospère.',
                  Icons.people,
                  const Color(0xFF10B981),
                  4,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildValueCard(
                  'Durabilité',
                  'Nous nous engageons pour un développement responsable et respectueux de l\'environnement.',
                  Icons.eco,
                  const Color(0xFF059669),
                  5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(
      String title, String description, IconData icon, Color color, int delay) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        final delayedAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            delay * 0.1,
            (delay * 0.1) + 0.8,
            curve: Curves.easeOutCubic,
          ),
        ));

        return Transform.translate(
          offset: Offset(0, 30 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: delayedAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 25,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(0.1),
                          color.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: color.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      height: 1.5,
                      fontWeight: FontWeight.w400,
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

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.05),
            Colors.white,
            const Color(0xFF16A34A).withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          // Titre avec animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _fadeController,
                curve: Curves.easeOutCubic,
              )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1CBF3F).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.contact_mail,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Contactez-nous',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 80,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Une question ? Notre équipe vous répond rapidement',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Contenu principal
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Formulaire de contact
              Expanded(
                flex: 2,
                child: _buildContactForm(),
              ),
              const SizedBox(width: 30),

              // Informations de contact
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildContactInfoCard(
                      'Email',
                      'contact@soutralideal.net',
                      Icons.email,
                      const Color(0xFF1CBF3F),
                    ),
                    const SizedBox(height: 15),
                    _buildContactInfoCard(
                      'Téléphone',
                      '+225 07 48 00 10 42',
                      Icons.phone,
                      const Color(0xFF16A34A),
                    ),
                    const SizedBox(height: 15),
                    _buildContactInfoCard(
                      'Adresse',
                      'Abidjan, Côte d\'Ivoire',
                      Icons.location_on,
                      const Color(0xFF059669),
                    ),
                    const SizedBox(height: 15),
                    _buildContactInfoCard(
                      'Site Web',
                      'portfolio.soutralideals.net',
                      Icons.web,
                      const Color(0xFF0D9488),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Réseaux sociaux
          _buildSocialMediaSection(),
          const SizedBox(height: 30),

          // Message inspirant
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1CBF3F).withOpacity(0.1),
                  const Color(0xFF16A34A).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF1CBF3F).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Color(0xFF1CBF3F),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Soutrali Deals — Bâtissons ensemble l\'avenir numérique de l\'Afrique artisanale.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1CBF3F).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF1CBF3F).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Envoyez-nous un message',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Prénom et Nom
          Row(
            children: [
              Expanded(
                child: _buildFormField(
                  'Prénom *',
                  'Votre prénom',
                  Icons.person,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormField(
                  'Nom *',
                  'Votre nom',
                  Icons.person,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Email
          _buildFormField(
            'Email *',
            'votre@email.com',
            Icons.email,
          ),
          const SizedBox(height: 15),

          // Téléphone et Sujet
          Row(
            children: [
              Expanded(
                child: _buildFormField(
                  'Téléphone',
                  '+225 XX XX XX XX',
                  Icons.phone,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdownField(
                  'Sujet *',
                  'Sélectionnez',
                  Icons.topic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Message
          _buildTextAreaField(
            'Message *',
            'Votre message...',
            Icons.message,
          ),
          const SizedBox(height: 20),

          // Bouton d'envoi
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1CBF3F).withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // TODO: Implémenter l'envoi du formulaire
                },
                borderRadius: BorderRadius.circular(10),
                child: const Center(
                  child: Text(
                    'Envoyer le message',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          style: const TextStyle(color: Color(0xFF1E293B)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
            prefixIcon: Icon(icon, color: const Color(0xFF1CBF3F), size: 18),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF1CBF3F),
                width: 2,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
              prefixIcon: Icon(icon, color: const Color(0xFF1CBF3F), size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF1CBF3F),
                  width: 2,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: const [
              DropdownMenuItem(
                  value: 'general',
                  child: Text('Question générale',
                      style: TextStyle(color: Color(0xFF1E293B)))),
              DropdownMenuItem(
                  value: 'partnership',
                  child: Text('Partenariat',
                      style: TextStyle(color: Color(0xFF1E293B)))),
              DropdownMenuItem(
                  value: 'support',
                  child: Text('Support technique',
                      style: TextStyle(color: Color(0xFF1E293B)))),
              DropdownMenuItem(
                value: 'other',
                child:
                    Text('Autre', style: TextStyle(color: Color(0xFF1E293B))),
              ),
            ],
            onChanged: (value) {
              // TODO: Gérer la sélection
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextAreaField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 4,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFA0AEC0)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Icon(icon, color: const Color(0xFF1CBF3F)),
            ),
            filled: true,
            fillColor: const Color(0xFF4A5568),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF1CBF3F),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: color,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      children: [
        const Text(
          'Suivez-nous',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.facebook,
              color: const Color(0xFF1877F2),
              onTap: () {
                // TODO: Ouvrir Facebook
              },
            ),
            const SizedBox(width: 15),
            _buildSocialButton(
              icon: Icons.camera_alt,
              color: const Color(0xFFE4405F),
              onTap: () {
                // TODO: Ouvrir Instagram
              },
            ),
            const SizedBox(width: 15),
            _buildSocialButton(
              icon: Icons.work,
              color: const Color(0xFF0A66C2),
              onTap: () {
                // TODO: Ouvrir LinkedIn
              },
            ),
            const SizedBox(width: 15),
            _buildSocialButton(
              icon: Icons.music_note,
              color: const Color(0xFF000000),
              onTap: () {
                // TODO: Ouvrir TikTok
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
