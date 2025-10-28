import 'package:flutter/material.dart';

// 🎯 ÉCRAN PRINCIPAL PRESTATAIRE MODERNE 2025
class PrestataireMainScreen extends StatefulWidget {
  const PrestataireMainScreen({super.key});

  @override
  State<PrestataireMainScreen> createState() => _PrestataireMainScreenState();
}

class _PrestataireMainScreenState extends State<PrestataireMainScreen> {
  int _currentIndex = 0;

  // Titres des écrans pour l'AppBar
  final List<String> _titles = [
    'Espace Prestataire',
    'Missions',
    'Planning',
    'Messages',
    'Profil'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          // Notification
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF1E293B)),
            onPressed: () {
              // TODO: Ouvrir les notifications
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // 🎯 ÉCRAN ACTUEL
  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildMissions();
      case 2:
        return _buildPlanning();
      case 3:
        return _buildMessages();
      case 4:
        return _buildProfil();
      default:
        return _buildDashboard();
    }
  }

  // 🎯 DASHBOARD PRINCIPAL
  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bienvenue
          _buildWelcomeCard(),
          const SizedBox(height: 24),

          // Statistiques
          _buildStatsGrid(),
          const SizedBox(height: 24),

          // Missions récentes
          _buildRecentMissions(),
          const SizedBox(height: 24),

          // Actions rapides
          _buildQuickActions(),
        ],
      ),
    );
  }

  // 🎯 CARTE DE BIENVENUE
  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bienvenue !',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Votre espace prestataire est prêt. Gérez vos missions et développez votre activité.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Profil validé ✓',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '5 missions actives',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🎯 GRILLE DES STATISTIQUES
  Widget _buildStatsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 800 ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: _stats.length,
          itemBuilder: (context, index) {
            final stat = _stats[index];
            return _buildStatCard(stat);
          },
        );
      },
    );
  }

  // 🎯 CARTE DE STATISTIQUE
  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stat['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  stat['icon'],
                  color: stat['color'],
                  size: 20,
                ),
              ),
              const Spacer(),
              Text(
                stat['change'],
                style: TextStyle(
                  fontSize: 12,
                  color: stat['changeColor'],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            stat['value'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['label'],
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 MISSIONS RÉCENTES
  Widget _buildRecentMissions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Missions récentes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: const Text('Voir tout'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._recentMissions.map((mission) => _buildMissionItem(mission)),
        ],
      ),
    );
  }

  // 🎯 ÉLÉMENT DE MISSION
  Widget _buildMissionItem(Map<String, dynamic> mission) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: mission['statusColor'],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mission['client'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            mission['price'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 ACTIONS RAPIDES
  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actions rapides',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2,
                ),
                itemCount: _quickActions.length,
                itemBuilder: (context, index) {
                  final action = _quickActions[index];
                  return _buildQuickActionCard(action);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // 🎯 CARTE D'ACTION RAPIDE
  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: action['onTap'],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: action['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: action['color'].withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              action['icon'],
              color: action['color'],
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              action['title'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: action['color'],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 🎯 MISSIONS
  Widget _buildMissions() {
    return const Center(
      child: Text('Écran Missions'),
    );
  }

  // 🎯 PLANNING
  Widget _buildPlanning() {
    return const Center(
      child: Text('Écran Planning'),
    );
  }

  // 🎯 MESSAGES
  Widget _buildMessages() {
    return const Center(
      child: Text('Écran Messages'),
    );
  }

  // 🎯 PROFIL
  Widget _buildProfil() {
    return const Center(
      child: Text('Écran Profil'),
    );
  }

  // 🎯 NAVIGATION INFÉRIEURE
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
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

  // 🎯 DONNÉES DES STATISTIQUES
  static final List<Map<String, dynamic>> _stats = [
    {
      'icon': Icons.work,
      'label': 'Missions actives',
      'value': '5',
      'change': '+2',
      'changeColor': Colors.green,
      'color': const Color(0xFF4CAF50),
    },
    {
      'icon': Icons.check_circle,
      'label': 'Missions terminées',
      'value': '23',
      'change': '+5',
      'changeColor': Colors.green,
      'color': const Color(0xFF2196F3),
    },
    {
      'icon': Icons.star,
      'label': 'Note moyenne',
      'value': '4.8',
      'change': '+0.2',
      'changeColor': Colors.green,
      'color': const Color(0xFFFF9800),
    },
    {
      'icon': Icons.attach_money,
      'label': 'Revenus ce mois',
      'value': '125,000 FCFA',
      'change': '+15%',
      'changeColor': Colors.green,
      'color': const Color(0xFF9C27B0),
    },
  ];

  // 🎯 MISSIONS RÉCENTES
  static final List<Map<String, dynamic>> _recentMissions = [
    {
      'title': 'Réparation électroménager',
      'client': 'Marie Kouassi',
      'price': '15,000 FCFA',
      'statusColor': Colors.orange,
    },
    {
      'title': 'Ménage ponctuel',
      'client': 'Jean Traoré',
      'price': '8,000 FCFA',
      'statusColor': Colors.blue,
    },
    {
      'title': 'Transport de personnes',
      'client': 'Fatou Diallo',
      'price': '12,000 FCFA',
      'statusColor': Colors.green,
    },
  ];

  // 🎯 ACTIONS RAPIDES
  static final List<Map<String, dynamic>> _quickActions = [
    {
      'title': 'Nouvelle mission',
      'icon': Icons.add_circle,
      'color': const Color(0xFF4CAF50),
      'onTap': () {},
    },
    {
      'title': 'Voir planning',
      'icon': Icons.calendar_today,
      'color': const Color(0xFF2196F3),
      'onTap': () {},
    },
    {
      'title': 'Messages',
      'icon': Icons.message,
      'color': const Color(0xFFFF9800),
      'onTap': () {},
    },
    {
      'title': 'Statistiques',
      'icon': Icons.analytics,
      'color': const Color(0xFF9C27B0),
      'onTap': () {},
    },
    {
      'title': 'Paramètres',
      'icon': Icons.settings,
      'color': const Color(0xFF607D8B),
      'onTap': () {},
    },
    {
      'title': 'Aide',
      'icon': Icons.help,
      'color': const Color(0xFFE91E63),
      'onTap': () {},
    },
  ];
}
