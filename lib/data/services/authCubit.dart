import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/utilisateur.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final String token;
  final Utilisateur utilisateur;
  AuthAuthenticated({required this.token, required this.utilisateur});
}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void setAuthenticated({required String token, required Utilisateur utilisateur}) {
    emit(AuthAuthenticated(token: token, utilisateur: utilisateur));
  }

  void logout() {
    emit(AuthInitial());
  }
}
