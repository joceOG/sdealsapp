import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/services/api_client.dart';
import 'prestataire_dashboard_event.dart';
import 'prestataire_dashboard_state.dart';

// 🎯 BLOC DASHBOARD PRESTATAIRE
class PrestataireDashboardBloc
    extends Bloc<PrestataireDashboardEvent, PrestataireDashboardState> {
  final ApiClient _apiClient;

  PrestataireDashboardBloc({required ApiClient apiClient})
      : _apiClient = apiClient,
        super(const PrestataireDashboardInitial()) {
    // Gestionnaires d'événements
    on<LoadDashboard>(_onLoadDashboard);
    on<LoadStats>(_onLoadStats);
    on<LoadMissions>(_onLoadMissions);
    on<LoadPlanning>(_onLoadPlanning);
    on<LoadMessages>(_onLoadMessages);
    on<LoadProfil>(_onLoadProfil);
    on<RefreshDashboard>(_onRefreshDashboard);
    on<LoadRevenus>(_onLoadRevenus);
    on<LoadAvis>(_onLoadAvis);
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadPerformances>(_onLoadPerformances);
  }

  // 🚀 CHARGER LE DASHBOARD
  void _onLoadDashboard(
    LoadDashboard event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    emit(const PrestataireDashboardLoading());

    try {
      // Charger toutes les données en parallèle
      final futures = await Future.wait([
        _loadStats(),
        _loadMissions(),
        _loadPlanning(DateTime.now()),
        _loadMessages(),
        _loadProfil(),
        _loadRevenus(DateTime.now()),
        _loadAvis(),
        _loadNotifications(),
        _loadPerformances(),
      ]);

      emit(PrestataireDashboardLoaded(
        stats: futures[0] as Map<String, dynamic>,
        missions: futures[1] as List<Map<String, dynamic>>,
        planning: futures[2] as List<Map<String, dynamic>>,
        messages: futures[3] as List<Map<String, dynamic>>,
        profil: futures[4] as Map<String, dynamic>,
        revenus: futures[5] as List<Map<String, dynamic>>,
        avis: futures[6] as List<Map<String, dynamic>>,
        notifications: futures[7] as List<Map<String, dynamic>>,
        performances: futures[8] as Map<String, dynamic>,
      ));
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement: ${e.toString()}',
      ));
    }
  }

  // 📊 CHARGER LES STATISTIQUES
  void _onLoadStats(
    LoadStats event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final stats = await _loadStats();

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(stats: stats));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement des statistiques: ${e.toString()}',
      ));
    }
  }

  // 📋 CHARGER LES MISSIONS
  void _onLoadMissions(
    LoadMissions event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final missions = await _loadMissions();

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(missions: missions));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement des missions: ${e.toString()}',
      ));
    }
  }

  // 📅 CHARGER LE PLANNING
  void _onLoadPlanning(
    LoadPlanning event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final planning = await _loadPlanning(event.date);

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(planning: planning));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement du planning: ${e.toString()}',
      ));
    }
  }

  // 💬 CHARGER LES MESSAGES
  void _onLoadMessages(
    LoadMessages event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final messages = await _loadMessages();

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(messages: messages));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement des messages: ${e.toString()}',
      ));
    }
  }

  // 👤 CHARGER LE PROFIL
  void _onLoadProfil(
    LoadProfil event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final profil = await _loadProfil();

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(profil: profil));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement du profil: ${e.toString()}',
      ));
    }
  }

  // 🔄 ACTUALISER
  void _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    if (state is PrestataireDashboardLoaded) {
      final currentState = state as PrestataireDashboardLoaded;
      emit(PrestataireDashboardRefreshing(
        stats: currentState.stats,
        missions: currentState.missions,
        planning: currentState.planning,
        messages: currentState.messages,
        profil: currentState.profil,
        revenus: currentState.revenus,
        avis: currentState.avis,
        notifications: currentState.notifications,
        performances: currentState.performances,
      ));

      try {
        // Recharger toutes les données
        final futures = await Future.wait([
          _loadStats(),
          _loadMissions(),
          _loadPlanning(DateTime.now()),
          _loadMessages(),
          _loadProfil(),
          _loadRevenus(DateTime.now()),
          _loadAvis(),
          _loadNotifications(),
          _loadPerformances(),
        ]);

        emit(PrestataireDashboardLoaded(
          stats: futures[0] as Map<String, dynamic>,
          missions: futures[1] as List<Map<String, dynamic>>,
          planning: futures[2] as List<Map<String, dynamic>>,
          messages: futures[3] as List<Map<String, dynamic>>,
          profil: futures[4] as Map<String, dynamic>,
          revenus: futures[5] as List<Map<String, dynamic>>,
          avis: futures[6] as List<Map<String, dynamic>>,
          notifications: futures[7] as List<Map<String, dynamic>>,
          performances: futures[8] as Map<String, dynamic>,
        ));
      } catch (e) {
        emit(PrestataireDashboardFailure(
          error: 'Erreur d\'actualisation: ${e.toString()}',
        ));
      }
    }
  }

  // 📈 CHARGER LES REVENUS
  void _onLoadRevenus(
    LoadRevenus event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final revenus = await _loadRevenus(event.mois);

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(revenus: revenus));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement des revenus: ${e.toString()}',
      ));
    }
  }

  // ⭐ CHARGER LES AVIS
  void _onLoadAvis(
    LoadAvis event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final avis = await _loadAvis();

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(avis: avis));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement des avis: ${e.toString()}',
      ));
    }
  }

  // 🔔 CHARGER LES NOTIFICATIONS
  void _onLoadNotifications(
    LoadNotifications event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final notifications = await _loadNotifications();

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(notifications: notifications));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement des notifications: ${e.toString()}',
      ));
    }
  }

  // 📊 CHARGER LES PERFORMANCES
  void _onLoadPerformances(
    LoadPerformances event,
    Emitter<PrestataireDashboardState> emit,
  ) async {
    try {
      final performances = await _loadPerformances();

      if (state is PrestataireDashboardLoaded) {
        final currentState = state as PrestataireDashboardLoaded;
        emit(currentState.copyWith(performances: performances));
      }
    } catch (e) {
      emit(PrestataireDashboardFailure(
        error: 'Erreur de chargement des performances: ${e.toString()}',
      ));
    }
  }

  // 🎯 MÉTHODES PRIVÉES DE CHARGEMENT

  Future<Map<String, dynamic>> _loadStats() async {
    // TODO: Implémenter l'appel API pour les statistiques
    return {
      'missionsActives': 5,
      'missionsTerminees': 23,
      'noteMoyenne': 4.8,
      'revenusMois': 125000,
    };
  }

  Future<List<Map<String, dynamic>>> _loadMissions() async {
    // TODO: Implémenter l'appel API pour les missions
    return [
      {
        'id': '1',
        'titre': 'Réparation électroménager',
        'client': 'Marie Kouassi',
        'prix': 15000,
        'statut': 'EN_COURS',
        'date': DateTime.now(),
      },
      {
        'id': '2',
        'titre': 'Ménage ponctuel',
        'client': 'Jean Traoré',
        'prix': 8000,
        'statut': 'TERMINEE',
        'date': DateTime.now().subtract(const Duration(days: 1)),
      },
    ];
  }

  Future<List<Map<String, dynamic>>> _loadPlanning(DateTime date) async {
    // TODO: Implémenter l'appel API pour le planning
    return [
      {
        'id': '1',
        'titre': 'Réparation électroménager',
        'client': 'Marie Kouassi',
        'heure': '09:00',
        'duree': 120,
        'statut': 'CONFIRME',
      },
    ];
  }

  Future<List<Map<String, dynamic>>> _loadMessages() async {
    // TODO: Implémenter l'appel API pour les messages
    return [
      {
        'id': '1',
        'client': 'Marie Kouassi',
        'message': 'Bonjour, quand pourrez-vous venir ?',
        'date': DateTime.now(),
        'lu': false,
      },
    ];
  }

  Future<Map<String, dynamic>> _loadProfil() async {
    // TODO: Implémenter l'appel API pour le profil
    return {
      'nom': 'Kouassi',
      'prenom': 'Marie',
      'email': 'marie@example.com',
      'telephone': '+225 XX XX XX XX',
      'statut': 'VALIDE',
      'note': 4.8,
    };
  }

  Future<List<Map<String, dynamic>>> _loadRevenus(DateTime mois) async {
    // TODO: Implémenter l'appel API pour les revenus
    return [
      {
        'date': DateTime.now(),
        'montant': 15000,
        'mission': 'Réparation électroménager',
      },
    ];
  }

  Future<List<Map<String, dynamic>>> _loadAvis() async {
    // TODO: Implémenter l'appel API pour les avis
    return [
      {
        'id': '1',
        'client': 'Marie Kouassi',
        'note': 5,
        'commentaire': 'Excellent service !',
        'date': DateTime.now(),
      },
    ];
  }

  Future<List<Map<String, dynamic>>> _loadNotifications() async {
    // TODO: Implémenter l'appel API pour les notifications
    return [
      {
        'id': '1',
        'titre': 'Nouvelle mission',
        'contenu': 'Vous avez reçu une nouvelle mission',
        'date': DateTime.now(),
        'lu': false,
      },
    ];
  }

  Future<Map<String, dynamic>> _loadPerformances() async {
    // TODO: Implémenter l'appel API pour les performances
    return {
      'missionsParMois': [5, 8, 12, 15, 18, 23],
      'revenusParMois': [50000, 75000, 100000, 120000, 150000, 125000],
      'noteMoyenne': 4.8,
      'tauxCompletion': 95.5,
    };
  }
}
