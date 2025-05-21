import 'package:flutter/material.dart';
import 'package:sdealsapp/mobile/view/homepagem/screens/homePageScreenM.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/rondpagem/rondpageblocm/rondPageBlocM.dart';
import 'package:sdealsapp/mobile/view/rondpagem/screens/rondPageScreenM.dart';
import 'package:sdealsapp/mobile/view/searchpagem/screens/searchPageScreenM.dart';
import 'package:sdealsapp/mobile/view/searchpagem/searchpageblocm/searchPageBlocM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/screens/shoppingPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageBlocM.dart';

import 'homepagem/homepageblocm/homePageBlocM.dart';
import 'morepagem/morepageblocm/morePageBlocM.dart';
import 'morepagem/screens/morePageScreenM.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int _currentIndex = 0;
List<Widget> _pageList = [
  BlocProvider(create: (_) => HomePageBlocM(), child: HomePageScreenM()),
  BlocProvider(create: (_) => RondPageBlocM(), child: RondPageScreenM()),
  BlocProvider(create: (_) => SearchPageBlocM(), child: SearchPageScreenM()),
  BlocProvider(
      create: (_) => ShoppingPageBlocM(), child: ShoppingPageScreenM()),
  BlocProvider(create: (_) => MorePageBlocM(), child: MorePageScreenM()),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          final inAnimation = Tween<Offset>(
            begin: const Offset(0.15, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: inAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: _pageList[_currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              final icons = [
                Icons.home_rounded,
                Icons.handshake_rounded,
                Icons.search_rounded,
                Icons.storefront_rounded,
                Icons.grid_view_rounded,
              ];
              final labels = [
                'Accueil',
                'Freelance',
                'Recherche',
                'MarketPlace',
                'More',
              ];
              final isSelected = _currentIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icons[index],
                        size: 28,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      if (isSelected)
                        Text(
                          labels[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
