import 'package:equatable/equatable.dart';

// 🎯 ÉVÉNEMENTS D'INSCRIPTION PRESTATAIRE
abstract class PrestataireRegistrationEvent extends Equatable {
  const PrestataireRegistrationEvent();

  @override
  List<Object?> get props => [];
}

// 🚀 DÉMARRER L'INSCRIPTION
class StartRegistration extends PrestataireRegistrationEvent {
  const StartRegistration();
}

// 📝 ÉTAPE SUIVANTE
class NextStep extends PrestataireRegistrationEvent {
  const NextStep();
}

// ⬅️ ÉTAPE PRÉCÉDENTE
class PreviousStep extends PrestataireRegistrationEvent {
  const PreviousStep();
}

// 💾 SAUVEGARDER LES INFORMATIONS PERSONNELLES
class SavePersonalInfo extends PrestataireRegistrationEvent {
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String adresse;
  final String ville;
  final String dateNaissance;
  final String genre;

  const SavePersonalInfo({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.ville,
    required this.dateNaissance,
    required this.genre,
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
      ];
}

// 🛠️ SAUVEGARDER LA SÉLECTION DE SERVICES
class SaveServiceSelection extends PrestataireRegistrationEvent {
  final List<String> categories;
  final List<String> services;
  final String description;
  final List<String> competences;

  const SaveServiceSelection({
    required this.categories,
    required this.services,
    required this.description,
    required this.competences,
  });

  @override
  List<Object?> get props => [categories, services, description, competences];
}

// 💰 SAUVEGARDER LES TARIFS
class SavePricing extends PrestataireRegistrationEvent {
  final Map<String, double> tarifs;
  final String modePaiement;
  final String disponibilite;

  const SavePricing({
    required this.tarifs,
    required this.modePaiement,
    required this.disponibilite,
  });

  @override
  List<Object?> get props => [tarifs, modePaiement, disponibilite];
}

// 📄 SAUVEGARDER LES DOCUMENTS
class SaveDocuments extends PrestataireRegistrationEvent {
  final List<String> documents;
  final String photoProfil;
  final String pieceIdentite;

  const SaveDocuments({
    required this.documents,
    required this.photoProfil,
    required this.pieceIdentite,
  });

  @override
  List<Object?> get props => [documents, photoProfil, pieceIdentite];
}

// ✅ SOUMETTRE L'INSCRIPTION
class SubmitRegistration extends PrestataireRegistrationEvent {
  const SubmitRegistration();
}

// 🔄 RÉINITIALISER LE FORMULAIRE
class ResetRegistration extends PrestataireRegistrationEvent {
  const ResetRegistration();
}

// ❌ ANNULER L'INSCRIPTION
class CancelRegistration extends PrestataireRegistrationEvent {
  const CancelRegistration();
}

