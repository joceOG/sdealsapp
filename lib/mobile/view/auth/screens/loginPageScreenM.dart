import 'package:flutter/material.dart';

import 'registerPageScreenM.dart';

class LoginPageScreenM extends StatefulWidget {
  const LoginPageScreenM({super.key});

  @override
  State<LoginPageScreenM> createState() => _LoginPageScreenMState();
}

class _LoginPageScreenMState extends State<LoginPageScreenM>
    with SingleTickerProviderStateMixin {
  bool rememberMe = false; // État pour le Checkbox
  bool isPasswordVisible = false; // État pour la visibilité du mot de passe
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
              "Bienvenue sur Soutrali Deals,\nconnectez-vous pour consulter vos services",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // Formulaire de connexion
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // Identifiant
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Mon identifiant",
                      hintText: "Entrez votre identifiant",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mot de passe
                  TextField(
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      hintText: "Entrez votre mot de passe",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Se souvenir de moi
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text("Se souvenir de moi"),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Bouton de connexion
                  ElevatedButton(
                    onPressed: () {
                      // Logique de connexion ici
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "JE ME CONNECTE",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Mot de passe oublié
                  TextButton(
                    onPressed: () {
                      // Logique pour mot de passe oublié
                    },
                    child: Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(color: Colors.green.shade700),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "OU",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Logique pour créer un compte
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPageScreenM(),
                        ),
                      );
                    },
                    child: const Text("Créer un compte"),
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
