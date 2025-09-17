import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../data/models/commande_model.dart';
import '../orderpageblocm/commande_bloc.dart';
import '../orderpageblocm/commande_event.dart';
import '../orderpageblocm/commande_state.dart';
import '../widgets/commande_card.dart';
import 'commande_details_screen.dart';

class OrderPageScreenM extends StatefulWidget {
  const OrderPageScreenM({super.key});

  @override
  State<OrderPageScreenM> createState() => _OrderPageScreenMState();
}

class _OrderPageScreenMState extends State<OrderPageScreenM> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabChange);

    // Charger les commandes au démarrage
    context.read<CommandeBloc>().add(const ChargerCommandes());
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      CommandeStatus? selectedStatus;
      
      switch (_tabController.index) {
        case 0: // Toutes
          selectedStatus = null;
          break;
        case 1: // En attente
          selectedStatus = CommandeStatus.enAttente;
          break;
        case 2: // En cours
          selectedStatus = CommandeStatus.enCours;
          break;
        case 3: // Terminées
          selectedStatus = CommandeStatus.terminee;
          break;
        case 4: // Annulées
          selectedStatus = CommandeStatus.annulee;
          break;
      }
      
      context.read<CommandeBloc>().add(FiltrerParStatus(selectedStatus));
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommandeBloc, CommandeState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: _buildAppBar(state),
          body: _buildBody(state),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
                if (!_isSearchVisible) {
                  _searchController.clear();
                  context.read<CommandeBloc>().add(const RechercherCommandes(''));
                }
              });
            },
            backgroundColor: Colors.green,
            child: Icon(
              _isSearchVisible ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  PreferredSize _buildAppBar(CommandeState state) {
    return PreferredSize(
      preferredSize: Size.fromHeight(_isSearchVisible ? 230 : 170),
      child: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(44),
            bottomRight: Radius.circular(44),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(44),
              bottomRight: Radius.circular(44),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                // Titre
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 700),
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: child,
                  ),
                  child: const Center(
                    child: Text(
                      'COMMANDES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Champ de recherche si visible
                if (_isSearchVisible) 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher une commande...',
                          prefixIcon: const Icon(Icons.search, color: Colors.green),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) {
                          context.read<CommandeBloc>().add(RechercherCommandes(value));
                        },
                      ),
                    ),
                  ),
                  
                const SizedBox(height: 10),
                
                // TabBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.white,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      tabAlignment: TabAlignment.center,
                      labelStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 11,
                      ),
                      tabs: [
                        _buildTab('Toutes', state.commandes.length),
                        _buildTab(
                          'En attente',
                          state.getNombreCommandesParStatus(CommandeStatus.enAttente),
                        ),
                        _buildTab(
                          'En cours',
                          state.getNombreCommandesParStatus(CommandeStatus.enCours),
                        ),
                        _buildTab(
                          'Terminées',
                          state.getNombreCommandesParStatus(CommandeStatus.terminee),
                        ),
                        _buildTab(
                          'Annulées',
                          state.getNombreCommandesParStatus(CommandeStatus.annulee),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (count > 0) ...[  
            const SizedBox(width: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _tabController.index == _getTabIndexFromLabel(label)
                    ? Colors.green
                    : Colors.white,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 9,
                  color: _tabController.index == _getTabIndexFromLabel(label)
                      ? Colors.white
                      : Colors.green,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  int _getTabIndexFromLabel(String label) {
    switch (label) {
      case 'Toutes': return 0;
      case 'En attente': return 1;
      case 'En cours': return 2;
      case 'Terminées': return 3;
      case 'Annulées': return 4;
      default: return 0;
    }
  }

  Widget _buildBody(CommandeState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
      );
    }
    
    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red.shade300),
            const SizedBox(height: 16),
            const Text(
              'Une erreur s\'est produite',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                state.error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CommandeBloc>().add(const ChargerCommandes());
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Réessayer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    
    if (state.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Aucune commande trouvée',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _getEmptyStateMessage(state.filtreStatus),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }
    
    return TabBarView(
      controller: _tabController,
      children: [
        // Toutes les commandes
        _buildCommandesList(state.commandesFiltrees),
        // En attente
        _buildCommandesList(state.commandesFiltrees),
        // En cours
        _buildCommandesList(state.commandesFiltrees),
        // Terminées
        _buildCommandesList(state.commandesFiltrees),
        // Annulées
        _buildCommandesList(state.commandesFiltrees),
      ],
    );
  }

  Widget _buildCommandesList(List<CommandeModel> commandes) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 80),
      itemCount: commandes.length,
      itemBuilder: (context, index) {
        final commande = commandes[index];
        return CommandeCard(
          commande: commande,
          onViewDetails: () => _navigateToDetails(commande),
          onChat: () => _openChat(commande),
          onRate: commande.peutEtreNotee ? () => _rateCommande(commande) : null,
        );
      },
    );
  }

  String _getEmptyStateMessage(CommandeStatus? status) {
    if (status == null) {
      return 'Vous n\'avez pas encore passé de commande';
    }
    
    switch (status) {
      case CommandeStatus.enAttente:
        return 'Aucune commande en attente actuellement';
      case CommandeStatus.enCours:
        return 'Aucune commande en cours actuellement';
      case CommandeStatus.terminee:
        return 'Vous n\'avez pas encore de commande terminée';
      case CommandeStatus.annulee:
        return 'Aucune commande annulée';
      default:
        return 'Aucune commande trouvée';
    }
  }

  void _navigateToDetails(CommandeModel commande) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommandeDetailsScreen(commande: commande),
      ),
    );
  }

  void _openChat(CommandeModel commande) {
    // Cette fonction serait implémentée pour ouvrir le chat
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chat avec ${commande.prestataireName} ouvert'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rateCommande(CommandeModel commande) {
    showDialog(
      context: context,
      builder: (context) => _buildRatingDialog(commande),
    );
  }

  Widget _buildRatingDialog(CommandeModel commande) {
    double rating = 0;
    final commentController = TextEditingController();
    
    return AlertDialog(
      title: const Text('Noter cette commande'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Comment évaluez-vous votre expérience avec ${commande.prestataireName}?'),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (context, setState) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Commentaire (optionnel)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (rating > 0) {
              context.read<CommandeBloc>().add(NoterCommande(
                commandeId: commande.id,
                note: rating,
                commentaire: commentController.text,
              ));
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Merci pour votre évaluation!'),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Veuillez attribuer au moins 1 étoile'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Envoyer'),
        ),
      ],
    );
  }
}
