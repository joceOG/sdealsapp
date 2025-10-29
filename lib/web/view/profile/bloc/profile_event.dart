import 'package:equatable/equatable.dart';

// 🎯 ÉVÉNEMENTS PROFIL UTILISATEUR
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// 🚀 CHARGER LE PROFIL
class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

// 💾 SAUVEGARDER LE PROFIL
class SaveProfile extends ProfileEvent {
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String? adresse;
  final String? ville;
  final String? dateNaissance;
  final String? genre;
  final String? photoProfil;

  const SaveProfile({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    this.adresse,
    this.ville,
    this.dateNaissance,
    this.genre,
    this.photoProfil,
  });

  @override
  List<Object?> get props => [
        nom,
        prenom,
        email,
        telephone,
        adresse,
        ville,
        dateNaissance,
        genre,
        photoProfil,
      ];
}

// 🔄 CHANGER LE MOT DE PASSE
class ChangePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePassword({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

// 📸 CHANGER LA PHOTO DE PROFIL
class ChangeProfilePicture extends ProfileEvent {
  final String imagePath;

  const ChangeProfilePicture({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

// 🔄 ACTUALISER LE PROFIL
class RefreshProfile extends ProfileEvent {
  const RefreshProfile();
}

// ❌ EFFACER L'ERREUR
class ClearProfileError extends ProfileEvent {
  const ClearProfileError();
}
