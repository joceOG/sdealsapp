import 'categorie.dart';

class Service {
  String idservice;
  String nomservice;
  String imageservice;
  String prixmoyen;
  Categorie? categorie; // nullable

  Service({
    required this.idservice,
    required this.nomservice,
    required this.imageservice,
    required this.prixmoyen,
    this.categorie,
  });

  factory Service.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return Service(
      idservice: map['_id'] as String,
      nomservice: map['nomservice'] as String,
      imageservice: map['imageservice'] as String,
      prixmoyen: map['prixmoyen'] as String,
      categorie: map['categorie'] != null
          ? Categorie.fromJson(map['categorie'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': idservice,
      'nomservice': nomservice,
      'imageservice': imageservice,
      'prixmoyen': prixmoyen,
      'categorie': categorie?.toJson(),
    };
  }

  Map<String, dynamic> toMap() => toJson();
}
