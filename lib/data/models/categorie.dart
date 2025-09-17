import 'package:sdealsapp/data/models/groupe.dart';

class Categorie {
  String idcategorie;
  String nomcategorie;
  String imagecategorie;
  Groupe groupe; // objet

  Categorie({
    required this.idcategorie,
    required this.nomcategorie,
    required this.imagecategorie,
    required this.groupe,
  });

  factory Categorie.fromJson(dynamic json) {
    // json peut être Map<String, dynamic>
    final map = json as Map<String, dynamic>;
    final g = map['groupe'];
    return Categorie(
      idcategorie: map['_id'] as String,
      nomcategorie: map['nomcategorie'] as String,
      imagecategorie: map['imagecategorie'] as String,
      // Gère populate ou simple ObjectId string
      groupe: g is Map<String, dynamic>
          ? Groupe.fromJson(g)
          : Groupe(idgroupe: g as String, nomgroupe: ''), // placeholder si pas populate
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': idcategorie,
      'nomcategorie': nomcategorie,
      'imagecategorie': imagecategorie,
      'groupe': groupe.toJson(),
    };
  }

  // Optionnel : alias pour compat
  Map<String, dynamic> toMap() => toJson();
}