import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/serviceproviderregistrationpagem/screens/serviceProviderRegistrationScreenM.dart';

class ServiceProviderWelcomeScreenM extends StatelessWidget {
  final List<dynamic> categories;

  const ServiceProviderWelcomeScreenM({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bouton fixe en bas de l'écran
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).push('/serviceProviderRegistration');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
            shape: const StadiumBorder(),
            elevation: 0,
          ),
          child: const Text(
            'COMMENCER MON INSCRIPTION',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.3),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeaderSection(context),

            // Avantages section
            _buildAdvantagesSection(),

            // Métiers section
            _buildCategoriesSection(context),

            // Espace supplémentaire en bas pour éviter que le bouton fixe ne cache du contenu
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 360,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade700,
                Colors.green.shade500,
                Colors.green.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.handyman, color: Colors.white, size: 28),
                    SizedBox(width: 8),
                    Text(
                      'Devenir Prestataire',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Développez votre activité avec Soutrali Deals',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: _buildStatItem('500+', 'prestataires actifs')),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildStatItem('1000+', 'missions réalisées')),
                  ],
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.85),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantagesSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pourquoi nous rejoindre ?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Grille d'avantages
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.5,
            children: [
              _buildAdvantageCard('💰', 'Augmentez vos revenus',
                  'Tarifs attractifs et clients réguliers'),
              _buildAdvantageCard('📅', 'Gérez votre planning',
                  'Travaillez selon vos disponibilités'),
              _buildAdvantageCard('⭐', 'Construisez votre réputation',
                  'Système d\'avis et de notation'),
              _buildAdvantageCard('🎯', 'Clients qualifiés près de chez vous',
                  'Réduisez vos déplacements'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantageCard(String emoji, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6)),
        ],
        gradient: LinearGradient(
          colors: [Colors.green.withOpacity(0.06), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    // Utilisation des catégories dynamiques passées en paramètre
    final metierCategories = categories.isNotEmpty ? categories : [];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🏗️ Dans quel domaine exercez-vous ?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Découvrez les opportunités pour votre métier',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),

          // Liste des catégories professionnelles
          metierCategories.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Chargement des catégories de métiers...',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: metierCategories.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final category = metierCategories[index];
                    // Services par défaut pour chaque catégorie
                    final defaultServices = [
                      'Installation',
                      'Réparation',
                      'Dépannage',
                      'Conseil'
                    ];

                    // Accéder directement à la propriété nomcategorie comme dans l'écran freelance
                    final categoryName = category.nomcategorie;

                    return _buildCategoryItem(
                      context,
                      categoryName,
                      _getCategoryIcon(categoryName),
                      defaultServices,
                    );
                  },
                ),
        ],
      ),
    );
  }

  // Méthode pour obtenir l'icône appropriée en fonction du nom de la catégorie
  IconData _getCategoryIcon(String categoryName) {
    final Map<String, IconData> iconMap = {
      'Plombier': Icons.plumbing,
      'Électricien': Icons.electrical_services,
      'Menuisier': Icons.carpenter,
      'Peintre': Icons.format_paint,
      'Jardinier': Icons.yard,
      'Maçon': Icons.architecture,
      'Serrurier': Icons.lock,
      'Chauffagiste': Icons.local_fire_department,
      'Décorateur': Icons.brush,
      'Informaticien': Icons.computer,
      'Photographe': Icons.camera_alt,
      'Coiffeur': Icons.content_cut,
      'Mécanicien': Icons.car_repair,
    };

    return iconMap[categoryName] ?? Icons.handyman; // Icône par défaut
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String title,
    IconData icon,
    List<String> services,
  ) {
    return Card(
      elevation: 0,
      color: Colors.green.withOpacity(0.06),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.green.shade700, size: 20),
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Services proposés:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: services
                        .map((service) => Chip(
                              label: Text(service),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  color: Colors.green.withOpacity(0.2)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text('Tarifs moyens dans votre région:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildTarifItem(
                          'Prestation simple', '5.000 - 10.000 FCFA'),
                      const SizedBox(width: 10),
                      _buildTarifItem(
                          'Prestation complète', '15.000 - 30.000 FCFA'),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher un tarif avec son type
  Widget _buildTarifItem(String type, String price) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
