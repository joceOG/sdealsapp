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
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: _pageList[_currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0),
        child: BottomNavigationBar(
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.0,
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.autorenew,
                size: 30.0,
              ),
              label: 'Freelance',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              label: 'Recherche',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                size: 30.0,
              ),
              label: 'MarketPlace',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_horiz,
                size: 30.0,
              ),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
