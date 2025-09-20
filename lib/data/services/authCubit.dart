import 'package:flutter_bloc/flutter_bloc.dart';
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
  AuthCubit() : super(AuthInitial());

  void setAuthenticated(
      {required String token,
      required Utilisateur utilisateur,
      List<String> roles = const ['CLIENT'],
      String? activeRole,
      Map<String, dynamic>? roleDetails}) {
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

  void logout() {
    emit(AuthInitial());
  }
}
