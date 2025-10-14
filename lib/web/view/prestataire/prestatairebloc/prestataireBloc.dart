import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/models/prestataire.dart';
import 'prestataireEvent.dart';
import 'prestataireState.dart';

class PrestataireBloc extends Bloc<PrestataireEvent, PrestataireState> {
  final ApiClient _apiClient = ApiClient();

  PrestataireBloc() : super(PrestataireState.initial()) {
    on<LoadPrestataires>(_onLoadPrestataires);
    on<SearchPrestataires>(_onSearchPrestataires);
    on<FilterByService>(_onFilterByService);
    on<LoadMorePrestataires>(_onLoadMorePrestataires);
    on<ClearFilters>(_onClearFilters);
    on<RefreshPrestataires>(_onRefreshPrestataires);
  }

  Future<void> _onLoadPrestataires(
    LoadPrestataires event,
    Emitter<PrestataireState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      print("🔄 Chargement des prestataires...");

      // Vérifier la connectivité de l'API
      final isApiConnected = await _apiClient.checkApiConnectivity();
      if (!isApiConnected) {
        print(
            "⚠️ API non accessible, utilisation des données de démonstration");
        // Utiliser des données de démonstration
        final demoPrestataires = _getDemoPrestataires();
        print("📊 Données de démonstration créées: ${demoPrestataires.length} prestataires");
        emit(state.copyWith(
          isLoading: false,
          prestataires: demoPrestataires,
          currentPage: 1,
          hasMoreData: false,
        ));
        print("✅ État émis avec ${demoPrestataires.length} prestataires");
        return;
      }

      final prestatairesData = await _apiClient.fetchPrestatairesByService(
        serviceId: event.serviceId,
        serviceName: event.serviceName,
        verified: event.verified,
        limit: event.limit,
      );

      final prestataires =
          prestatairesData.map((data) => Prestataire.fromJson(data)).toList();

      print("✅ Prestataires chargés: ${prestataires.length}");

      emit(state.copyWith(
        isLoading: false,
        prestataires: prestataires,
        currentPage: 1,
        hasMoreData: prestataires.length >= (event.limit ?? 20),
      ));
    } catch (error) {
      print("❌ Erreur chargement prestataires: $error");
      emit(state.copyWith(
        isLoading: false,
        error: error.toString(),
      ));
    }
  }

  Future<void> _onSearchPrestataires(
    SearchPrestataires event,
    Emitter<PrestataireState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const LoadPrestataires());
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      searchQuery: event.query,
      error: null,
    ));

    try {
      print("🔍 Recherche prestataires: ${event.query}");

      final prestatairesData = await _apiClient.fetchPrestatairesByService(
        serviceName: event.query,
        limit: 50,
      );

      final prestataires =
          prestatairesData.map((data) => Prestataire.fromJson(data)).toList();

      print("✅ Recherche terminée: ${prestataires.length} résultats");

      emit(state.copyWith(
        isLoading: false,
        prestataires: prestataires,
        currentPage: 1,
        hasMoreData: false, // Pas de pagination pour la recherche
      ));
    } catch (error) {
      print("❌ Erreur recherche: $error");
      emit(state.copyWith(
        isLoading: false,
        error: error.toString(),
      ));
    }
  }

  Future<void> _onFilterByService(
    FilterByService event,
    Emitter<PrestataireState> emit,
  ) async {
    emit(state.copyWith(
      selectedServiceId: event.serviceId,
      selectedServiceName: event.serviceName,
    ));

    add(LoadPrestataires(
      serviceId: event.serviceId,
      serviceName: event.serviceName,
    ));
  }

  Future<void> _onLoadMorePrestataires(
    LoadMorePrestataires event,
    Emitter<PrestataireState> emit,
  ) async {
    if (!state.hasMoreData || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final limit = 20;

      final prestatairesData = await _apiClient.fetchPrestatairesByService(
        serviceId: state.selectedServiceId,
        serviceName: state.selectedServiceName,
        verified: state.verifiedOnly,
        limit: limit,
      );

      final newPrestataires =
          prestatairesData.map((data) => Prestataire.fromJson(data)).toList();

      final List<Prestataire> allPrestataires = [
        ...(state.prestataires ?? []),
        ...newPrestataires,
      ];

      emit(state.copyWith(
        isLoadingMore: false,
        prestataires: allPrestataires,
        currentPage: nextPage,
        hasMoreData: newPrestataires.length >= limit,
      ));
    } catch (error) {
      print("❌ Erreur chargement plus: $error");
      emit(state.copyWith(
        isLoadingMore: false,
        error: error.toString(),
      ));
    }
  }

  Future<void> _onClearFilters(
    ClearFilters event,
    Emitter<PrestataireState> emit,
  ) async {
    emit(state.copyWith(
      searchQuery: null,
      selectedServiceId: null,
      selectedServiceName: null,
      verifiedOnly: null,
    ));

    add(const LoadPrestataires());
  }

  Future<void> _onRefreshPrestataires(
    RefreshPrestataires event,
    Emitter<PrestataireState> emit,
  ) async {
    add(LoadPrestataires(
      serviceId: state.selectedServiceId,
      serviceName: state.selectedServiceName,
      verified: state.verifiedOnly,
    ));
  }

  // 🎯 MÉTHODE POUR LES DONNÉES DE DÉMONSTRATION
  List<Prestataire> _getDemoPrestataires() {
    return [
      Prestataire(
        id: 'demo1',
        nom: 'Kouadio',
        prenom: 'Jean',
        telephone: '+225 07 48 00 10 42',
        email: 'jean.kouadio@example.com',
        photo: 'assets/coiffeur.jpeg',
        adresse: 'Cocody, Abidjan',
        ville: 'Abidjan',
        quartier: 'Cocody',
        serviceId: 'coiffure',
        serviceName: 'Coiffeur',
        verifier: true,
        note: 4.8,
        nombreAvis: 24,
        description: 'Coiffeur professionnel avec 5 ans d\'expérience',
        competences: ['Coupe homme', 'Coupe femme', 'Coloration'],
        actif: true,
        localisation: 'Abidjan, Cocody',
      ),
      Prestataire(
        id: 'demo2',
        nom: 'Yao',
        prenom: 'Koffi',
        telephone: '+225 07 48 00 10 43',
        email: 'koffi.yao@example.com',
        photo: 'assets/coiffuer2.jpeg',
        adresse: 'Yopougon, Abidjan',
        ville: 'Abidjan',
        quartier: 'Yopougon',
        serviceId: 'electricite',
        serviceName: 'Électricien',
        verifier: true,
        note: 4.9,
        nombreAvis: 18,
        description:
            'Électricien certifié, spécialisé en installations domestiques',
        competences: [
          'Installation électrique',
          'Dépannage',
          'Mise aux normes'
        ],
        actif: true,
        localisation: 'Abidjan, Yopougon',
      ),
      Prestataire(
        id: 'demo3',
        nom: 'Koné',
        prenom: 'Mariam',
        telephone: '+225 07 48 00 10 44',
        email: 'mariam.kone@example.com',
        photo: 'assets/coiffeur.jpeg',
        adresse: 'Marcory, Abidjan',
        ville: 'Abidjan',
        quartier: 'Marcory',
        serviceId: 'coiffure',
        serviceName: 'Coiffeuse',
        verifier: false,
        note: 4.7,
        nombreAvis: 12,
        description: 'Coiffeuse créative, spécialisée en coiffures africaines',
        competences: ['Tresses', 'Coiffures traditionnelles', 'Maquillage'],
        actif: true,
        localisation: 'Abidjan, Marcory',
      ),
      Prestataire(
        id: 'demo4',
        nom: 'Traoré',
        prenom: 'Ali',
        telephone: '+225 07 48 00 10 45',
        email: 'ali.traore@example.com',
        photo: 'assets/coiffeur.jpeg',
        adresse: 'Plateau, Abidjan',
        ville: 'Abidjan',
        quartier: 'Plateau',
        serviceId: 'plomberie',
        serviceName: 'Plombier',
        verifier: true,
        note: 4.9,
        nombreAvis: 31,
        description: 'Plombier expérimenté, réparation et installation',
        competences: ['Réparation', 'Installation', 'Débouchage'],
        actif: true,
        localisation: 'Abidjan, Plateau',
      ),
      Prestataire(
        id: 'demo5',
        nom: 'Ouattara',
        prenom: 'Fatou',
        telephone: '+225 07 48 00 10 46',
        email: 'fatou.ouattara@example.com',
        photo: 'assets/coiffeur.jpeg',
        adresse: 'Riviera, Abidjan',
        ville: 'Abidjan',
        quartier: 'Riviera',
        serviceId: 'nettoyage',
        serviceName: 'Agent de nettoyage',
        verifier: true,
        note: 4.8,
        nombreAvis: 15,
        description: 'Service de nettoyage professionnel à domicile',
        competences: ['Nettoyage domicile', 'Nettoyage bureau', 'Repassage'],
        actif: true,
        localisation: 'Abidjan, Riviera',
      ),
      Prestataire(
        id: 'demo6',
        nom: 'Diabaté',
        prenom: 'Ibrahim',
        telephone: '+225 07 48 00 10 47',
        email: 'ibrahim.diabate@example.com',
        photo: 'assets/coiffeur.jpeg',
        adresse: 'Angré, Abidjan',
        ville: 'Abidjan',
        quartier: 'Angré',
        serviceId: 'jardinage',
        serviceName: 'Jardinier',
        verifier: false,
        note: 4.6,
        nombreAvis: 8,
        description: 'Entretien de jardins et espaces verts',
        competences: ['Tonte', 'Taille', 'Plantation'],
        actif: true,
        localisation: 'Abidjan, Angré',
      ),
    ];
  }
}
