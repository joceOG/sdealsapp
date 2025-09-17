import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sdealsapp/mobile/view/homepagem/screens/homePageScreenM.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/profilpagem/profilpageblocm/profilPageBlocM.dart';
import 'package:sdealsapp/mobile/view/profilpagem/screens/profilPageScreenM.dart';
import 'package:sdealsapp/mobile/view/rondpagem/rondpageblocm/rondPageBlocM.dart';
import 'package:sdealsapp/mobile/view/rondpagem/screens/rondPageScreenM.dart';
import 'package:sdealsapp/mobile/view/searchpagem/screens/searchPageScreenM.dart';
import 'package:sdealsapp/mobile/view/searchpagem/searchpageblocm/searchPageBlocM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/screens/shoppingPageScreenM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageBlocM.dart';
import 'package:sdealsapp/mobile/view/walletpagem/screens/walletPageScreenM.dart';
import 'package:sdealsapp/mobile/view/walletpagem/walletpageblocm/walletPageBlocM.dart';

import 'chatpagem/chatpageblocm/chatPageBlocM.dart';
import 'chatpagem/screens/chatPageScreenM.dart';
import 'homepagem/homepageblocm/homePageBlocM.dart';
import 'morepagem/morepageblocm/morePageBlocM.dart';
import 'morepagem/screens/morePageScreenM.dart';
import 'orderpagem/orderpageblocm/commande_bloc.dart';
import 'orderpagem/screens/orderPageScreenM.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int _currentIndex = 0;
List<Widget> _pageList = [
  BlocProvider(create: (_) => HomePageBlocM(), child: HomePageScreenM()),
  BlocProvider(create: (_) => WalletPageBlocM(), child: WalletPageScreenM()),
  BlocProvider(create: (_) => ChatPageBlocM(), child: ChatPageScreenM()),
  BlocProvider(create: (_) => CommandeBloc(), child: OrderPageScreenM()),
  BlocProvider(create: (_) => ProfilPageBlocM(), child: ProfilPageScreenM()),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pageList[_currentIndex]),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(0),
          child:  CurvedNavigationBar(
            backgroundColor: Colors.white, // background behind the nav bar
            color: Colors.green,           // actual nav bar color
            buttonBackgroundColor: Colors.green, // optional, color for the active button
            onTap: (index) => setState(() {
              _currentIndex = index;
            }),
            items: const <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.home,
                      size: 30.0,
                      color: Colors.white
                  ),
                  Text('Accueil', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.account_balance_wallet,
                      size: 30.0,
                      color: Colors.white
                  ),
                  Text('Wallet', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.chat,
                      size: 30.0,
                      color: Colors.white
                  ),
                  Text('Chat', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.shopping_bag,
                      size: 30.0,
                      color: Colors.white
                  ),
                  Text('Commandes', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      Icons.account_circle,
                      size: 30.0,
                      color: Colors.white
                  ),
                  Text('Profil', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ],
          )
      ),
    );
  }
}

/*

BottomNavigationBar(
backgroundColor: Colors.green,
selectedItemColor: Colors.white,
unselectedItemColor: Colors.black,
type: BottomNavigationBarType.fixed,
onTap: (index) => setState(() {
_currentIndex = index;
}),
currentIndex: _currentIndex,
items: const [
BottomNavigationBarItem(
icon: Icon(
Icons.home,
size: 30.0,
),
label: '',
),
BottomNavigationBarItem(
icon: Icon(
Icons.autorenew,
size: 30.0,
),
label: '',
),
BottomNavigationBarItem(
icon: Icon(
Icons.search,
size: 30.0,
),
label: '',
),
BottomNavigationBarItem(
icon: Icon(
Icons.shopping_bag,
size: 30.0,
),
label: '',
),
BottomNavigationBarItem(
icon: Icon(
Icons.more_horiz,
size: 30.0,
),
label: '',
),
],
),

*/