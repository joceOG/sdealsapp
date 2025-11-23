import 'package:equatable/equatable.dart';

// 🎯 ÉTATS DASHBOARD PRESTATAIRE
abstract class PrestataireDashboardState extends Equatable {
  const PrestataireDashboardState();

  @override
  List<Object?> get props => [];
}

// 🚀 ÉTAT INITIAL
class PrestataireDashboardInitial extends PrestataireDashboardState {
  const PrestataireDashboardInitial();
}

// ⏳ CHARGEMENT
class PrestataireDashboardLoading extends PrestataireDashboardState {
  const PrestataireDashboardLoading();
}

// 📊 ÉTAT CHARGÉ
class PrestataireDashboardLoaded extends PrestataireDashboardState {
  final Map<String, dynamic> stats;
  final List<Map<String, dynamic>> missions;
  final List<Map<String, dynamic>> planning;
  final List<Map<String, dynamic>> messages;
  final Map<String, dynamic> profil;
  final List<Map<String, dynamic>> revenus;
  final List<Map<String, dynamic>> avis;
  final List<Map<String, dynamic>> notifications;
  final Map<String, dynamic> performances;

  const PrestataireDashboardLoaded({
    required this.stats,
    required this.missions,
    required this.planning,
    required this.messages,
    required this.profil,
    required this.revenus,
    required this.avis,
    required this.notifications,
    required this.performances,
  });

  @override
  List<Object?> get props => [
        stats,
        missions,
        planning,
        messages,
        profil,
        revenus,
        avis,
        notifications,
        performances,
      ];

  PrestataireDashboardLoaded copyWith({
    Map<String, dynamic>? stats,
    List<Map<String, dynamic>>? missions,
    List<Map<String, dynamic>>? planning,
    List<Map<String, dynamic>>? messages,
    Map<String, dynamic>? profil,
    List<Map<String, dynamic>>? revenus,
    List<Map<String, dynamic>>? avis,
    List<Map<String, dynamic>>? notifications,
    Map<String, dynamic>? performances,
  }) {
    return PrestataireDashboardLoaded(
      stats: stats ?? this.stats,
      missions: missions ?? this.missions,
      planning: planning ?? this.planning,
      messages: messages ?? this.messages,
      profil: profil ?? this.profil,
      revenus: revenus ?? this.revenus,
      avis: avis ?? this.avis,
      notifications: notifications ?? this.notifications,
      performances: performances ?? this.performances,
    );
  }
}

// ❌ ÉCHEC
class PrestataireDashboardFailure extends PrestataireDashboardState {
  final String error;

  const PrestataireDashboardFailure({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

// 🔄 ACTUALISATION
class PrestataireDashboardRefreshing extends PrestataireDashboardState {
  final Map<String, dynamic> stats;
  final List<Map<String, dynamic>> missions;
  final List<Map<String, dynamic>> planning;
  final List<Map<String, dynamic>> messages;
  final Map<String, dynamic> profil;
  final List<Map<String, dynamic>> revenus;
  final List<Map<String, dynamic>> avis;
  final List<Map<String, dynamic>> notifications;
  final Map<String, dynamic> performances;

  const PrestataireDashboardRefreshing({
    required this.stats,
    required this.missions,
    required this.planning,
    required this.messages,
    required this.profil,
    required this.revenus,
    required this.avis,
    required this.notifications,
    required this.performances,
  });

  @override
  List<Object?> get props => [
        stats,
        missions,
        planning,
        messages,
        profil,
        revenus,
        avis,
        notifications,
        performances,
      ];
}







