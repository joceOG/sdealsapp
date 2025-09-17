import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../registerpageblocm/registerPageBlocM.dart';
import '../registerpageblocm/registerPageEventM.dart';
import '../registerpageblocm/registerPageStateM.dart';

class RegisterPageScreenM extends StatefulWidget {
  const RegisterPageScreenM({super.key});

  @override
  State<RegisterPageScreenM> createState() => _RegisterPageScreenMState();
}

class _RegisterPageScreenMState extends State<RegisterPageScreenM>
    with SingleTickerProviderStateMixin {
  bool agreeToTerms = false;
  bool obscurePassword = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop(); // GoRouter pour revenir en arrière
          },
        ),
      ),
      body: BlocConsumer<RegisterPageBlocM, RegisterPageStateM>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Inscription réussie ✅")),
            );
            // Navigation avec GoRouter vers la page d'accueil
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.push("/homepage");
            });
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
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

                // Formulaire
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (v) => context
                            .read<RegisterPageBlocM>()
                            .add(RegisterFullNameChanged(v)),
                        decoration: const InputDecoration(
                          labelText: "Nom complet",
                          hintText: "Entrez votre nom complet",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        onChanged: (v) => context
                            .read<RegisterPageBlocM>()
                            .add(RegisterPhoneChanged(v)),
                        decoration: const InputDecoration(
                          labelText: "Numéro de Téléphone",
                          hintText: "Entrez votre Numéro de Téléphone",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        obscureText: obscurePassword,
                        onChanged: (v) => context
                            .read<RegisterPageBlocM>()
                            .add(RegisterPasswordChanged(v)),
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
                      TextField(
                        obscureText: true,
                        onChanged: (v) => context
                            .read<RegisterPageBlocM>()
                            .add(RegisterConfirmPasswordChanged(v)),
                        decoration: const InputDecoration(
                          labelText: "Confirmez le mot de passe",
                          hintText: "Confirmez votre mot de passe",
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      ElevatedButton(
                        onPressed: agreeToTerms && !state.isSubmitting
                            ? () {
                          context
                              .read<RegisterPageBlocM>()
                              .add(RegisterSubmitted());
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: state.isSubmitting
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          "JE M'INSCRIS",
                          style: TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Vous avez déjà un compte ?'),
                          TextButton(
                            onPressed: () {
                              context.go("/login"); // si tu as une route login
                            },
                            child: const Text('Connectez-vous',
                                style: TextStyle(
                                  color: Colors.green,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "En vous inscrivant, vous acceptez nos conditions d'utilisation et notre politique de confidentialité.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
