

import 'groupe.dart';

class Categorie{
  String idcategorie;
  String nomcategorie;
  String imagecategorie;
  String groupe;

  Categorie({
    required this.idcategorie,
    required this.nomcategorie,
    required this.imagecategorie,
    required this.groupe,
  });

  /*factory Groupe.fromJson(Map<String, dynamic> json){
    return Groupe(
      idgroupe: json['idgroupe'] as String,
      nomgroupe:  json['nomgroupe'] as String,
    );
  } */

  factory Categorie.fromJson(dynamic json) {
    return Categorie(
        idcategorie: json['_id'] as String,
        nomcategorie: json['nomcategorie'] as String,
        imagecategorie : json['imagecategorie'] as String,
         groupe : json['groupe'] as String,
    );}

  Map<String, dynamic> toMap() {
    return {
      '_id': idcategorie,
      'nomcategorie': nomcategorie,
      'imagecategorie' : imagecategorie,
      'groupe' : groupe,
    };
  }
}


