

import 'groupe.dart';

class Categorie{
  String nomcategorie;
  String imagecategorie;
  Object groupe;

  Categorie({
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
        nomcategorie: json['nomcategorie'] as String,
        imagecategorie : json['imagecategorie'] as String,
         groupe : json['groupe'] as Object,
    );}

  Map<String, dynamic> toMap() {
    return {
      'nomcategorie': nomcategorie,
      'imagecategorie' : imagecategorie,
      'groupe' : groupe,
    };
  }
}


