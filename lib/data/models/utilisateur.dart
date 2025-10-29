class Utilisateur {
  String idutilisateur;
  String nom;
  String prenom;
  String email;
  String password;
  String telephone;
  String genre;
  String? note;
  String? role; // Nouveau champ pour le rôle
  String? adresse;
  String? ville;
  String? dateNaissance;
  String? photoProfil;

  Utilisateur({
    required this.idutilisateur,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.telephone,
    required this.genre,
    this.note,
    this.role,
    this.adresse,
    this.ville,
    this.dateNaissance,
    this.photoProfil,
  });

  /// Convertir en Map / JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': idutilisateur,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'telephone': telephone,
      'genre': genre,
      'note': note,
      'role': role,
      'adresse': adresse,
      'ville': ville,
      'dateNaissance': dateNaissance,
      'photoProfil': photoProfil,
    };
  }

  /// Alias pour compatibilité
  Map<String, dynamic> toMap() => toJson();

  /// Construire depuis JSON / Map
  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idutilisateur: json['_id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      telephone: json['telephone'] ?? '',
      genre: json['genre'] ?? '',
      note: json['note'],
      role: json['role'],
      adresse: json['adresse'],
      ville: json['ville'],
      dateNaissance: json['dateNaissance'],
      photoProfil: json['photoProfil'],
    );
  }

  /// Alias fromMap pour compatibilité
  factory Utilisateur.fromMap(Map<String, dynamic> map) =>
      Utilisateur.fromJson(map);

  /// Méthode copyWith pour créer une copie modifiée
  Utilisateur copyWith({
    String? idutilisateur,
    String? nom,
    String? prenom,
    String? email,
    String? password,
    String? telephone,
    String? genre,
    String? note,
    String? role,
    String? adresse,
    String? ville,
    String? dateNaissance,
    String? photoProfil,
  }) {
    return Utilisateur(
      idutilisateur: idutilisateur ?? this.idutilisateur,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      password: password ?? this.password,
      telephone: telephone ?? this.telephone,
      genre: genre ?? this.genre,
      note: note ?? this.note,
      role: role ?? this.role,
      adresse: adresse ?? this.adresse,
      ville: ville ?? this.ville,
      dateNaissance: dateNaissance ?? this.dateNaissance,
      photoProfil: photoProfil ?? this.photoProfil,
    );
  }
}
