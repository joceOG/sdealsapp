import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/itemContent/screens/itemContentScreen.dart';

import '../appbarwidgetbloc/appbarwidgetBloc.dart';
import '../appbarwidgetbloc/appbarwidgetEvent.dart';
import '../appbarwidgetbloc/appbarwidgetState.dart';

class AppbarItem extends StatelessWidget {
  final String title;
  final Widget child; // Nouveau paramètre

  const AppbarItem({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBarWidgetBloc(),
      child: MyStatefulWidget(title: title, child: child),
    );
  }
}

class MyStatefulWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const MyStatefulWidget({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBarWidgetBloc, AppBarWidgetState>(
      builder: (context, state) {
        return MouseRegion(
          onHover: (_) async {
            context
                .read<AppBarWidgetBloc>()
                .add(HoverMenuEvent(nomgroupe: title));
            if (title == "Métiers") {
              await showMenu(
                context: context,
                constraints: const BoxConstraints(
                  minWidth: 1000,
                  maxWidth: 1000,
                  minHeight: 500,
                  maxHeight: 500,
                ),
                useRootNavigator: true,
                position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                items: [
                  PopupMenuItem(
                    enabled: false,
                    child: Container(
                      width: 1000,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            // Part 1: Header avec gradient
                            Container(
                              width: 300,
                              height: 500,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1CBF3F),
                                    Color(0xFF16A34A),
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Icône décorative
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: const Icon(
                                        Icons.build,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  // Contenu
                                  Positioned(
                                    top: 40,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Image.asset(
                                            'assets/business.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Prestataires de services',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Découvrez nos artisans et prestataires qualifiés',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'Voir tous les métiers',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Part 2: Contenu des catégories
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: ItemContentScreen(title: title),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (title == "Freelance") {
              await showMenu(
                context: context,
                constraints: const BoxConstraints(
                  minWidth: 1000,
                  maxWidth: 1000,
                  minHeight: 500,
                  maxHeight: 500,
                ),
                useRootNavigator: true,
                position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                items: [
                  PopupMenuItem(
                    enabled: false,
                    child: Container(
                      width: 1000,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            // Part 1: Header avec gradient pour Freelance
                            Container(
                              width: 300,
                              height: 500,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF3B82F6),
                                    Color(0xFF1D4ED8),
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Icône décorative
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: const Icon(
                                        Icons.work,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  // Contenu
                                  Positioned(
                                    top: 40,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.work_outline,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Freelances & Consultants',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Professionnels indépendants et consultants experts',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'Voir tous les freelances',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Part 2: Contenu des catégories
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: ItemContentScreen(title: title),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (title == "Emarche") {
              await showMenu(
                context: context,
                constraints: const BoxConstraints(
                  minWidth: 1000,
                  maxWidth: 1000,
                  minHeight: 500,
                  maxHeight: 500,
                ),
                useRootNavigator: true,
                position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                items: [
                  PopupMenuItem(
                    enabled: false,
                    child: Container(
                      width: 1000,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            // Part 1: Header avec gradient pour E-marché
                            Container(
                              width: 300,
                              height: 500,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF8B5CF6),
                                    Color(0xFF7C3AED),
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Icône décorative
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: const Icon(
                                        Icons.store,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  // Contenu
                                  Positioned(
                                    top: 40,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.shopping_bag,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'E-marché & Boutiques',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Produits et services en ligne',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'Voir tous les produits',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Part 2: Contenu des catégories
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: ItemContentScreen(title: title),
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
          },
          child: GestureDetector(
            onTap: () {
              if (title == "Métiers") {
                context.go('/homepage');
              } else if (title == "Freelance") {
                print("Go to freelance");
                context.go('/freelance');
              } else if (title == 'Emarche') {
                print("Go to emarche");
                context.go('/emarche');
              }
            },
            child: child, // Utilisation du widget enfant passé en paramètre
          ),
        );
      },
    );
  }
}
