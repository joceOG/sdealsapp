import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceState.dart';

import '../../../widget/Footer.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../freelancebloc/freelanceBloc.dart';
import '../freelancebloc/freelanceEvent.dart';

class FreelanceScreen extends StatefulWidget {
  const FreelanceScreen({super.key});

  @override
  State<FreelanceScreen> createState() => _FreelanceScreenState();
}

class _FreelanceScreenState extends State<FreelanceScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les données au démarrage
    context.read<FreelanceBloc>().add(LoadCategorieDataF());
    context.read<FreelanceBloc>().add(LoadServiceDataF());
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

            // 📂 TOP CATÉGORIES FREELANCE
            _buildTopCategoriesSection(),

            // 🛠️ TOP SERVICES FREELANCE
            _buildTopServicesSection(),

            // 👥 FREELANCES POPULAIRES
            _buildPopularFreelancersSection(),

            // 🔍 COMMENT ÇA MARCHE
            _buildHowItWorksSection(),

            // ⭐ TÉMOIGNAGES CLIENTS
            _buildTestimonialsSection(),

            // 🎯 CALL-TO-ACTION DOUBLE
            _buildDoubleCallToActionSection(),

            // ❓ FAQ SECTION
            _buildFAQSection(),

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
            Colors.blue.shade50,
            Colors.purple.shade50,
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Des centaines de services freelance et autant de prestations de qualités',
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
            'Trouvez le freelance parfait pour tous vos projets',
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
          image: AssetImage('assets/accueil.jpg'),
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

  // 📂 TOP CATÉGORIES FREELANCE
  Widget _buildTopCategoriesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Catégories Freelance',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Explorez nos catégories de services freelance',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 280,
            child: BlocBuilder<FreelanceBloc, FreelanceState>(
              builder: (context, state) {
                if (state.listItems == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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

  // 🛠️ TOP SERVICES FREELANCE
  Widget _buildTopServicesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Services Freelance',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Découvrez nos services freelance les plus populaires',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 280,
            child: BlocBuilder<FreelanceBloc, FreelanceState>(
              builder: (context, state) {
                if (state.listItems2 == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.listItems2!.length,
                  itemBuilder: (context, index) {
                    return _buildServiceCard(state.listItems2![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 📱 CALL-TO-ACTION SECTION
  Widget _buildCallToActionSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Que vous recherchiez un développeur, un designer ou un consultant...',
                  style: TextStyle(
                    fontFamily: 'Krona One',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Nous vous trouvons les meilleurs freelances, gratuitement.',
                  style: TextStyle(
                    fontFamily: 'Krona One',
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Consultez les profils, discutez avec les professionnels, aussi depuis notre application mobile.',
                  style: TextStyle(
                    fontFamily: 'Kumbh Sans',
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                _buildDownloadButtons(),
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
                  'assets/image2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📱 BOUTONS DE TÉLÉCHARGEMENT
  Widget _buildDownloadButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildDownloadButton(
            icon: 'assets/apple.png',
            title: 'Télécharger sur AppStore',
            subtitle: 'AppStore',
            onTap: () {
              // Action App Store
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildDownloadButton(
            icon: 'assets/playstore.png',
            title: 'Télécharger sur PlayStore',
            subtitle: 'PlayStore',
            onTap: () {
              // Action Play Store
            },
          ),
        ),
      ],
    );
  }

  // 📱 BOUTON DE TÉLÉCHARGEMENT INDIVIDUEL
  Widget _buildDownloadButton({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                icon,
                width: 50,
                height: 50,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Arial',
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'Arial Black',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📂 CARTE DE CATÉGORIE
  Widget _buildCategoryCard(dynamic category) {
    return GestureDetector(
      onTap: () {
        context.go('/prestataire');
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
                      color: Colors.blue.shade100,
                      child: const Icon(
                        Icons.category,
                        size: 50,
                        color: Colors.blue,
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

  // 🛠️ CARTE DE SERVICE
  Widget _buildServiceCard(dynamic service) {
    return GestureDetector(
      onTap: () {
        context.go('/prestataire');
      },
      child: Container(
        width: 250,
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
            // Image du service
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(service.imageservice),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // Gestion d'erreur pour l'image
                    },
                  ),
                ),
                child: service.imageservice.isEmpty
                    ? Container(
                        color: Colors.green.shade100,
                        child: const Icon(
                          Icons.work,
                          size: 50,
                          color: Colors.green,
                        ),
                      )
                    : null,
              ),
            ),
            // Informations du service
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.nomservice,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Freelance',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
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

  // 👥 FREELANCES POPULAIRES SECTION
  Widget _buildPopularFreelancersSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade50,
            Colors.blue.shade50,
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Freelances Populaires',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Découvrez nos freelances les mieux notés et les plus expérimentés',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Grille des freelances populaires
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.8,
            ),
            itemCount: 6, // Top 6 freelances
            itemBuilder: (context, index) {
              return _buildFreelancerCard(index);
            },
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.go('/prestataire');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
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
              'Voir tous les freelances',
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

  // 🔍 COMMENT ÇA MARCHE SECTION
  Widget _buildHowItWorksSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
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
            '3 étapes simples pour trouver le freelance parfait',
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
              _buildHowItWorksStep(
                stepNumber: '1',
                icon: Icons.search,
                title: 'Recherchez un freelance',
                description: 'Parcourez nos profils et trouvez le talent idéal',
                color: Colors.blue,
              ),
              _buildStepArrow(),
              _buildHowItWorksStep(
                stepNumber: '2',
                icon: Icons.chat,
                title: 'Discutez et définissez',
                description:
                    'Échangez avec le freelance et précisez votre mission',
                color: Colors.orange,
              ),
              _buildStepArrow(),
              _buildHowItWorksStep(
                stepNumber: '3',
                icon: Icons.payment,
                title: 'Payez en toute sécurité',
                description: 'Paiement sécurisé via SoutraPay',
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ⭐ TÉMOIGNAGES SECTION
  Widget _buildTestimonialsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
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
            'Témoignages Clients',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Découvrez ce que nos clients disent de notre plateforme',
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
              _buildTestimonialCard(
                name: 'Marie Kouassi',
                role: 'Entrepreneure',
                content:
                    'Grâce à Soutrali Deals, j\'ai trouvé un graphiste en 24h pour mon projet. Excellent service !',
                rating: 5,
                avatar: 'assets/avatar1.jpg',
              ),
              _buildTestimonialCard(
                name: 'Jean Traoré',
                role: 'PDG',
                content:
                    'Plateforme très professionnelle. J\'ai pu embaucher un développeur qualifié rapidement.',
                rating: 5,
                avatar: 'assets/avatar2.jpg',
              ),
              _buildTestimonialCard(
                name: 'Fatou Diabaté',
                role: 'Directrice Marketing',
                content:
                    'Interface intuitive et freelances de qualité. Je recommande vivement !',
                rating: 5,
                avatar: 'assets/avatar3.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🎯 CALL-TO-ACTION DOUBLE SECTION
  Widget _buildDoubleCallToActionSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          // CTA pour les clients
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.search,
                    size: 60,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Besoin d\'un freelance ?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Trouvez le vôtre dès maintenant',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/prestataire');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
                      'Trouver un freelance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 30),

          // CTA pour les freelances
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person_add,
                    size: 60,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Vous êtes freelance ?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Rejoignez Soutrali Deals et trouvez vos prochains clients',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/freelance-registration');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                      'Devenir Freelance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  // ❓ FAQ SECTION
  Widget _buildFAQSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Column(
        children: [
          const Text(
            'Questions Fréquentes',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Trouvez les réponses à vos questions sur notre plateforme',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              _buildFAQItem(
                question: 'Comment payer un freelance ?',
                answer:
                    'Vous pouvez payer via SoutraPay avec votre carte bancaire ou mobile money. Tous les paiements sont sécurisés.',
              ),
              _buildFAQItem(
                question: 'Comment devenir freelance ?',
                answer:
                    'Créez votre profil, ajoutez vos compétences et commencez à recevoir des propositions de clients.',
              ),
              _buildFAQItem(
                question: 'Est-ce sécurisé ?',
                answer:
                    'Oui, tous les paiements sont protégés par SoutraPay et nous vérifions l\'identité de nos freelances.',
              ),
              _buildFAQItem(
                question: 'Comment se passent les paiements ?',
                answer:
                    'Les paiements sont automatiquement versés sur le compte du freelance après validation de la mission.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 👥 CARTE DE FREELANCE
  Widget _buildFreelancerCard(int index) {
    final freelancers = [
      {
        'name': 'Kouadio Jean',
        'skill': 'Développeur Full-Stack',
        'rate': '15,000 FCFA/h',
        'rating': 4.9,
        'projects': 127,
        'avatar': 'assets/freelancer1.jpg',
      },
      {
        'name': 'Yao Koffi',
        'skill': 'Designer UI/UX',
        'rate': '12,000 FCFA/h',
        'rating': 4.8,
        'projects': 89,
        'avatar': 'assets/freelancer2.jpg',
      },
      {
        'name': 'Koné Mariam',
        'skill': 'Rédactrice SEO',
        'rate': '8,000 FCFA/h',
        'rating': 4.9,
        'projects': 156,
        'avatar': 'assets/freelancer3.jpg',
      },
      {
        'name': 'Traoré Ali',
        'skill': 'Photographe',
        'rate': '20,000 FCFA/h',
        'rating': 4.7,
        'projects': 73,
        'avatar': 'assets/freelancer4.jpg',
      },
      {
        'name': 'Ouattara Fatou',
        'skill': 'Traductrice',
        'rate': '10,000 FCFA/h',
        'rating': 4.8,
        'projects': 201,
        'avatar': 'assets/freelancer5.jpg',
      },
      {
        'name': 'Diabaté Ibrahim',
        'skill': 'Consultant Marketing',
        'rate': '25,000 FCFA/h',
        'rating': 4.9,
        'projects': 45,
        'avatar': 'assets/freelancer6.jpg',
      },
    ];

    final freelancer = freelancers[index];

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
            // Photo du freelance
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: AssetImage(freelancer['avatar'] as String),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // Fallback si image manquante
                    },
                  ),
                ),
                child: freelancer['avatar'] == null
                    ? Container(
                        color: Colors.purple.shade100,
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.purple,
                        ),
                      )
                    : null,
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
                      freelancer['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      freelancer['skill'] as String,
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
                          '${freelancer['rating']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${freelancer['projects']} projets)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      freelancer['rate'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
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

  // 🔍 ÉTAPE "COMMENT ÇA MARCHE"
  Widget _buildHowItWorksStep({
    required String stepNumber,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
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
            child: Center(
              child: Text(
                stepNumber,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Icon(
            icon,
            size: 40,
            color: color,
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

  // ➡️ FLÈCHE ENTRE LES ÉTAPES
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

  // ⭐ CARTE DE TÉMOIGNAGE
  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String content,
    required int rating,
    required String avatar,
  }) {
    return Container(
      width: 300,
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
          // Avatar
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(avatar),
            onBackgroundImageError: (exception, stackTrace) {
              // Fallback si image manquante
            },
            child: const Icon(Icons.person, size: 30),
          ),
          const SizedBox(height: 15),
          // Étoiles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 15),
          // Témoignage
          Text(
            '"$content"',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          // Nom et rôle
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            role,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ❓ ITEM FAQ
  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
