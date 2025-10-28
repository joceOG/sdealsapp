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
    );
  }

  /// Alias fromMap pour compatibilité
  factory Utilisateur.fromMap(Map<String, dynamic> map) =>
      Utilisateur.fromJson(map);
}
