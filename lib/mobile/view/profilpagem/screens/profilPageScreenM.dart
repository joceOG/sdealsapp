import 'package:flutter/material.dart';

import '../../auth/screens/loginPageScreenM.dart';

class ProfilePageScreenM extends StatelessWidget {
  const ProfilePageScreenM({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Action pour revenir en arrière
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.green),
            onPressed: () {
              // Action pour les notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            const SizedBox(height: 20),

            // Section "Mon Deals"
            const SectionTitle(title: 'Mon Deals'),
            MenuItem(
              icon: Icons.lightbulb,
              title: "Trouver l'inspiration",
              onTap: () {
                // Action pour cette option
              },
            ),
            MenuItem(
              icon: Icons.favorite,
              title: "Listes enregistrées",
              onTap: () {
                // Action pour cette option
              },
            ),
            MenuItem(
              icon: Icons.people,
              title: "Mes intérêts",
              onTap: () {
                // Action pour cette option
              },
            ),
            MenuItem(
              icon: Icons.person_add,
              title: "Inviter des amis",
              onTap: () {
                // Action pour cette option
              },
            ),

            // Section "Paramètres"
            const SectionTitle(title: 'Paramètres'),
            MenuItem(
              icon: Icons.settings,
              title: "Préférences",
              onTap: () {
                // Action pour cette option
              },
            ),
            MenuItem(
              icon: Icons.account_circle,
              title: "Compte",
              onTap: () {
                // Action pour cette option
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPageScreenM(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
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
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.green),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
