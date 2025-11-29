import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'NavigationItem.dart';
import 'NavigationItem.dart';
import 'package:sdealsapp/data/services/authCubit.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const NavigationItem(title: 'Métiers'),
          const NavigationItem(title: 'Freelance'),
          const NavigationItem(title: 'Emarche'),
          NavigationItem(
            title: 'Autres',
            onTap: () => context.go('/autre'),
          ),
          NavigationItem(
            title: 'A propos',
            onTap: () => context.go('/apropos'),
          ),
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

        // Barre de recherche moderne - Agrandie
        Flexible(
          child: Container(
            width: 300, // Largeur augmentée pour plus de confort
            height: 44, // Hauteur légèrement augmentée
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(24), // Plus arrondi
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un service...',
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
                    borderRadius: BorderRadius.circular(20),
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

        // 🔔 BOUTON NOTIFICATIONS
        Container(
          height: 80,
          margin: const EdgeInsets.only(right: 12),
          child: Center(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return _buildNotificationButton(context);
                }
                return const SizedBox.shrink();
              },
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

  // 🔔 BOUTON NOTIFICATIONS
  Widget _buildNotificationButton(BuildContext context) {
    const int notificationCount = 3; // TODO: Remplacer par vraies données

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Système de notifications bientôt disponible'),
                backgroundColor: Colors.orange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF1E293B),
            size: 24,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(8),
          ),
        ),
        if (notificationCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                notificationCount > 9 ? '9+' : notificationCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

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

  // 🎯 BOUTON PROFIL UTILISATEUR (PREMIUM STYLE YOUTUBE)
  Widget _buildUserProfileButton(
      BuildContext context, AuthAuthenticated state) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 56), // Ouvre le menu en dessous du bouton
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      constraints: const BoxConstraints(
        minWidth: 280,
        maxWidth: 280,
      ),
      onSelected: (value) {
        switch (value) {
          case 'profile':
            context.go('/profile');
            break;
          case 'settings':
            context.go('/settings');
            break;
          case 'dashboard':
            if (state.roles.contains('PRESTATAIRE')) {
              context.go('/prestataire/dashboard');
            }
            break;
          case 'orders':
          case 'favorites':
          case 'help':
          case 'feedback':
          case 'terms':
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Bientôt disponible'),
                backgroundColor: Colors.orange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
            break;
          case 'logout':
            context.read<AuthCubit>().logout();
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1CBF3F).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF1CBF3F).withOpacity(0.3),
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
                    color: const Color(0xFF1CBF3F).withOpacity(0.7),
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
        // 📌 EN-TÊTE
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF1CBF3F),
                    child: Text(
                      state.utilisateur.nom.isNotEmpty
                          ? state.utilisateur.nom[0].toUpperCase()
                          : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.utilisateur.prenom} ${state.utilisateur.nom}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.utilisateur.email,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  context.go('/profile');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle, size: 14, color: Color(0xFF1CBF3F)),
                    SizedBox(width: 6),
                    Text(
                      'Voir le profil complet',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1CBF3F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),

        // 🔄 SÉLECTEUR DE RÔLE (si multi-rôle)
        if (state.roles.length > 1) ...[
          PopupMenuItem(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.swap_horiz, size: 18, color: Color(0xFF1E293B)),
                    SizedBox(width: 10),
                    Text(
                      'Changer de rôle',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _RoleSelector(),
              ],
            ),
          ),
          const PopupMenuDivider(),
        ],

        // 📊 MON COMPTE
        const PopupMenuItem(
          enabled: false,
          child: Padding(
            padding: EdgeInsets.only(left: 4, top: 4, bottom: 4),
            child: Text(
              'Mon Compte',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'profile',
          child: _buildMenuItem(Icons.person_outline, 'Mon profil'),
        ),
        if (state.roles.contains('PRESTATAIRE'))
          PopupMenuItem(
            value: 'dashboard',
            child: _buildMenuItem(Icons.dashboard_outlined, 'Dashboard'),
          ),
        PopupMenuItem(
          value: 'orders',
          child: _buildMenuItem(Icons.shopping_bag_outlined, 'Mes commandes'),
        ),
        PopupMenuItem(
          value: 'favorites',
          child: _buildMenuItem(Icons.favorite_outline, 'Mes favoris'),
        ),
        const PopupMenuDivider(),

        // ⚙️ PRÉFÉRENCES
        const PopupMenuItem(
          enabled: false,
          child: Padding(
            padding: EdgeInsets.only(left: 4, top: 4, bottom: 4),
            child: Text(
              'Préférences',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: _buildMenuItem(Icons.settings_outlined, 'Paramètres'),
        ),
        const PopupMenuDivider(),

        // ❓ AIDE & SUPPORT
        const PopupMenuItem(
          enabled: false,
          child: Padding(
            padding: EdgeInsets.only(left: 4, top: 4, bottom: 4),
            child: Text(
              'Aide & Support',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'help',
          child: _buildMenuItem(Icons.help_outline, 'Centre d\'aide'),
        ),
        PopupMenuItem(
          value: 'feedback',
          child: _buildMenuItem(Icons.feedback_outlined, 'Envoyer un feedback'),
        ),
        PopupMenuItem(
          value: 'terms',
          child: _buildMenuItem(Icons.description_outlined, 'Conditions d\'utilisation'),
        ),
        const PopupMenuDivider(),

        // 🚪 DÉCONNEXION
        PopupMenuItem(
          value: 'logout',
          child: _buildMenuItem(
            Icons.logout,
            'Se déconnecter',
            isDestructive: true,
          ),
        ),
      ],
    );
  }

  // 🎯 HELPER : ITEM DE MENU
  Widget _buildMenuItem(IconData icon, String label, {bool isDestructive = false}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDestructive ? Colors.red : const Color(0xFF64748B),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDestructive ? Colors.red : const Color(0xFF1E293B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// 🎯 SÉLECTEUR DE RÔLE
class _RoleSelector extends StatelessWidget {
  const _RoleSelector();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is! AuthAuthenticated) return const SizedBox.shrink();
        
        return Row(
          children: state.roles.map((role) {
            final isActive = state.activeRole == role;
            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  // Changer le rôle actif
                  context.read<AuthCubit>().switchActiveRole(role);
                  
                  // Rediriger selon le rôle sélectionné
                  if (role == 'PRESTATAIRE') {
                    // Rediriger vers le dashboard prestataire
                    Future.delayed(const Duration(milliseconds: 100), () {
                      context.go('/prestataire/dashboard');
                    });
                  } else if (role == 'CLIENT') {
                    // Rediriger vers la page d'accueil
                    Future.delayed(const Duration(milliseconds: 100), () {
                      context.go('/homepage');
                    });
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive 
                        ? const Color(0xFF1CBF3F).withOpacity(0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isActive 
                          ? const Color(0xFF1CBF3F)
                          : Colors.grey.shade300,
                      width: isActive ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    role == 'PRESTATAIRE' ? 'Prestataire' : 'Client',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      color: isActive 
                          ? const Color(0xFF1CBF3F)
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
