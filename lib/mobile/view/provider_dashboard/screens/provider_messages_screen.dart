import 'package:flutter/material.dart';

class ProviderMessagesScreen extends StatefulWidget {
  const ProviderMessagesScreen({Key? key}) : super(key: key);

  @override
  _ProviderMessagesScreenState createState() => _ProviderMessagesScreenState();
}

class _ProviderMessagesScreenState extends State<ProviderMessagesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Données simulées pour les conversations
  final List<Map<String, dynamic>> _clientConversations = [
    {
      'name': 'Marie Konan',
      'avatar': 'MK',
      'lastMessage': 'Bonjour, êtes-vous disponible pour venir demain?',
      'time': '10:30',
      'unread': 2,
      'isClient': true,
      'serviceRequest': 'Réparation robinet',
    },
    {
      'name': 'Paul Mensah',
      'avatar': 'PM',
      'lastMessage': 'Merci pour votre intervention, tout fonctionne parfaitement!',
      'time': 'Hier',
      'unread': 0,
      'isClient': true,
      'serviceRequest': 'Installation climatisation',
    },
    {
      'name': 'Ahmed Toure',
      'avatar': 'AT',
      'lastMessage': 'Je vous attends demain comme convenu.',
      'time': 'Lun',
      'unread': 0,
      'isClient': true,
      'serviceRequest': 'Débouchage canalisation',
    },
    {
      'name': 'Sophie Diallo',
      'avatar': 'SD',
      'lastMessage': 'Pourriez-vous me faire un devis pour ce travail?',
      'time': '28/06',
      'unread': 1,
      'isClient': true,
      'serviceRequest': 'Remplacement interrupteur',
    },
  ];
  
  final List<Map<String, dynamic>> _supportConversations = [
    {
      'name': 'Support Soutrali',
      'avatar': 'SS',
      'lastMessage': 'Voici les informations concernant la nouvelle mise à jour.',
      'time': 'Ven',
      'unread': 0,
      'isClient': false,
    },
    {
      'name': 'Admin Paiements',
      'avatar': 'AP',
      'lastMessage': 'Votre demande de retrait a été traitée avec succès.',
      'time': '24/06',
      'unread': 0,
      'isClient': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une conversation...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          
          // TabBar pour filtrer les conversations
          TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const [
              Tab(text: 'Clients'),
              Tab(text: 'Support'),
            ],
          ),
          
          // Liste des conversations
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Conversations clients
                _buildConversationsList(_clientConversations),
                
                // Conversations support
                _buildConversationsList(_supportConversations),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewMessageDialog();
        },
        child: const Icon(Icons.message),
      ),
    );
  }

  Widget _buildConversationsList(List<Map<String, dynamic>> conversations) {
    if (conversations.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: conversation['unread'] > 0
                ? Theme.of(context).primaryColor
                : Colors.grey,
            child: Text(
              conversation['avatar'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            conversation['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: conversation['isClient'] == true
              ? Row(
                  children: [
                    Icon(
                      Icons.handyman,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        conversation['serviceRequest'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : null,
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                conversation['time'],
                style: TextStyle(
                  fontSize: 12,
                  color: conversation['unread'] > 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              if (conversation['unread'] > 0)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${conversation['unread']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          onTap: () {
            _navigateToChatScreen(conversation);
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune conversation',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos messages apparaîtront ici',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Nouvelle conversation'),
            onPressed: () {
              _showNewMessageDialog();
            },
          ),
        ],
      ),
    );
  }

  void _navigateToChatScreen(Map<String, dynamic> conversation) {
    // Navigation vers l'écran de chat
    // Normalement, on utiliserait Navigator.push ici pour ouvrir un nouvel écran
    
    // Pour ce mock-up, on affiche simplement une boîte de dialogue
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chat avec ${conversation['name']}'),
        content: const Text('Ici s\'affichera l\'interface de chat complète'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showNewMessageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nouvelle conversation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un contact',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Contacts récents'),
            const SizedBox(height: 8),
            ListTile(
              leading: const CircleAvatar(
                child: Text('JK'),
              ),
              title: const Text('Jean Konan'),
              subtitle: const Text('Client'),
              onTap: () {
                Navigator.pop(context);
                // Naviguer vers le chat avec ce contact
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text('SS'),
              ),
              title: const Text('Support Soutrali'),
              subtitle: const Text('Support technique'),
              onTap: () {
                Navigator.pop(context);
                // Naviguer vers le chat avec le support
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }
}
