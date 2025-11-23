import 'package:equatable/equatable.dart';

// 🎯 ÉVÉNEMENTS PARAMÈTRES
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

// 🚀 CHARGER LES PARAMÈTRES
class LoadSettings extends SettingsEvent {
  const LoadSettings();
}

// 🔔 NOTIFICATIONS
class ToggleNotifications extends SettingsEvent {
  final bool enabled;

  const ToggleNotifications({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

class ToggleEmailNotifications extends SettingsEvent {
  final bool enabled;

  const ToggleEmailNotifications({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

class TogglePushNotifications extends SettingsEvent {
  final bool enabled;

  const TogglePushNotifications({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

// 🌍 LANGUE
class ChangeLanguage extends SettingsEvent {
  final String language;

  const ChangeLanguage({required this.language});

  @override
  List<Object?> get props => [language];
}

// 🎨 THÈME
class ChangeTheme extends SettingsEvent {
  final String theme; // 'light', 'dark', 'system'

  const ChangeTheme({required this.theme});

  @override
  List<Object?> get props => [theme];
}

// 🔒 PRIVACY
class ToggleDataSharing extends SettingsEvent {
  final bool enabled;

  const ToggleDataSharing({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

class ToggleAnalytics extends SettingsEvent {
  final bool enabled;

  const ToggleAnalytics({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

// 💾 SAUVEGARDER
class SaveSettings extends SettingsEvent {
  const SaveSettings();
}

// 🔄 RÉINITIALISER
class ResetSettings extends SettingsEvent {
  const ResetSettings();
}

// ❌ EFFACER L'ERREUR
class ClearSettingsError extends SettingsEvent {
  const ClearSettingsError();
}

