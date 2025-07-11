import 'package:flutter/material.dart';

enum CommandeStatus {
  enAttente,
  enCours,
  terminee,
  annulee,
}

class CommandeModel {
  final String id;
  final String prestataireId;
  final String prestataireName;
  final String prestataireImage;
  final String typeService;
  final double montant;
  final DateTime dateCommande;
  final CommandeStatus status;
  final bool estNotee;
  final String? commentaire;
  final double? note;
  final String? adresseLivraison;

  CommandeModel({
    required this.id,
    required this.prestataireId,
    required this.prestataireName,
    required this.prestataireImage,
    required this.typeService,
    required this.montant,
    required this.dateCommande,
    required this.status,
    this.estNotee = false,
    this.commentaire,
    this.note,
    this.adresseLivraison,
  });

  // Helper pour formater la date en texte lisible
  String get dateFormatee {
    return "${dateCommande.day}/${dateCommande.month}/${dateCommande.year} à ${dateCommande.hour}:${dateCommande.minute.toString().padLeft(2, '0')}";
  }

  // Helper pour obtenir la couleur associée au statut
  Color get statusColor {
    switch (status) {
      case CommandeStatus.enAttente:
        return Colors.orange;
      case CommandeStatus.enCours:
        return Colors.blue;
      case CommandeStatus.terminee:
        return Colors.green;
      case CommandeStatus.annulee:
        return Colors.red;
    }
  }

  // Helper pour obtenir le texte du statut
  String get statusText {
    switch (status) {
      case CommandeStatus.enAttente:
        return "En attente";
      case CommandeStatus.enCours:
        return "En cours";
      case CommandeStatus.terminee:
        return "Terminée";
      case CommandeStatus.annulee:
        return "Annulée";
    }
  }

  // Helper pour savoir si on peut noter cette commande
  bool get peutEtreNotee {
    return status == CommandeStatus.terminee && !estNotee;
  }

  // Méthode pour créer une copie modifiée de l'instance
  CommandeModel copyWith({
    String? id,
    String? prestataireId,
    String? prestataireName,
    String? prestataireImage,
    String? typeService,
    double? montant,
    DateTime? dateCommande,
    CommandeStatus? status,
    bool? estNotee,
    String? commentaire,
    double? note,
    String? adresseLivraison,
  }) {
    return CommandeModel(
      id: id ?? this.id,
      prestataireId: prestataireId ?? this.prestataireId,
      prestataireName: prestataireName ?? this.prestataireName,
      prestataireImage: prestataireImage ?? this.prestataireImage,
      typeService: typeService ?? this.typeService,
      montant: montant ?? this.montant,
      dateCommande: dateCommande ?? this.dateCommande,
      status: status ?? this.status,
      estNotee: estNotee ?? this.estNotee,
      commentaire: commentaire ?? this.commentaire,
      note: note ?? this.note,
      adresseLivraison: adresseLivraison ?? this.adresseLivraison,
    );
  }
}

// Liste simulée de commandes pour les tests
List<CommandeModel> commandesSimulees = [
  CommandeModel(
    id: "CMD001",
    prestataireId: "P001",
    prestataireName: "EcoJardin Pro",
    prestataireImage: "assets/profil.png",
    typeService: "Jardinage",
    montant: 15000,
    dateCommande: DateTime.now().subtract(const Duration(days: 1)),
    status: CommandeStatus.enCours,
  ),
  CommandeModel(
    id: "CMD002",
    prestataireId: "P002",
    prestataireName: "Electro Services",
    prestataireImage: "assets/profil.png",
    typeService: "Réparation électrique",
    montant: 25000,
    dateCommande: DateTime.now().subtract(const Duration(days: 5)),
    status: CommandeStatus.terminee,
    estNotee: true,
    note: 4.5,
    commentaire: "Service rapide et efficace",
  ),
  CommandeModel(
    id: "CMD003",
    prestataireId: "P003",
    prestataireName: "CleanHome",
    prestataireImage: "assets/profil.png",
    typeService: "Nettoyage",
    montant: 12000,
    dateCommande: DateTime.now().subtract(const Duration(days: 3)),
    status: CommandeStatus.enAttente,
  ),
  CommandeModel(
    id: "CMD004",
    prestataireId: "P004",
    prestataireName: "Express Delivery",
    prestataireImage: "assets/profil.png",
    typeService: "Livraison",
    montant: 5000,
    dateCommande: DateTime.now().subtract(const Duration(days: 2)),
    status: CommandeStatus.annulee,
  ),
  CommandeModel(
    id: "CMD005",
    prestataireId: "P005",
    prestataireName: "TechRepair",
    prestataireImage: "assets/profil.png",
    typeService: "Réparation électronique",
    montant: 35000,
    dateCommande: DateTime.now().subtract(const Duration(days: 10)),
    status: CommandeStatus.terminee,
    estNotee: false,
  ),
  CommandeModel(
    id: "CMD006",
    prestataireId: "P006",
    prestataireName: "BâtiSolid",
    prestataireImage: "assets/profil.png",
    typeService: "Rénovation",
    montant: 180000,
    dateCommande: DateTime.now().subtract(const Duration(days: 15)),
    status: CommandeStatus.enCours,
  ),
  CommandeModel(
    id: "CMD007",
    prestataireId: "P007",
    prestataireName: "ModeCoiffure",
    prestataireImage: "assets/profil.png",
    typeService: "Coiffure à domicile",
    montant: 8000,
    dateCommande: DateTime.now(),
    status: CommandeStatus.enAttente,
  ),
];
