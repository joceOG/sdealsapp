
class Categorie{
  String nomcategorie;
  String idgroupe;

  String imagecategorie;



  Categorie({
    required this.nomcategorie,
    required this.idgroupe,
    required this.imagecategorie
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
        idgroupe : json['idgroupe'] as String,
        imagecategorie : json['imagecategorie'] as String,
    );}
  Map<String, dynamic> toMap() {
    return {

      'nomcategorie': nomcategorie,
      'idgroupe': idgroupe,
      'imagecategorie' : imagecategorie
      ,
    };
  }
}


