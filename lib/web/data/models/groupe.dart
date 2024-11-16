
class Groupe {
  String idgroupe;
  String nomgroupe;

  Groupe({
    required this.idgroupe,
    required this.nomgroupe,
  });

  /*factory Groupe.fromJson(Map<String, dynamic> json){
    return Groupe(
      idgroupe: json['idgroupe'] as String,
      nomgroupe:  json['nomgroupe'] as String,
    );
  } */

  factory Groupe.fromJson(dynamic json) {
    return Groupe(
        idgroupe : json['_id'] as String,
        nomgroupe: json['nomgroupe'] as String);
  }


  Map<String, dynamic> toMap() {
    return {
      'idgroupe': idgroupe,
      'nomgroupe': nomgroupe
      ,
    };
  }
}


