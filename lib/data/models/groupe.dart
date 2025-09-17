class Groupe {
  String idgroupe;
  String nomgroupe;

  Groupe({
    required this.idgroupe,
    required this.nomgroupe,
  });

  factory Groupe.fromJson(Map<String, dynamic> json) {
    return Groupe(
      idgroupe: json['_id'] as String,
      nomgroupe: json['nomgroupe'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': idgroupe,
      'nomgroupe': nomgroupe,
    };
  }

  // Optionnel : alias pour compat
  Map<String, dynamic> toMap() => toJson();
}