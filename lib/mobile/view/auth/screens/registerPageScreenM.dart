import 'package:flutter/material.dart';

import 'loginPageScreenM.dart';

class RegisterPageScreenM extends StatefulWidget {
  const RegisterPageScreenM({super.key});

  @override
  State<RegisterPageScreenM> createState() => _RegisterPageScreenMState();
}

class _RegisterPageScreenMState extends State<RegisterPageScreenM>
    with SingleTickerProviderStateMixin {
  bool agreeToTerms = false; // État pour le Checkbox
  bool obscurePassword = true; // État pour la visibilité du mot de passe
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Animation en boucle
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Logo avec animation
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.2)
                        .animate(_animationController),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/logo1.png',
                  height: 100,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Bienvenue sur Soutrali Deals,\ncréez un compte pour commencer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // Formulaire d'inscription
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // Nom complet
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Nom complet",
                      hintText: "Entrez votre nom complet",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Entrez votre email",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mot de passe
                  TextField(
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      hintText: "Entrez votre mot de passe",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirmation du mot de passe
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirmez le mot de passe",
                      hintText: "Confirmez votre mot de passe",
                      border: UnderlineInputBorder(),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Accepter les termes et conditions
                  Row(
                    children: [
                      Checkbox(
                        value: agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            agreeToTerms = value ?? false;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "J'accepte les termes et conditions",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Bouton d'inscription
                  ElevatedButton(
                    onPressed: agreeToTerms
                        ? () {
                            // Logique d'inscription ici
                          }
                        : null, // Désactivé si les termes ne sont pas acceptés
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "JE M'INSCRIS",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Déjà un compte ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Vous avez déjà un compte ?'),
                      TextButton(
                        onPressed: () {
                          // Logique pour aller à la page de connexion
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPageScreenM(),
                            ),
                          );
                        },
                        child: const Text('Connectez-vous',
                            style: TextStyle(
                              color: Colors.green,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
