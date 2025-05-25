import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/rondpagem/rondpageblocm/rondPageStateM.dart';
import '../rondpageblocm/rondPageBlocM.dart';
import '../rondpageblocm/rondPageEventM.dart';



class RondPageScreenMVO extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => RondPageBlocM()..add(LoadCategorieDataM()),
        child: BlocBuilder<RondPageBlocM, RondPageStateM>(
          builder: (context, state) {
            return
            state.listItems == null ?
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Barre de recherche

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
                          _buildFreelanceCard('Aminata', 'Développeuse mobile & web',
                              'assets/profile_picture.jpg',
                              isTop: true, avatarSize: 48),
                          _buildFreelanceCard(
                              'Yao', 'Designer UI/UX', 'assets/esty.jpg',
                              avatarSize: 48),
                          _buildFreelanceCard(
                              'Fatou', 'Rédactrice SEO', 'assets/coiffuer2.jpeg',
                              avatarSize: 48),
                          _buildFreelanceCard(
                              'Marc', 'Photographe', 'assets/profile_picture.jpg',
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
                          _buildFreelanceCard(
                              'Sali', 'Traductrice', 'assets/esty.jpg',
                              avatarSize: 40),
                          _buildFreelanceCard(
                              'Oumar', 'Développeur', 'assets/profile_picture.jpg',
                              avatarSize: 40),
                          _buildFreelanceCard(
                              'Léa', 'Community Manager', 'assets/coiffuer2.jpeg',
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
                        _buildCategoryChip('Design', Colors.orange),
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
                          _buildReviewCard('"Super travail, rapide et efficace !"',
                              'Awa', 'assets/profile_picture.jpg'),
                          _buildReviewCard('"Très créatif, je recommande !"', 'Jean',
                              'assets/esty.jpg'),
                          _buildReviewCard('"Professionnelle et à l\'écoute."',
                              'Fatou', 'assets/coiffuer2.jpeg'),
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
                        _buildStatCard(
                            'Freelances', '1 200+', Icons.people, Colors.green),
                        _buildStatCard(
                            'Clients', '3 500+', Icons.emoji_people, Colors.orange),
                        _buildStatCard('Projets', '8 000+', Icons.work, Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 36),
                    // Call-to-action secondaire
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 12),
                          elevation: 3,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.add_business, color: Colors.white),
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
            ) :
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
              ),
            );
           },
        ),
      ),
    );
  }

  Widget _buildFreelanceCard(String name, String job, String imagePath,
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
                          color: Colors.orange,
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
}
