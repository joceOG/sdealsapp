import 'package:equatable/equatable.dart';

// 🎯 ÉVÉNEMENTS DASHBOARD PRESTATAIRE
abstract class PrestataireDashboardEvent extends Equatable {
  const PrestataireDashboardEvent();

  @override
  List<Object?> get props => [];
}

// 🚀 CHARGER LE DASHBOARD
class LoadDashboard extends PrestataireDashboardEvent {
  const LoadDashboard();
}

// 📊 CHARGER LES STATISTIQUES
class LoadStats extends PrestataireDashboardEvent {
  const LoadStats();
}

// 📋 CHARGER LES MISSIONS
class LoadMissions extends PrestataireDashboardEvent {
  const LoadMissions();
}

// 📅 CHARGER LE PLANNING
class LoadPlanning extends PrestataireDashboardEvent {
  final DateTime date;

  const LoadPlanning({required this.date});

  @override
  List<Object?> get props => [date];
}

// 💬 CHARGER LES MESSAGES
class LoadMessages extends PrestataireDashboardEvent {
  const LoadMessages();
}

// 👤 CHARGER LE PROFIL
class LoadProfil extends PrestataireDashboardEvent {
  const LoadProfil();
}

// 🔄 ACTUALISER
class RefreshDashboard extends PrestataireDashboardEvent {
  const RefreshDashboard();
}

// 📈 CHARGER LES REVENUS
class LoadRevenus extends PrestataireDashboardEvent {
  final DateTime mois;

  const LoadRevenus({required this.mois});

  @override
  List<Object?> get props => [mois];
}

// ⭐ CHARGER LES AVIS
class LoadAvis extends PrestataireDashboardEvent {
  const LoadAvis();
}

// 🔔 CHARGER LES NOTIFICATIONS
class LoadNotifications extends PrestataireDashboardEvent {
  const LoadNotifications();
}

// 📊 CHARGER LES PERFORMANCES
class LoadPerformances extends PrestataireDashboardEvent {
  const LoadPerformances();
}

