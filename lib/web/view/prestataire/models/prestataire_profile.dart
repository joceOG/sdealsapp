// 🎯 MODÈLE PROFIL PRESTATAIRE
class PrestataireProfile {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String adresse;
  final String ville;
  final String dateNaissance;
  final String genre;
  final String photoProfil;
  final String pieceIdentite;
  final List<String> documents;
  final List<String> categories;
  final List<String> services;
  final String description;
  final List<String> competences;
  final Map<String, double> tarifs;
  final String modePaiement;
  final String disponibilite;
  final String statut;
  final double note;
  final int nombreAvis;
  final DateTime dateCreation;
  final DateTime? dateValidation;

  const PrestataireProfile({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.ville,
    required this.dateNaissance,
    required this.genre,
    required this.photoProfil,
    required this.pieceIdentite,
    required this.documents,
    required this.categories,
    required this.services,
    required this.description,
    required this.competences,
    required this.tarifs,
    required this.modePaiement,
    required this.disponibilite,
    required this.statut,
    required this.note,
    required this.nombreAvis,
    required this.dateCreation,
    this.dateValidation,
  });

  // 🎯 CONSTRUCTEUR DEPUIS MAP
  factory PrestataireProfile.fromMap(Map<String, dynamic> map) {
    return PrestataireProfile(
      id: map['id'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      telephone: map['telephone'] ?? '',
      adresse: map['adresse'] ?? '',
      ville: map['ville'] ?? '',
      dateNaissance: map['dateNaissance'] ?? '',
      genre: map['genre'] ?? '',
      photoProfil: map['photoProfil'] ?? '',
      pieceIdentite: map['pieceIdentite'] ?? '',
      documents: List<String>.from(map['documents'] ?? []),
      categories: List<String>.from(map['categories'] ?? []),
      services: List<String>.from(map['services'] ?? []),
      description: map['description'] ?? '',
      competences: List<String>.from(map['competences'] ?? []),
      tarifs: Map<String, double>.from(map['tarifs'] ?? {}),
      modePaiement: map['modePaiement'] ?? '',
      disponibilite: map['disponibilite'] ?? '',
      statut: map['statut'] ?? 'EN_ATTENTE',
      note: (map['note'] ?? 0.0).toDouble(),
      nombreAvis: map['nombreAvis'] ?? 0,
      dateCreation: DateTime.parse(
          map['dateCreation'] ?? DateTime.now().toIso8601String()),
      dateValidation: map['dateValidation'] != null
          ? DateTime.parse(map['dateValidation'])
          : null,
    );
  }

  // 🎯 CONVERSION VERS MAP
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'ville': ville,
      'dateNaissance': dateNaissance,
      'genre': genre,
      'photoProfil': photoProfil,
      'pieceIdentite': pieceIdentite,
      'documents': documents,
      'categories': categories,
      'services': services,
      'description': description,
      'competences': competences,
      'tarifs': tarifs,
      'modePaiement': modePaiement,
      'disponibilite': disponibilite,
      'statut': statut,
      'note': note,
      'nombreAvis': nombreAvis,
      'dateCreation': dateCreation.toIso8601String(),
      'dateValidation': dateValidation?.toIso8601String(),
    };
  }

  // 🎯 NOM COMPLET
  String get fullName => '$prenom $nom';

  // 🎯 STATUT DISPLAY
  String get statutDisplay {
    switch (statut) {
      case 'EN_ATTENTE':
        return 'En attente de validation';
      case 'VALIDE':
        return 'Validé';
      case 'REJETE':
        return 'Rejeté';
      case 'SUSPENDU':
        return 'Suspendu';
      default:
        return 'Inconnu';
    }
  }

  // 🎯 COULEUR DU STATUT
  String get statutColor {
    switch (statut) {
      case 'EN_ATTENTE':
        return 'orange';
      case 'VALIDE':
        return 'green';
      case 'REJETE':
        return 'red';
      case 'SUSPENDU':
        return 'red';
      default:
        return 'grey';
    }
  }

  // 🎯 EST VALIDÉ
  bool get isValidated => statut == 'VALIDE';

  // 🎯 EST EN ATTENTE
  bool get isPending => statut == 'EN_ATTENTE';

  // 🎯 EST REJETÉ
  bool get isRejected => statut == 'REJETE';

  // 🎯 EST SUSPENDU
  bool get isSuspended => statut == 'SUSPENDU';

  // 🎯 COPIE AVEC MODIFICATIONS
  PrestataireProfile copyWith({
    String? id,
    String? nom,
    String? prenom,
    String? email,
    String? telephone,
    String? adresse,
    String? ville,
    String? dateNaissance,
    String? genre,
    String? photoProfil,
    String? pieceIdentite,
    List<String>? documents,
    List<String>? categories,
    List<String>? services,
    String? description,
    List<String>? competences,
    Map<String, double>? tarifs,
    String? modePaiement,
    String? disponibilite,
    String? statut,
    double? note,
    int? nombreAvis,
    DateTime? dateCreation,
    DateTime? dateValidation,
  }) {
    return PrestataireProfile(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      adresse: adresse ?? this.adresse,
      ville: ville ?? this.ville,
      dateNaissance: dateNaissance ?? this.dateNaissance,
      genre: genre ?? this.genre,
      photoProfil: photoProfil ?? this.photoProfil,
      pieceIdentite: pieceIdentite ?? this.pieceIdentite,
      documents: documents ?? this.documents,
      categories: categories ?? this.categories,
      services: services ?? this.services,
      description: description ?? this.description,
      competences: competences ?? this.competences,
      tarifs: tarifs ?? this.tarifs,
      modePaiement: modePaiement ?? this.modePaiement,
      disponibilite: disponibilite ?? this.disponibilite,
      statut: statut ?? this.statut,
      note: note ?? this.note,
      nombreAvis: nombreAvis ?? this.nombreAvis,
      dateCreation: dateCreation ?? this.dateCreation,
      dateValidation: dateValidation ?? this.dateValidation,
    );
  }

  @override
  String toString() {
    return 'PrestataireProfile(id: $id, nom: $nom, prenom: $prenom, email: $email, statut: $statut)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PrestataireProfile && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}







