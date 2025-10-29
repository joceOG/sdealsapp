import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/authCubit.dart';

// 🛡️ GUARDS DE ROUTES POUR SÉCURISER L'APPLICATION

/// Vérifie si l'utilisateur est authentifié
bool isAuthenticated(BuildContext context) {
  final authState = context.read<AuthCubit>().state;
  return authState is AuthAuthenticated;
}

/// Vérifie si l'utilisateur a un rôle spécifique
bool hasRole(BuildContext context, String role) {
  final authState = context.read<AuthCubit>().state;
  if (authState is AuthAuthenticated) {
    return authState.roles.contains(role);
  }
  return false;
}

/// Vérifie si l'utilisateur est un prestataire
bool isPrestataire(BuildContext context) {
  return hasRole(context, 'PRESTATAIRE');
}

/// Vérifie si l'utilisateur est un client
bool isClient(BuildContext context) {
  return hasRole(context, 'CLIENT');
}

/// Guard pour les routes nécessitant une authentification
class AuthGuard {
  static String? redirectIfNotAuthenticated(
      BuildContext context, GoRouterState state) {
    if (!isAuthenticated(context)) {
      // Sauvegarder la route demandée pour redirection après connexion
      final currentLocation = state.location;
      return '/connexion?redirect=$currentLocation';
    }
    return null; // Pas de redirection nécessaire
  }
}

/// Guard pour les routes prestataire
class PrestataireGuard {
  static String? redirectIfNotPrestataire(
      BuildContext context, GoRouterState state) {
    if (!isAuthenticated(context)) {
      return '/connexion?redirect=${state.location}';
    }

    if (!isPrestataire(context)) {
      // Rediriger vers le profil si l'utilisateur n'est pas prestataire
      return '/profile?message=Vous devez être prestataire pour accéder à cette page';
    }

    return null; // Pas de redirection nécessaire
  }
}

/// Guard pour les routes client
class ClientGuard {
  static String? redirectIfNotClient(
      BuildContext context, GoRouterState state) {
    if (!isAuthenticated(context)) {
      return '/connexion?redirect=${state.location}';
    }

    if (!isClient(context)) {
      // Rediriger vers le profil si l'utilisateur n'est pas client
      return '/profile?message=Vous devez être client pour accéder à cette page';
    }

    return null; // Pas de redirection nécessaire
  }
}

/// Guard pour les routes publiques (rediriger si déjà connecté)
class PublicGuard {
  static String? redirectIfAuthenticated(
      BuildContext context, GoRouterState state) {
    if (isAuthenticated(context)) {
      // Rediriger vers la page d'accueil si déjà connecté
      return '/';
    }
    return null; // Pas de redirection nécessaire
  }
}

/// Widget pour afficher un message d'erreur d'accès
class AccessDeniedScreen extends StatelessWidget {
  final String message;
  final String? redirectTo;

  const AccessDeniedScreen({
    super.key,
    required this.message,
    this.redirectTo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 24),
              Text(
                'Accès refusé',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () => context.go('/connexion'),
                    child: const Text('Se connecter'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => context.go(redirectTo ?? '/'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1CBF3F),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retour à l\'accueil'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
