import 'package:equatable/equatable.dart';
import '../../../data/models/commande_model.dart';

abstract class CommandeEvent extends Equatable {
  const CommandeEvent();

  @override
  List<Object?> get props => [];
}

// Événements dédiés aux prestations (service requests)
class ServiceRequestCreate extends CommandeEvent {
  final Map<String, dynamic>
      payload; // contient adresse, ville, dateHeure, etc.
  const ServiceRequestCreate(this.payload);
  @override
  List<Object?> get props => [payload];
}

class ServiceRequestFetchMine extends CommandeEvent {
  final String utilisateurId;
  final String? status;
  const ServiceRequestFetchMine({required this.utilisateurId, this.status});
  @override
  List<Object?> get props => [utilisateurId, status];
}

// Événement pour charger toutes les commandes
class ChargerCommandes extends CommandeEvent {
  const ChargerCommandes();
}

// Événement pour filtrer les commandes par statut
class FiltrerParStatus extends CommandeEvent {
  final CommandeStatus? status;

  const FiltrerParStatus(this.status);

  @override
  List<Object?> get props => [status];
}

// Événement pour ajouter une nouvelle commande
class AjouterCommande extends CommandeEvent {
  final CommandeModel commande;

  const AjouterCommande(this.commande);

  @override
  List<Object?> get props => [commande];
}

// Événement pour mettre à jour une commande existante
class MettreAJourCommande extends CommandeEvent {
  final CommandeModel commande;

  const MettreAJourCommande(this.commande);

  @override
  List<Object?> get props => [commande];
}

// Événement pour noter une commande
class NoterCommande extends CommandeEvent {
  final String commandeId;
  final double note;
  final String commentaire;

  const NoterCommande({
    required this.commandeId,
    required this.note,
    required this.commentaire,
  });

  @override
  List<Object?> get props => [commandeId, note, commentaire];
}

// Événement pour la recherche de commandes
class RechercherCommandes extends CommandeEvent {
  final String query;

  const RechercherCommandes(this.query);

  @override
  List<Object?> get props => [query];
}

// Événement pour annuler une commande
class AnnulerCommande extends CommandeEvent {
  final String commandeId;

  const AnnulerCommande(this.commandeId);

  @override
  List<Object?> get props => [commandeId];
}
