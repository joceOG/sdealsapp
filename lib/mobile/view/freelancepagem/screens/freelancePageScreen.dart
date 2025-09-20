import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/freelancepagem/freelancepageblocm/freelancePageStateM.dart';
import 'package:sdealsapp/mobile/view/freelance_registration/screens/freelance_registration_screen.dart';
import '../freelancepageblocm/freelancePageBlocM.dart';
import '../freelancepageblocm/freelancePageEventM.dart';
import '../models/freelance_model.dart';

// Widget wrapper qui fournit le BLoC à toute la page
class FreelancePageScreen extends StatelessWidget {
  final List<dynamic> categories;

  const FreelancePageScreen({Key? key, this.categories = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FreelancePageBlocM()
        // Toujours charger les catégories depuis l'API pour l'instant
        // Les catégories passées en paramètre pourront être utilisées à l'avenir
        ..add(LoadCategorieDataM())
        ..add(LoadFreelancersEvent()),
      child: _FreelancePageScreenContent(),
    );
  }
}

// Contenu réel de la page
class _FreelancePageScreenContent extends StatefulWidget {
  const _FreelancePageScreenContent({Key? key}) : super(key: key);

  @override
  State<_FreelancePageScreenContent> createState() =>
      _FreelancePageScreenContentState();
}

