import 'package:equatable/equatable.dart';

class Prestataire extends Equatable {
  final String id;
  final String nom;
  final String prenom;
  final String telephone;
  final String? email;
  final String? photo;
  final String? adresse;
  final String? ville;
  final String? quartier;
  final double? latitude;
  final double? longitude;
  final String? serviceId;
  final String? serviceName;
  final String? categorieId;
  final String? categorieName;
  final bool verifier;
  final double? note;
  final int? nombreAvis;
  final String? description;
  final List<String>? competences;
  final List<String>? photos;
  final DateTime? dateCreation;
  final bool actif;
  final String? localisation;

  const Prestataire({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
    this.email,
    this.photo,
    this.adresse,
    this.ville,
    this.quartier,
    this.latitude,
    this.longitude,
    this.serviceId,
    this.serviceName,
    this.categorieId,
    this.categorieName,
    this.verifier = false,
    this.note,
    this.nombreAvis,
    this.description,
    this.competences,
    this.photos,
    this.dateCreation,
    this.actif = true,
    this.localisation,
  });

  factory Prestataire.fromJson(Map<String, dynamic> json) {
    return Prestataire(
      id: json['_id'] ?? json['id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      telephone: json['telephone'] ?? '',
      email: json['email'],
      photo: json['photo'] ?? json['image'],
      adresse: json['adresse'],
      ville: json['ville'],
      quartier: json['quartier'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      serviceId: json['service']?['_id'] ?? json['serviceId'],
      serviceName: json['service']?['nomservice'] ?? json['serviceName'],
      categorieId: json['categorie']?['_id'] ?? json['categorieId'],
      categorieName:
          json['categorie']?['nomcategorie'] ?? json['categorieName'],
      verifier: json['verifier'] ?? json['verified'] ?? false,
      note: json['note']?.toDouble(),
      nombreAvis: json['nombreAvis'] ?? json['avis']?.length,
      description: json['description'],
      competences: json['competences'] != null
          ? List<String>.from(json['competences'])
          : null,
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
      dateCreation: json['dateCreation'] != null
          ? DateTime.parse(json['dateCreation'])
          : null,
      actif: json['actif'] ?? true,
      localisation: json['localisation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'photo': photo,
      'adresse': adresse,
      'ville': ville,
      'quartier': quartier,
      'latitude': latitude,
      'longitude': longitude,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'categorieId': categorieId,
      'categorieName': categorieName,
      'verifier': verifier,
      'note': note,
      'nombreAvis': nombreAvis,
      'description': description,
      'competences': competences,
      'photos': photos,
      'dateCreation': dateCreation?.toIso8601String(),
      'actif': actif,
      'localisation': localisation,
    };
  }

  String get fullName => '$nom $prenom';

  String get displayLocation {
    if (ville != null && quartier != null) {
      return '$quartier, $ville';
    } else if (ville != null) {
      return ville!;
    } else if (localisation != null) {
      return localisation!;
    }
    return 'Localisation non précisée';
  }

  String get ratingDisplay {
    if (note != null) {
      return '${note!.toStringAsFixed(1)} (${nombreAvis ?? 0} avis)';
    }
    return 'Pas encore noté';
  }

  @override
  List<Object?> get props => [
        id,
        nom,
        prenom,
        telephone,
        email,
        photo,
        adresse,
        ville,
        quartier,
        latitude,
        longitude,
        serviceId,
        serviceName,
        categorieId,
        categorieName,
        verifier,
        note,
        nombreAvis,
        description,
        competences,
        photos,
        dateCreation,
        actif,
        localisation,
      ];
}
