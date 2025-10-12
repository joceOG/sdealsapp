import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/utilisateur.dart';

class InscriptionState extends Equatable {
  final bool isLoading;
  final bool isRegistered;
  final String? error;
  final Utilisateur? utilisateur;
  final String? token;

  const InscriptionState({
    this.isLoading = false,
    this.isRegistered = false,
    this.error,
    this.utilisateur,
    this.token,
  });

  InscriptionState copyWith({
    bool? isLoading,
    bool? isRegistered,
    String? error,
    Utilisateur? utilisateur,
    String? token,
  }) {
    return InscriptionState(
      isLoading: isLoading ?? this.isLoading,
      isRegistered: isRegistered ?? this.isRegistered,
      error: error ?? this.error,
      utilisateur: utilisateur ?? this.utilisateur,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isRegistered, error, utilisateur, token];
}
