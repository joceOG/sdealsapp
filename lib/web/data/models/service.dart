
class Service{
  String idservice;
  String nomservice;
  String categorie;
  String nomgroupe;
  
  Service({
    required this.idservice,
    required this.nomservice,
    required this.categorie,
    required this.nomgroupe,
  });

  /*factory Groupe.fromJson(Map<String, dynamic> json){
    return Groupe(
      idgroupe: json['idgroupe'] as String,
      nomgroupe:  json['nomgroupe'] as String,
    );
  } */

  factory Service.fromJson(dynamic json) {
    return Service(
        idservice : json['_id'] as String,
        nomservice : json['nomservice'] as String,
        categorie : json['categorie'] as String,
        nomgroupe: json['nomgroupe'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'idservice': idservice,
      'nomservice': nomservice,
      'categorie': categorie,
      'nomgroupe': nomgroupe
      ,
    };
  }
}


