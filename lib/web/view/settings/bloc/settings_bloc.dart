import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_event.dart';
import 'settings_state.dart';

// 🎯 BLOC PARAMÈTRES
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String _notificationsKey = 'notifications_enabled';
  static const String _emailNotificationsKey = 'email_notifications_enabled';
  static const String _pushNotificationsKey = 'push_notifications_enabled';
  static const String _languageKey = 'language';
  static const String _themeKey = 'theme';
  static const String _dataSharingKey = 'data_sharing_enabled';
  static const String _analyticsKey = 'analytics_enabled';

  SettingsBloc() : super(const SettingsInitial()) {
    // Gestionnaires d'événements
    on<LoadSettings>(_onLoadSettings);
    on<ToggleNotifications>(_onToggleNotifications);
    on<ToggleEmailNotifications>(_onToggleEmailNotifications);
    on<TogglePushNotifications>(_onTogglePushNotifications);
    on<ChangeLanguage>(_onChangeLanguage);
    on<ChangeTheme>(_onChangeTheme);
    on<ToggleDataSharing>(_onToggleDataSharing);
    on<ToggleAnalytics>(_onToggleAnalytics);
    on<SaveSettings>(_onSaveSettings);
    on<ResetSettings>(_onResetSettings);
    on<ClearSettingsError>(_onClearSettingsError);
  }

  // 🚀 CHARGER LES PARAMÈTRES
  void _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      
      final settings = SettingsLoaded(
        notificationsEnabled: prefs.getBool(_notificationsKey) ?? true,
        emailNotificationsEnabled: prefs.getBool(_emailNotificationsKey) ?? true,
        pushNotificationsEnabled: prefs.getBool(_pushNotificationsKey) ?? true,
        language: prefs.getString(_languageKey) ?? 'fr',
        theme: prefs.getString(_themeKey) ?? 'system',
        dataSharingEnabled: prefs.getBool(_dataSharingKey) ?? false,
        analyticsEnabled: prefs.getBool(_analyticsKey) ?? true,
      );

      emit(settings);
    } catch (e) {
      emit(SettingsError(error: 'Erreur de chargement: ${e.toString()}'));
    }
  }

  // 🔔 NOTIFICATIONS
  void _onToggleNotifications(
    ToggleNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newState = currentState.copyWith(
        notificationsEnabled: event.enabled,
        successMessage: 'Notifications ${event.enabled ? 'activées' : 'désactivées'}',
      );
      emit(newState);
      await _saveToPrefs('notifications', event.enabled);
    }
  }

  void _onToggleEmailNotifications(
    ToggleEmailNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newState = currentState.copyWith(
        emailNotificationsEnabled: event.enabled,
        successMessage: 'Notifications email ${event.enabled ? 'activées' : 'désactivées'}',
      );
      emit(newState);
      await _saveToPrefs('email_notifications', event.enabled);
    }
  }

  void _onTogglePushNotifications(
    TogglePushNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newState = currentState.copyWith(
        pushNotificationsEnabled: event.enabled,
        successMessage: 'Notifications push ${event.enabled ? 'activées' : 'désactivées'}',
      );
      emit(newState);
      await _saveToPrefs('push_notifications', event.enabled);
    }
  }

  // 🌍 LANGUE
  void _onChangeLanguage(
    ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newState = currentState.copyWith(
        language: event.language,
        successMessage: 'Langue changée vers ${_getLanguageName(event.language)}',
      );
      emit(newState);
      await _saveToPrefs('language', event.language);
    }
  }

  // 🎨 THÈME
  void _onChangeTheme(
    ChangeTheme event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newState = currentState.copyWith(
        theme: event.theme,
        successMessage: 'Thème changé vers ${_getThemeName(event.theme)}',
      );
      emit(newState);
      await _saveToPrefs('theme', event.theme);
    }
  }

  // 🔒 PRIVACY
  void _onToggleDataSharing(
    ToggleDataSharing event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newState = currentState.copyWith(
        dataSharingEnabled: event.enabled,
        successMessage: 'Partage de données ${event.enabled ? 'activé' : 'désactivé'}',
      );
      emit(newState);
      await _saveToPrefs('data_sharing', event.enabled);
    }
  }

  void _onToggleAnalytics(
    ToggleAnalytics event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newState = currentState.copyWith(
        analyticsEnabled: event.enabled,
        successMessage: 'Analytics ${event.enabled ? 'activées' : 'désactivées'}',
      );
      emit(newState);
      await _saveToPrefs('analytics', event.enabled);
    }
  }

  // 💾 SAUVEGARDER
  void _onSaveSettings(
    SaveSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsSaving());

    try {
      // Ici on pourrait envoyer les paramètres au serveur
      await Future.delayed(const Duration(seconds: 1)); // Simulation

      emit(const SettingsSaved(message: 'Paramètres sauvegardés avec succès'));
    } catch (e) {
      emit(SettingsError(error: 'Erreur de sauvegarde: ${e.toString()}'));
    }
  }

  // 🔄 RÉINITIALISER
  void _onResetSettings(
    ResetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(const SettingsLoaded(
        notificationsEnabled: true,
        emailNotificationsEnabled: true,
        pushNotificationsEnabled: true,
        language: 'fr',
        theme: 'system',
        dataSharingEnabled: false,
        analyticsEnabled: true,
        successMessage: 'Paramètres réinitialisés',
      ));
    } catch (e) {
      emit(SettingsError(error: 'Erreur de réinitialisation: ${e.toString()}'));
    }
  }

  // ❌ EFFACER L'ERREUR
  void _onClearSettingsError(
    ClearSettingsError event,
    Emitter<SettingsState> emit,
  ) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(
        successMessage: null,
        errorMessage: null,
      ));
    }
  }

  // 🎯 MÉTHODES UTILITAIRES
  Future<void> _saveToPrefs(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      default:
        return 'Français';
    }
  }

  String _getThemeName(String theme) {
    switch (theme) {
      case 'light':
        return 'Clair';
      case 'dark':
        return 'Sombre';
      case 'system':
        return 'Système';
      default:
        return 'Système';
    }
  }
}
