import 'package:equatable/equatable.dart';

// 🎯 ÉTATS PARAMÈTRES
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

// 🚀 ÉTAT INITIAL
class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

// ⏳ CHARGEMENT
class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

// ✅ PARAMÈTRES CHARGÉS
class SettingsLoaded extends SettingsState {
  final bool notificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool pushNotificationsEnabled;
  final String language;
  final String theme;
  final bool dataSharingEnabled;
  final bool analyticsEnabled;
  final String? successMessage;
  final String? errorMessage;

  const SettingsLoaded({
    this.notificationsEnabled = true,
    this.emailNotificationsEnabled = true,
    this.pushNotificationsEnabled = true,
    this.language = 'fr',
    this.theme = 'system',
    this.dataSharingEnabled = false,
    this.analyticsEnabled = true,
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        notificationsEnabled,
        emailNotificationsEnabled,
        pushNotificationsEnabled,
        language,
        theme,
        dataSharingEnabled,
        analyticsEnabled,
        successMessage,
        errorMessage,
      ];

  SettingsLoaded copyWith({
    bool? notificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? pushNotificationsEnabled,
    String? language,
    String? theme,
    bool? dataSharingEnabled,
    bool? analyticsEnabled,
    String? successMessage,
    String? errorMessage,
  }) {
    return SettingsLoaded(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailNotificationsEnabled: emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      pushNotificationsEnabled: pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      dataSharingEnabled: dataSharingEnabled ?? this.dataSharingEnabled,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ❌ ERREUR
class SettingsError extends SettingsState {
  final String error;

  const SettingsError({required this.error});

  @override
  List<Object?> get props => [error];
}

// 💾 SAUVEGARDE
class SettingsSaving extends SettingsState {
  const SettingsSaving();
}

// ✅ SAUVEGARDÉ
class SettingsSaved extends SettingsState {
  final String message;

  const SettingsSaved({required this.message});

  @override
  List<Object?> get props => [message];
}
