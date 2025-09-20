import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ✅ import de ton AuthCubit
import '../../../../data/models/utilisateur.dart';
import '../../../../data/services/authCubit.dart';
// import '../../registerpagem/screens/registerPageScreenM.dart';
import '../../../../data/services/api_client.dart';
import '../loginpageblocm/loginPageBlocM.dart';
import '../loginpageblocm/loginPageEventM.dart';
import '../loginpageblocm/loginPageStateM.dart';
// ✅ import du modèle utilisateur

class LoginPageScreenM extends StatefulWidget {
  const LoginPageScreenM({super.key});

  @override
  State<LoginPageScreenM> createState() => _LoginPageScreenMState();
}

class _LoginPageScreenMState extends State<LoginPageScreenM>
    with SingleTickerProviderStateMixin {
  bool rememberMe = false;
  bool isPasswordVisible = false;
  late AnimationController _animationController;
  final TextEditingController identifiantController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    identifiantController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginPageBlocM(),
      child: Scaffold(
        backgroundColor: Colors.green.shade700,
        appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<LoginPageBlocM, LoginPageStateM>(
          listener: (context, state) async {
            if (state is LoginPageSuccessM) {
              final utilisateur = Utilisateur.fromMap(state.utilisateur);
              // ✅ Mettre à jour auth sans rôles d'abord
              final authCubit = context.read<AuthCubit>();
              authCubit.setAuthenticated(
                token: state.token,
                utilisateur: utilisateur,
              );

              // ✅ Charger les rôles depuis le backend
              final api = ApiClient();
              try {
                final rolesResp =
                    await api.getUserRoles(utilisateur.idutilisateur);
                final roles =
                    (rolesResp['roles'] as List<dynamic>?)?.cast<String>() ??
                        ['CLIENT'];
                final details = rolesResp['details'] as Map<String, dynamic>?;
                authCubit.setRoles(roles: roles, roleDetails: details);
              } catch (_) {}

              // ✅ Redirection vers Home
              context.push('/homepage');
              print('go to homepage');
            } else if (state is LoginPageFailureM) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: SingleChildScrollView(
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
                  "Bienvenue sur Soutrali Deals,\nconnectez-vous pour consulter vos services",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 30),
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
                        controller: identifiantController,
                        decoration: const InputDecoration(
                          labelText: "Mon identifiant",
                          hintText: "Entrez votre identifiant",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
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
                      BlocBuilder<LoginPageBlocM, LoginPageStateM>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is LoginPageLoadingM
                                ? null
                                : () {
                                    final identifiant =
                                        identifiantController.text.trim();
                                    final password =
                                        passwordController.text.trim();

                                    if (identifiant.isEmpty ||
                                        password.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Mot de passe ou identifiant requis"),
                                        ),
                                      );
                                      return;
                                    }

                                    context.read<LoginPageBlocM>().add(
                                          LoginSubmittedM(
                                            identifiant: identifiant,
                                            password: password,
                                            rememberMe: rememberMe,
                                          ),
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: state is LoginPageLoadingM
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "JE ME CONNECTE",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "OU",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Vous n\'avez pas de compte?'),
                          TextButton(
                            onPressed: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.push("/register");
                              });
                            },
                            child: const Text(
                              'Créer un compte',
                              style: TextStyle(color: Colors.green),
                            ),
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
      ),
    );
  }
}