class _FreelancePageScreenContentState
    extends State<_FreelancePageScreenContent> {
  // Controller pour la barre de recherche
  final TextEditingController _searchController = TextEditingController();

  // Couleurs pour les catégories dynamiques
  final List<Color> _categoryColors = [
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.green,
    Colors.green,
    Colors.red,
    Colors.teal,
    Colors.amber,
    Colors.pink,
    Colors.cyan,
    Colors.brown,
    Colors.lime,
  ];

  // Icônes pour les catégories dynamiques
  final List<IconData> _categoryIcons = [
    Icons.computer,
    Icons.brush,
    Icons.edit_document,
    Icons.trending_up,
    Icons.videocam,
    Icons.translate,
    Icons.camera_alt,
    Icons.build,
    Icons.mic,
    Icons.school,
    Icons.support_agent,
    Icons.paid,
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Construction de la barre de recherche
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: '🔍 Rechercher un freelance ou une compétence...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        onChanged: (value) {
          // Envoyer l'événement de recherche au BLoC
          final bloc = context.read<FreelancePageBlocM>();
          bloc.add(SearchFreelancerEvent(value));
        },
      ),
    );
  }

  // Construction des filtres de catégories
  Widget _buildCategoryFilters() {
    // Lire la catégorie sélectionnée depuis le BLoC
    final bloc = context.watch<FreelancePageBlocM>();
    final selectedCategory = bloc.state.selectedCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Filtrer par catégorie',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            // Bouton pour réinitialiser les filtres
            if (selectedCategory != null || bloc.state.searchQuery.isNotEmpty)
              TextButton.icon(
                onPressed: () {
                  _searchController.clear();
                  bloc.add(ClearFiltersEvent());
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Réinitialiser'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
              ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: BlocBuilder<FreelancePageBlocM, FreelancePageStateM>(
            builder: (context, state) {
              // Ajouter une catégorie "Tous" au début
              final allCategories = [
                {'id': 'all', 'name': 'Tous'},
                ...state.listItems
                        ?.map((cat) =>
                            {'id': cat.idcategorie, 'name': cat.nomcategorie})
                        .toList() ??
                    []
              ];

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allCategories.length,
                itemBuilder: (context, index) {
                  final category = allCategories[index];
                  final categoryName = category['name'] as String;
                  final isSelected = selectedCategory == categoryName;

                  // Obtenir une couleur et une icône stables pour cette catégorie
                  final colorIndex = index % _categoryColors.length;
                  final iconIndex = index % _categoryIcons.length;
                  final categoryColor = _categoryColors[colorIndex];
                  final categoryIcon =
                      index == 0 ? Icons.apps : _categoryIcons[iconIndex];

                  return GestureDetector(
                    onTap: () {
                      // Envoyer l'événement au BLoC pour le filtrage
                      bloc.add(FilterByCategoryEvent(
                          isSelected ? null : categoryName));
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? categoryColor : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isSelected ? categoryColor : Colors.transparent,
                          width: 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: categoryColor.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            categoryIcon,
                            size: 16,
                            color: isSelected ? Colors.white : categoryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            categoryName,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Construction du bouton flottant "Devenir Freelance"
  Widget _buildBecomingFreelanceButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        // Navigation vers la page d'inscription freelance
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => FreelancePageBlocM()
                ..add(LoadCategorieDataM())
                ..add(LoadFreelancersEvent()),
              child: const FreelanceRegistrationScreen(),
            ),
          ),
        );
      },
      backgroundColor: Colors.green, // Vert uniforme comme Métiers
      icon: const Icon(Icons.person_add, color: Colors.white),
      label: const Text(
        '👤 Devenir Freelance',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Construction de la section des résultats filtrés
  Widget _buildFilterResultsSection(FreelancePageStateM state) {
    final filteredFreelancers = state.filteredFreelancers;

    if (state.searchQuery.isNotEmpty || state.selectedCategory != null) {
      // Afficher un message si aucun résultat
      if (filteredFreelancers.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Center(
            child: Column(
              children: [
                const Icon(Icons.search_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'Aucun freelance trouvé pour "${state.searchQuery}"${state.selectedCategory != null ? ' dans ${state.selectedCategory}' : ''}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      }

      // Afficher les résultats de recherche
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Résultats (${filteredFreelancers.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.swap_vert),
                onPressed: () {
                  // Ici on pourrait ajouter une fonction de tri
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tri non implémenté')),
                  );
                },
                tooltip: 'Trier les résultats',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFilteredFreelancersList(filteredFreelancers),
        ],
      );
    }

    // Si pas de filtre actif, ne rien afficher dans cette section
    return const SizedBox.shrink();
  }

  // Liste des freelancers filtrés avec animation
  Widget _buildFilteredFreelancersList(List<FreelanceModel> freelancers) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: ListView.builder(
        key: ValueKey<int>(freelancers.length), // Important pour l'animation
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: freelancers.length,
        itemBuilder: (context, index) {
          final freelancer = freelancers[index];
          // Animation pour chaque élément apparaissant avec un délai basé sur l'index
          return AnimatedBuilder(
            animation: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)?.animation ??
                    const AlwaysStoppedAnimation(1),
                curve: Interval((index / 10).clamp(0, 1), 1,
                    curve: Curves.easeOut),
              ),
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0,
                    (1 - (ModalRoute.of(context)?.animation?.value ?? 1)) * 50),
                child: Opacity(
                  opacity: (ModalRoute.of(context)?.animation?.value ?? 1),
                  child: child,
                ),
              );
            },
            child: _buildFreelancerCard(freelancer),
          );
        },
      ),
    );
  }

  // Carte de freelancer améliorée pour l'affichage dans les résultats
  Widget _buildFreelancerCard(FreelanceModel freelancer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Navigation vers le détail du freelancer
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Voir le profil de ${freelancer.name}...')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Stack(
                children: [
                  Hero(
                    tag: 'freelancer-${freelancer.id}',
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(freelancer.imagePath),
                    ),
                  ),
                  if (freelancer.isTopRated)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Top',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Informations
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            freelancer.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${freelancer.hourlyRate.toStringAsFixed(0)} €/h',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      freelancer.job,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    // Compétences
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: freelancer.skills.map((skill) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:
                              Text(skill, style: const TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    // Note et nombre de projets
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber[700]),
                        const SizedBox(width: 4),
                        Text(
                          freelancer.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.check_circle_outline,
                            size: 16, color: Colors.green[700]),
                        const SizedBox(width: 4),
                        Text(
                          '${freelancer.completedJobs} projets',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _buildBecomingFreelanceButton(),
      body: BlocBuilder<FreelancePageBlocM, FreelancePageStateM>(
        builder: (context, state) {
          if (state.isLoading == true) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }

          return CustomScrollView(
            slivers: [
              // AppBar slim moderne
              _buildModernSliverAppBar(),

              // Banner promo sticky
              _buildPromoStickyBanner(context),

              // Chips SoutraPay + IA
              _buildToolChipsSliver(context),

              // Contenu principal
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Barre de recherche
                      _buildSearchBar(),

                      // Filtres par catégorie
                      _buildCategoryFilters(),

                      // Résultats filtrés - nouvelle section
                      _buildFilterResultsSection(state),

                      const SizedBox(height: 24),
                      // Liste horizontale de freelances
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Freelances populaires',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Voir plus',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildSimpleFreelanceCard(
                                'Aminata',
                                'Développeuse mobile & web',
                                'assets/profile_picture.jpg',
                                isTop: true,
                                avatarSize: 48),
                            _buildSimpleFreelanceCard(
                                'Yao', 'Designer UI/UX', 'assets/esty.jpg',
                                avatarSize: 48),
                            _buildSimpleFreelanceCard('Fatou', 'Rédactrice SEO',
                                'assets/coiffuer2.jpeg',
                                avatarSize: 48),
                            _buildSimpleFreelanceCard('Marc', 'Photographe',
                                'assets/profile_picture.jpg',
                                avatarSize: 48),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Section À la une
                      const Text(
                        'À la une',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildFeaturedCard(),
                      const SizedBox(height: 30),
                      // Nouveaux freelances
                      const Text(
                        'Nouveaux freelances',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildSimpleFreelanceCard(
                                'Sali', 'Traductrice', 'assets/esty.jpg',
                                avatarSize: 40),
                            _buildSimpleFreelanceCard('Oumar', 'Développeur',
                                'assets/profile_picture.jpg',
                                avatarSize: 40),
                            _buildSimpleFreelanceCard('Léa',
                                'Community Manager', 'assets/coiffuer2.jpeg',
                                avatarSize: 40),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Catégories populaires
                      const Text(
                        'Catégories populaires',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildCategoryChip('Développement', Colors.green),
                          _buildCategoryChip('Design', Colors.green),
                          _buildCategoryChip('Rédaction', Colors.blue),
                          _buildCategoryChip('Photo', Colors.purple),
                          _buildCategoryChip('Traduction', Colors.teal),
                          _buildCategoryChip('Marketing', Colors.redAccent),
                        ],
                      ),
                      const SizedBox(height: 36),
                      // Avis clients (carousel)
                      const Text(
                        'Avis clients',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 170,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildReviewCard(
                                '"Super travail, rapide et efficace !"',
                                'Awa',
                                'assets/profile_picture.jpg'),
                            _buildReviewCard('"Très créatif, je recommande !"',
                                'Jean', 'assets/esty.jpg'),
                            _buildReviewCard(
                                '"Professionnelle et à l\'écoute."',
                                'Fatou',
                                'assets/coiffuer2.jpeg'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Statistiques animées
                      const Text(
                        'Statistiques de la communauté',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatCard('Freelances', '1 200+', Icons.people,
                              Colors.green),
                          _buildStatCard('Clients', '3 500+',
                              Icons.emoji_people, Colors.green),
                          _buildStatCard(
                              'Projets', '8 000+', Icons.work, Colors.blue),
                        ],
                      ),
                      const SizedBox(height: 36),
                      // Call-to-action secondaire
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 12),
                            elevation: 3,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.add_business,
                              color: Colors.white),
                          label: const Text(
                            'Publier une mission',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Pourquoi choisir un freelance ?
                      const Text(
                        'Pourquoi choisir un freelance ?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildWhyFreelance(),
                      const SizedBox(height: 36),
                      // Bannière promotionnelle
                      _buildPromoBanner(),
                      const SizedBox(height: 24),
                      // Bouton d'action
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            elevation: 4,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.people, color: Colors.white),
                          label: const Text(
                            'Voir tous les freelances',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSimpleFreelanceCard(String name, String job, String imagePath,
      {bool isTop = false, double avatarSize = 40}) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.green.withOpacity(0.08)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  CircleAvatar(
                    radius: avatarSize,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  if (isTop)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Top',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                job,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.13),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Aminata - Développeuse',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Spécialiste Flutter & mobile, 5 ans d\'expérience. Disponible pour vos projets !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String review, String name, String imagePath) {
    return Container(
      width: 210,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  review,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '- ' + name,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: color.withOpacity(0.2),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: 100,
      height: 90,
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyFreelance() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('✔️ Flexibilité et réactivité',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('✔️ Tarifs compétitifs',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('✔️ Accès à des talents variés',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('✔️ Collaboration directe et rapide',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.13),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.white, size: 36),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              "Rejoignez la communauté et boostez votre activité dès aujourd'hui !",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        String selectedCategory = 'Tous';
        String selectedLocation = 'Abidjan';
        double minRating = 3;
        bool availableNow = false;
        return StatefulBuilder(
          builder: (context, setModalState) => Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Text('Filtrer les freelances',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 18),
                // Métier/catégorie
                const Text('Catégorie',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  items: <String>[
                    'Tous',
                    'Développement',
                    'Design',
                    'Rédaction',
                    'Photo',
                    'Traduction',
                    'Marketing'
                  ]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setModalState(() => selectedCategory = v!),
                ),
                const SizedBox(height: 16),
                // Localisation
                const Text('Localisation',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: selectedLocation,
                  isExpanded: true,
                  items: <String>[
                    'Abidjan',
                    'Bouaké',
                    'Yamoussoukro',
                    'San Pedro',
                    'Autre'
                  ]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setModalState(() => selectedLocation = v!),
                ),
                const SizedBox(height: 16),
                // Note minimale
                const Text('Note minimale',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Slider(
                  value: minRating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: minRating.toStringAsFixed(1),
                  activeColor: Colors.green,
                  onChanged: (v) => setModalState(() => minRating = v),
                ),
                const SizedBox(height: 16),
                // Disponibilité
                Row(
                  children: [
                    Checkbox(
                      value: availableNow,
                      activeColor: Colors.green,
                      onChanged: (v) => setModalState(() => availableNow = v!),
                    ),
                    const Text('Disponible maintenant'),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Ici tu peux appliquer les filtres à ta recherche
                    },
                    child: const Text('Appliquer les filtres',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ✅ NOUVEAU : AppBar slim moderne avec Sliver
  Widget _buildModernSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 60,
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: Colors.green,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Freelance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.search, color: Colors.white, size: 20),
                      SizedBox(width: 12),
                      Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ NOUVEAU : Banner promo sticky pour freelances
  Widget _buildPromoStickyBanner(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _PromoStickyDelegate(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.withOpacity(0.1),
                Colors.green.withOpacity(0.15),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border(
              bottom:
                  BorderSide(color: Colors.green.withOpacity(0.3), width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.verified_user, color: Colors.green, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '🚀 Trouve le freelance parfait pour ton projet !',
                  style: TextStyle(
                    color: Colors.green.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    // TODO: Masquer le banner définitivement pour cet utilisateur
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.green,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ NOUVEAU : Chips horizontales SoutraPay + IA
  Widget _buildToolChipsSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Chip SoutraPay
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/wallet'),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.1),
                      Colors.green.withOpacity(0.15),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.green.withOpacity(0.4), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_balance_wallet,
                        color: Colors.green, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '💳 SoutraPay',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Chip IA Assistant
            InkWell(
              onTap: () {
                // TODO: Ouvrir assistant IA pour freelances
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.blue.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade300, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.smart_toy,
                        color: Colors.blue.shade700, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '🤖 IA Assistant',
                      style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
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
}

// ✅ NOUVEAU : Delegate pour banner sticky
class _PromoStickyDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _PromoStickyDelegate({required this.child});

  @override
  double get minExtent => 45.0;

  @override
  double get maxExtent => 45.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_PromoStickyDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
