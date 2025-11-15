import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/screens/loginPageScreenM.dart';
import '../profilpageblocm/profilPageBlocM.dart';

class ProfilPageScreenM extends StatefulWidget {
  const ProfilPageScreenM({super.key});
  @override
  State<ProfilPageScreenM> createState() => _ProfilPageScreenStateM();
}

class _ProfilPageScreenStateM extends State<ProfilPageScreenM> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Simuler des données utilisateur
  final String userName = "Afisu Yussuf";
  final String userStatus = "Compte vérifié"; // Ou "Client simple", "Premium"
  
  @override
  void initState() {
    BlocProvider.of<ProfilPageBlocM>(context);
    super.initState();
  }
<<<<<<< Updated upstream
  
  // Affiche la feuille des tarifs SoutraPay
  void _showSoutraPayTarificationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Tarification SoutraPay",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tous les tarifs et frais applicables aux services SoutraPay",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildTarificationCard(
                    "Création de compte",
                    "Gratuit",
                    "Créez votre compte SoutraPay sans frais",
                    Icons.person_add,
                    Colors.green,
                  ),
                  _buildTarificationCard(
                    "Rechargement de compte",
                    "0 FCFA",
                    "Aucun frais pour recharger votre compte",
                    Icons.account_balance_wallet,
                    Colors.blue,
                  ),
                  _buildTarificationCard(
                    "Transfert entre utilisateurs",
                    "0 FCFA",
                    "Envoyez de l'argent sans frais entre comptes SoutraPay",
                    Icons.swap_horiz,
                    Colors.orange,
                  ),
                  _buildTarificationCard(
                    "Paiement aux marchands",
                    "0 FCFA",
                    "Réglez vos achats sans frais",
                    Icons.shopping_cart,
                    Colors.purple,
                  ),
                  _buildTarificationCard(
                    "Retrait vers compte bancaire",
                    "1,5%",
                    "Des frais minimes pour les retraits vers votre banque",
                    Icons.account_balance,
                    Colors.indigo,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Note: Les tarifs sont sujets à modification. Consultez régulièrement cette page pour les mises à jour.",
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  // Carte pour afficher un élément de tarification
  Widget _buildTarificationCard(String title, String price, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: price.contains("Gratuit") || price.contains("0 FCFA") 
                  ? Colors.green.withOpacity(0.1) 
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: price.contains("Gratuit") || price.contains("0 FCFA") 
                    ? Colors.green 
                    : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
=======

>>>>>>> Stashed changes
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
<<<<<<< Updated upstream
        title: const Text("Mon Profil"),
        centerTitle: true,
=======
        title: const Text(
          'Mon Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.green.withOpacity(0.13),
              backgroundImage: const AssetImage('assets/profile_picture.jpg'),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  padding: const EdgeInsets.all(2),
                  child:
                      const Icon(Icons.verified, size: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
>>>>>>> Stashed changes
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
<<<<<<< Updated upstream
            // En-tête du profil
            _buildProfileHeader(),
=======
            const SizedBox(height: 20),
            // Avatar et nom d'utilisateur
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile_picture.jpg'), // Remplacez par votre image
            ),
            const SizedBox(height: 10),
            const Text(
              'Afisu yussuf',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
>>>>>>> Stashed changes
            const SizedBox(height: 20),
            
            // Section "Mon activité"
            const SectionTitle(title: '🧭 Mon activité'),
            MenuItem(
              icon: Icons.inventory_2,
              title: "Mes commandes",
              subtitle: "Voir les commandes passées et en cours",
              onTap: () {
                // Navigation vers les commandes
              },
            ),
            MenuItem(
              icon: Icons.rate_review,
              title: "Mes avis & évaluations",
              subtitle: "Historique des commentaires laissés",
              onTap: () {
                // Navigation vers les avis
              },
            ),
            MenuItem(
              icon: Icons.favorite,
              title: "Favoris / Listes enregistrées",
              subtitle: "Articles, prestataires ou annonces sauvegardés",
              onTap: () {
                // Navigation vers les favoris
              },
            ),
            MenuItem(
              icon: Icons.history,
              title: "Historique des consultations",
              subtitle: "Services et produits récemment visités",
              onTap: () {
                // Navigation vers l'historique
              },
            ),
            MenuItem(
              icon: Icons.notifications,
              title: "Mes alertes",
              subtitle: "Notifs personnalisées : offres, rappels",
              onTap: () {
                // Navigation vers les alertes
              },
            ),
            
            // Section "Mon SoutraPay"
            const SectionTitle(title: '💳 Mon SoutraPay'),
            MenuItem(
              icon: Icons.account_balance_wallet,
              title: "Portefeuille SoutraPay",
              subtitle: "Gérer mon portefeuille électronique",
              onTap: () {
                Navigator.pushNamed(context, '/wallet');
              },
            ),
            MenuItem(
              icon: Icons.monetization_on,
              title: "Tarification SoutraPay",
              subtitle: "Consultez les frais et tarifs",
              onTap: () {
                _showSoutraPayTarificationSheet(context);
              },
              badge: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Gratuit",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            // Section "Mes interactions"
            const SectionTitle(title: '💼 Mes interactions'),
            MenuItem(
              icon: Icons.receipt_long,
              title: "Factures & paiements",
              subtitle: "Accès aux reçus, abonnements, paiements",
              onTap: () {
                // Navigation vers les factures
              },
            ),
            MenuItem(
              icon: Icons.card_giftcard,
              title: "Parrainage & récompenses",
              subtitle: "Invitez des amis, gagnez des bonus",
              onTap: () {
                // Navigation vers le parrainage
              },
            ),
            MenuItem(
              icon: Icons.local_offer,
              title: "Offres personnalisées",
              subtitle: "Voir les bons plans proposés selon vos intérêts",
              onTap: () {
                // Navigation vers les offres
              },
            ),

            // Section "Paramètres"
            const SectionTitle(title: '⚙️ Paramètres'),
            MenuItem(
              icon: Icons.language,
              title: "Langue & Devise",
              subtitle: "Personnalisation par langue (fr, en, nouchi)",
              onTap: () {
                // Navigation vers les paramètres de langue
              },
            ),
            MenuItem(
              icon: Icons.location_on,
              title: "Localisation",
              subtitle: "Gérer votre adresse, géolocalisation",
              onTap: () {
                // Navigation vers les paramètres de localisation
              },
            ),
            MenuItem(
              icon: Icons.security,
              title: "Sécurité du compte",
              subtitle: "Mot de passe, double authentification",
              onTap: () {
                // Navigation vers les paramètres de sécurité
              },
            ),
            MenuItem(
              icon: Icons.settings,
              title: "Préférences utilisateurs",
              subtitle: "Notifications, catégories favorites",
              onTap: () {
                // Navigation vers les préférences
              },
            ),
            MenuItem(
              icon: Icons.logout,
              title: "Se déconnecter",
              subtitle: "",
              isLogout: true,
              onTap: () {
                _showLogoutDialog();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  // En-tête du profil avec photo, nom et statut
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Photo de profil
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
          ),
          const SizedBox(height: 10),
          // Nom d'utilisateur
          Text(
            userName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          // Statut utilisateur avec icône
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getStatusIcon(),
              const SizedBox(width: 5),
              Text(
                userStatus,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Retourne l'icône correspondant au statut de l'utilisateur
  Widget _getStatusIcon() {
    switch (userStatus) {
      case "Compte vérifié":
        return const Icon(Icons.verified, color: Colors.white);
      case "Premium":
        return const Icon(Icons.lock, color: Colors.white);
      default:
        return const Icon(Icons.person, color: Colors.white);
    }
  }
  
  // Dialogue de confirmation pour la déconnexion
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Se déconnecter"),
          content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPageScreenM(),
                  ),
                );
              },
              child: const Text("Se déconnecter", style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}

// Widget pour les titres de section
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

// Widget pour les éléments de menu
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLogout;
  final VoidCallback onTap;
  final Widget? badge; // Ajout du paramètre badge pour les indicateurs visuels

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle = "",
    this.isLogout = false,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isLogout ? Colors.red.shade50 : Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(icon, color: isLogout ? Colors.red : Colors.green),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16, 
                color: isLogout ? Colors.red : Colors.black,
                fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: subtitle.isNotEmpty 
                ? Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13, 
                      color: isLogout ? Colors.red.shade300 : Colors.black54,
                    ),
                  ) 
                : null,
            trailing: badge != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      badge!,
                      const SizedBox(width: 8),
                      isLogout 
                          ? const Icon(Icons.logout, color: Colors.red)
                          : const Icon(Icons.arrow_forward_ios, color: Colors.green),
                    ],
                  )
                : isLogout 
                    ? const Icon(Icons.logout, color: Colors.red)
                    : const Icon(Icons.arrow_forward_ios, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
