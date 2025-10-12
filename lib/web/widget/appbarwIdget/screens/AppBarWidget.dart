import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'NavigationItem.dart';
import 'NavigationItem2.dart';

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
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: NavigationBar(),
          ),
        ),

        // Barre de recherche moderne - Centrée verticalement
        Container(
          width: 300,
          height: 40,
          margin: const EdgeInsets.only(right: 20),
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

        // Bouton connexion moderne - Centré verticalement
        Container(
          height: 80,
          margin: const EdgeInsets.only(right: 20),
          child: Center(
            child: FilledButton(
              onPressed: () {
                context.go('/connexion');
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF1CBF3F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
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
                    size: 18,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Se connecter',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
