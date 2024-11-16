
class Service{
  String idservice;
  String nomservice;
  String idcategorie;
  String nomcategorie;


  Service({
    required this.idservice,
    required this.nomservice,
    required this.idcategorie,
    required this.nomcategorie,
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
        idcategorie : json['idcategorie'] as String,
        nomcategorie: json['nomcategorie'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'idservice': idservice,
      'nomservice': nomservice,
      'idcategorie': idcategorie,
      'nomcategorie': nomcategorie
      ,
    };
  }
}


