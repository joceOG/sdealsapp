
class Prestataire {
  String idutilisateur;
  String nomprenom;
  String telephone;
  String idservice;
  String nomservice;
  String prixmoyen;
  String localisation;
  String note;
  String verifier;

  Prestataire({
    required this.idutilisateur,
    required this.nomprenom,
    required this.telephone,
    required this.idservice,
    required this.nomservice,
    required this.prixmoyen,
    required this.localisation,
    required this.note,
    required this.verifier,
  });

  Map<String, dynamic> toMap() {
    return {
      'idutilisateur': idutilisateur,
      'nomprenom': telephone,
      'idservice': idservice,
      'nomservice': nomservice,
      'prixmoyen': prixmoyen,
      'localisation': localisation,
      'note': note,
      'verifier': verifier,
    };
  }
}


