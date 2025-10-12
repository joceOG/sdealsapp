import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/utilisateur.dart';

class ConnexionState extends Equatable {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final Utilisateur? utilisateur;
  final String? token;

  const ConnexionState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
    this.utilisateur,
    this.token,
  });

  ConnexionState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    Utilisateur? utilisateur,
    String? token,
  }) {
    return ConnexionState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
      utilisateur: utilisateur ?? this.utilisateur,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isAuthenticated, error, utilisateur, token];
}
