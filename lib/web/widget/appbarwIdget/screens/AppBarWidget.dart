import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'NavigationItem.dart';
import 'NavigationItem2.dart';
import 'package:sdealsapp/data/services/authCubit.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationItem(title: 'Métiers'),
          NavigationItem(title: 'Freelance'),
          NavigationItem(title: 'Emarche'),
          NavigationItem2(title: 'Autres'),
          NavigationItem2(title: 'A propos'),
        ],
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: GestureDetector(
        onTap: () {
          context.go('/homepage');
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/logo1.png',
              width: 92,
              height: 76,
            ),
            const SizedBox(width: 12),
            const Text(
              'Soutrali Deals',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        // Navigation moderne - Centrée verticalement
        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: NavigationBar(),
          ),
        ),

        // Barre de recherche moderne - Centrée verticalement
        Flexible(
          child: Container(
            width: 180,
            height: 40,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher des services, produits...',
                hintStyle: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF1CBF3F),
                  size: 20,
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 14,
              ),
            ),
          ),
        ),

        // Bouton connexion/profil moderne - Centré verticalement
        Container(
          height: 80,
          margin: const EdgeInsets.only(right: 5),
          child: Center(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  // Utilisateur connecté - Afficher le profil
                  return _buildUserProfileButton(context, state);
                } else {
                  // Utilisateur non connecté - Afficher le bouton de connexion
                  return _buildLoginButton(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);

  // 🎯 BOUTON DE CONNEXION
  Widget _buildLoginButton(BuildContext context) {
    return FilledButton(
      onPressed: () {
        context.go('/connexion');
      },
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF1CBF3F),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.login,
            size: 16,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            'Se connecter',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 BOUTON PROFIL UTILISATEUR
  Widget _buildUserProfileButton(
      BuildContext context, AuthAuthenticated state) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'profile':
            // TODO: Naviguer vers le profil
            break;
          case 'dashboard':
            if (state.roles.contains('PRESTATAIRE')) {
              context.go('/prestataire/dashboard');
            }
            break;
          case 'logout':
            context.read<AuthCubit>().logout();
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1CBF3F).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF1CBF3F).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: const Color(0xFF1CBF3F),
              child: Text(
                state.utilisateur.nom.isNotEmpty
                    ? state.utilisateur.nom[0].toUpperCase()
                    : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.utilisateur.prenom} ${state.utilisateur.nom}',
                  style: const TextStyle(
                    color: Color(0xFF1CBF3F),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  state.activeRole ?? 'Client',
                  style: TextStyle(
                    color: const Color(0xFF1CBF3F).withValues(alpha: 0.7),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF1CBF3F),
              size: 16,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, size: 16),
              SizedBox(width: 8),
              Text('Mon profil'),
            ],
          ),
        ),
        if (state.roles.contains('PRESTATAIRE'))
          const PopupMenuItem(
            value: 'dashboard',
            child: Row(
              children: [
                Icon(Icons.dashboard, size: 16),
                SizedBox(width: 8),
                Text('Dashboard'),
              ],
            ),
          ),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text('Se déconnecter', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
