


class Article{
  String nomArticle;
  String prixArticle;
  int quantiteArticle;
  String photoArticle;
  //Object categorie;

  Article({
    required this.nomArticle,
    required this.prixArticle,
    required this.quantiteArticle,
    required this.photoArticle,
    //required this.categorie,
  });

  /*factory Groupe.fromJson(Map<String, dynamic> json){
    return Groupe(
      idgroupe: json['idgroupe'] as String,
      nomgroupe:  json['nomgroupe'] as String,
    );
  } */

  factory Article.fromJson(dynamic json) {
    return Article(
        nomArticle : json['nomArticle'] as String,
        prixArticle: json['prixArticle'] as String,
        quantiteArticle: json['quantiteArticle']! as int,
        photoArticle : json['photoArticle'] as String
        //categorie: json['categorie'] as Object
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomArticle': nomArticle,
      'prixArticle': prixArticle,
      'quantiteArticle': quantiteArticle,
      'photoArticle': photoArticle,
      //'categorie': categorie,
    };
  }
}


