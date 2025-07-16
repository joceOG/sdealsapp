import 'package:flutter/material.dart';
import 'package:sdealsapp/mobile/view/common/screens/ai_assistant_chat_screen.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/screens/provider_dashboard_screen.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/screens/provider_missions_screen.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/screens/provider_planning_screen.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/screens/provider_messages_screen.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/screens/provider_profile_screen.dart';

class ProviderMainScreen extends StatefulWidget {
  const ProviderMainScreen({Key? key}) : super(key: key);

  @override
  _ProviderMainScreenState createState() => _ProviderMainScreenState();
}

class _ProviderMainScreenState extends State<ProviderMainScreen> {
  int _currentIndex = 0;
  
  // Liste des écrans pour la navigation
  final List<Widget> _screens = [
    const ProviderDashboardScreen(),
    const ProviderMissionsScreen(),
    const ProviderPlanningScreen(),
    const ProviderMessagesScreen(),
    const ProviderProfileScreen(),
  ];
  
  // Titres des écrans pour l'AppBar
  final List<String> _titles = [
    'Espace Prestataire',
    'Missions',
    'Planning',
    'Messages',
    'Profil'
  ];
  
  // Solde SoutraPay (simulé)
  final String _balance = '125,000 FCFA';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Utilisation d'une icône à la place d'une image non disponible
            Icon(
              Icons.handyman,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _titles[_currentIndex],
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          // Notifications
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Afficher les notifications
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy),
            tooltip: 'Assistant IA',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AIAssistantChatScreen(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // TODO: Handle menu item selection
              if (value == 'solde') {
                // Afficher le solde
              } else if (value == 'parametres') {
                // Ouvrir les paramètres
              } else if (value == 'assistant') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AIAssistantChatScreen(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'solde',
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance_wallet),
                      const SizedBox(width: 8),
                      const Text('Solde: '),
                      Text(_balance),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'assistant',
                  child: Row(
                    children: [
                      Icon(Icons.smart_toy),
                      SizedBox(width: 8),
                      Text('Assistant IA'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'parametres',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('Paramètres'),
                    ],
                  ),
                ),
              ];
            },
          ),
          // Solde SoutraPay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  // Naviguer vers SoutraPay
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.account_balance_wallet, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        _balance,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Menu burger
          PopupMenuButton<String>(
            onSelected: (value) {
              // Gérer les options du menu
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Paramètres'),
                ),
                const PopupMenuItem<String>(
                  value: 'help',
                  child: Text('Aide'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Déconnexion'),
                ),
              ];
            },
          ),
        ],
      ),
      
      body: _screens[_currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Planning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
