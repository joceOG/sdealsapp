import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'NavigationItem.dart';
import 'NavigationItem2.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
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
      toolbarHeight: 250,
      title: Container(
          height: 250,
          padding: EdgeInsets.all(25),
          child: GestureDetector(
            onTap: () {
              context.go('/homepage');
            },
            child: Row(children: <Widget>[
              Image.asset(
                'assets/logo1.png', width: 92, // Largeur de l'image en pixels
                height: 76,
              ),
              const Text('Soutrali Deals',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ]),
          )
      ),
      actions: <Widget>[
        NavigationBar(),
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: FilledButton(
            onPressed: () {
              context.go('/connexion');
              // Action à effectuer lors du clic sur le bouton
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green, // Couleur de fond verte
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 15), // Marges internes
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Bords arrondis
              ),
            ),
            child: const Text(
              'Se connecter',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold), // Couleur du texte
            ),
          ),
        ),
      ],
    );
  }
  // TODO: implement preferredSize
  @override
  Size get preferredSize => const Size.fromHeight(100);
}