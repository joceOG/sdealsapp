import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/utilisateur.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final Utilisateur utilisateur;
  final List<String> roles; // CLIENT, PRESTATAIRE, VENDEUR, FREELANCE, ADMIN
  final String? activeRole; // rôle actif pour l'UI
  final Map<String, dynamic>? roleDetails; // détails (verifier/accountStatus)
  AuthAuthenticated(
      {required this.token,
      required this.utilisateur,
      this.roles = const ['CLIENT'],
      this.activeRole,
      this.roleDetails});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    _checkSavedAuth();
  }

  Future<void> _checkSavedAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userDataStr = prefs.getString('user_data');
      final rolesStr = prefs.getString('user_roles');

      if (token != null && userDataStr != null) {
        final userData = jsonDecode(userDataStr);
        final roles = rolesStr != null
            ? List<String>.from(jsonDecode(rolesStr))
            : ['CLIENT'];

        final utilisateur = Utilisateur.fromJson(userData);

        emit(AuthAuthenticated(
          token: token,
          utilisateur: utilisateur,
          roles: roles,
          activeRole: roles.isNotEmpty ? roles.first : 'CLIENT',
        ));
        print('✅ Session restaurée depuis SharedPreferences');
      }
    } catch (e) {
      print('❌ Erreur restauration session: $e');
      emit(AuthInitial());
    }
  }

  Future<void> setAuthenticated(
      {required String token,
      required Utilisateur utilisateur,
      List<String> roles = const ['CLIENT'],
      String? activeRole,
      Map<String, dynamic>? roleDetails}) async {
    
    // Persister les données
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user_data', jsonEncode(utilisateur.toJson()));
      await prefs.setString('user_roles', jsonEncode(roles));
      print('✅ Token sauvegardé dans SharedPreferences');
    } catch (e) {
      print('❌ Erreur sauvegarde token: $e');
    }

    emit(AuthAuthenticated(
      token: token,
      utilisateur: utilisateur,
      roles: roles,
      activeRole: activeRole ?? (roles.isNotEmpty ? roles.first : 'CLIENT'),
      roleDetails: roleDetails,
    ));
  }

  void setRoles(
      {required List<String> roles,
      String? activeRole,
      Map<String, dynamic>? roleDetails}) {
    final current = state;
    if (current is AuthAuthenticated) {
      // Mettre à jour la persistance si nécessaire (optionnel pour l'instant)
      emit(AuthAuthenticated(
        token: current.token,
        utilisateur: current.utilisateur,
        roles: roles.isNotEmpty ? roles : current.roles,
        activeRole: activeRole ?? current.activeRole,
        roleDetails: roleDetails ?? current.roleDetails,
      ));
    }
  }

  void switchActiveRole(String role) {
    final current = state;
    if (current is AuthAuthenticated && current.roles.contains(role)) {
      emit(AuthAuthenticated(
        token: current.token,
        utilisateur: current.utilisateur,
        roles: current.roles,
        activeRole: role,
        roleDetails: current.roleDetails,
      ));
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_data');
      await prefs.remove('user_roles');
      print('✅ Session nettoyée');
    } catch (e) {
      print('❌ Erreur nettoyage session: $e');
    }
    emit(AuthInitial());
  }
}
