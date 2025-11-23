import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../widget/Footer.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';
import '../../../widget/BreadcrumbWidget.dart';
import '../prestatairebloc/prestataireBloc.dart';
import '../prestatairebloc/prestataireEvent.dart';
import '../prestatairebloc/prestataireState.dart';
import '../../../../data/models/prestataire.dart';

class PrestataireScreen extends StatefulWidget {
  const PrestataireScreen({super.key});

  @override
  State<PrestataireScreen> createState() => _PrestataireScreenState();
}

class _PrestataireScreenState extends State<PrestataireScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _selectedService;
  bool _verifiedOnly = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Charger les prestataires au démarrage
    context.read<PrestataireBloc>().add(const LoadPrestataires());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<PrestataireBloc>().add(LoadMorePrestataires());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: Column(
        children: [
          // Fil d'ariane
          const BreadcrumbWidget(
            items: [
              BreadcrumbItem(label: 'Accueil', route: '/'),
              BreadcrumbItem(label: 'Prestataires'),
            ],
          ),
          
          // Header moderne
          _buildHeader(),

          // Barre de recherche et filtres
          _buildSearchAndFilters(),

          // Contenu principal
          Expanded(
            child: BlocBuilder<PrestataireBloc, PrestataireState>(
              builder: (context, state) {
                print("🔍 État du BLoC: isLoading=${state.isLoading}, prestataires=${state.prestataires?.length ?? 'null'}, error=${state.error}");
                
                if (state.isLoading && (state.prestataires == null || state.prestataires!.isEmpty)) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF1CBF3F)),
                    ),
                  );
                }

                if (state.error != null) {
                  return _buildErrorWidget(state.error!);
                }

                if (state.prestataires == null || state.prestataires!.isEmpty) {
                  return _buildEmptyWidget();
                }

                return _buildPrestatairesGrid(state);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.1),
            const Color(0xFF16A34A).withOpacity(0.05),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          // Icône principale
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF1CBF3F).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people,
              size: 40,
              color: Color(0xFF1CBF3F),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Prestataires Populaires',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          const Text(
            'Découvrez nos prestataires les mieux notés',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          const Text(
            'Professionnels vérifiés et qualifiés pour tous vos besoins',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Barre de recherche
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher un prestataire...',
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF1CBF3F)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFF1CBF3F), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      context
                          .read<PrestataireBloc>()
                          .add(const LoadPrestataires());
                    } else {
                      context
                          .read<PrestataireBloc>()
                          .add(SearchPrestataires(value));
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<PrestataireBloc>().add(RefreshPrestataires());
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Actualiser'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1CBF3F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Filtres
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedService,
                  decoration: InputDecoration(
                    labelText: 'Service',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: null, child: Text('Tous les services')),
                    DropdownMenuItem(
                        value: 'coiffure', child: Text('Coiffure')),
                    DropdownMenuItem(
                        value: 'plomberie', child: Text('Plomberie')),
                    DropdownMenuItem(
                        value: 'electricite', child: Text('Électricité')),
                    DropdownMenuItem(
                        value: 'nettoyage', child: Text('Nettoyage')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedService = value;
                    });
                    if (value != null) {
                      context.read<PrestataireBloc>().add(
                            FilterByService(value, value.toUpperCase()),
                          );
                    } else {
                      context.read<PrestataireBloc>().add(ClearFilters());
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SwitchListTile(
                  title: const Text('Vérifiés uniquement'),
                  value: _verifiedOnly,
                  onChanged: (value) {
                    setState(() {
                      _verifiedOnly = value;
                    });
                    context.read<PrestataireBloc>().add(
                          LoadPrestataires(verified: value),
                        );
                  },
                  activeColor: const Color(0xFF1CBF3F),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrestatairesGrid(PrestataireState state) {
    print("🏗️ Construction de la grille avec ${state.prestataires?.length ?? 0} prestataires");
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PrestataireBloc>().add(RefreshPrestataires());
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 400,
          maxHeight: double.infinity,
        ),
        child: GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.6,
          ),
          itemCount: state.prestataires!.length + (state.hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= state.prestataires!.length) {
              return _buildLoadMoreCard(state);
            }

            final prestataire = state.prestataires![index];
            return _buildPrestataireCard(prestataire);
          },
        ),
      ),
    );
  }

  Widget _buildPrestataireCard(Prestataire prestataire) {
    print("🎯 Construction de la carte pour ${prestataire.prenom} ${prestataire.nom}");
    return GestureDetector(
      onTap: () {
        context.go('/detailsprestataire');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header avec photo ronde et badge de vérification
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Photo ronde du prestataire
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF1CBF3F),
                            width: 3,
                          ),
                          image: prestataire.photo != null
                              ? DecorationImage(
                                  image: NetworkImage(prestataire.photo!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: prestataire.photo == null
                            ? Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF1F5F9),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color(0xFF64748B),
                                ),
                              )
                            : null,
                      ),
                      // Badge de vérification
                      if (prestataire.verifier)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1CBF3F),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Nom du prestataire
                  Text(
                    '${prestataire.prenom} ${prestataire.nom}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Service
                  Text(
                    prestataire.serviceName ?? 'Service non spécifié',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Localisation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          prestataire.displayLocation,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Divider
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey[200],
            ),

            // Footer avec note et actions
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Note avec étoiles
                  if (prestataire.note != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1CBF3F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            prestataire.note!.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${prestataire.nombreAvis ?? 0} avis)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Nouveau',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  // Description si disponible
                  if (prestataire.description != null &&
                      prestataire.description!.isNotEmpty)
                    Text(
                      prestataire.description!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 12),

                  // Bouton d'action
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CBF3F), Color(0xFF16A34A)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          context.go('/detailsprestataire');
                        },
                        child: const Center(
                          child: Text(
                            'Voir le profil',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreCard(PrestataireState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: state.isLoadingMore
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1CBF3F)),
              ),
            )
          : const Center(
              child: Text(
                'Charger plus',
                style: TextStyle(
                  color: Color(0xFF1CBF3F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Erreur de chargement',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: const TextStyle(
              color: Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<PrestataireBloc>().add(RefreshPrestataires());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1CBF3F),
              foregroundColor: Colors.white,
            ),
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Aucun prestataire trouvé',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Essayez de modifier vos critères de recherche',
            style: TextStyle(
              color: Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<PrestataireBloc>().add(ClearFilters());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1CBF3F),
              foregroundColor: Colors.white,
            ),
            child: const Text('Effacer les filtres'),
          ),
        ],
      ),
    );
  }
}
