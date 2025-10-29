import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/utilisateur.dart';

// 🎯 ÉTATS PROFIL UTILISATEUR
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

// 🚀 ÉTAT INITIAL
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

// ⏳ CHARGEMENT
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

// ✅ PROFIL CHARGÉ
class ProfileLoaded extends ProfileState {
  final Utilisateur utilisateur;
  final bool isEditing;
  final String? successMessage;

  const ProfileLoaded({
    required this.utilisateur,
    this.isEditing = false,
    this.successMessage,
  });

  @override
  List<Object?> get props => [utilisateur, isEditing, successMessage];

  ProfileLoaded copyWith({
    Utilisateur? utilisateur,
    bool? isEditing,
    String? successMessage,
    String? error,
  }) {
    return ProfileLoaded(
      utilisateur: utilisateur ?? this.utilisateur,
      isEditing: isEditing ?? this.isEditing,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

// ❌ ERREUR
class ProfileError extends ProfileState {
  final String error;

  const ProfileError({required this.error});

  @override
  List<Object?> get props => [error];
}

// 💾 SAUVEGARDE
class ProfileSaving extends ProfileState {
  const ProfileSaving();
}

// ✅ SAUVEGARDÉ
class ProfileSaved extends ProfileState {
  final Utilisateur utilisateur;
  final String message;

  const ProfileSaved({
    required this.utilisateur,
    required this.message,
  });

  @override
  List<Object?> get props => [utilisateur, message];
}
