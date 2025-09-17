import 'service.dart';
import 'utilisateur.dart';

class Prestataire {
  String idprestataire;
  Utilisateur utilisateur;
  Service service;
  double prixprestataire;
  String localisation;
  LocalisationMaps? localisationMaps; // ✅ maintenant structuré
  String? note;
  bool verifier;

  // Identité
  String? cni1;
  String? cni2;
  String? selfie;
  String? numeroCNI;

  // Métier
  List<String>? specialite;
  String? anneeExperience;
  String? description;
  double? rayonIntervention;
  List<String>? zoneIntervention;
  double? tarifHoraireMin;
  double? tarifHoraireMax;

  // Diplômes / Certificats
  List<String>? diplomeCertificat;
  String? attestationAssurance;
  String? numeroAssurance;
  String? numeroRCCM;

  Prestataire({
    required this.idprestataire,
    required this.utilisateur,
    required this.service,
    required this.prixprestataire,
    required this.localisation,
    this.localisationMaps,
    this.note,
    this.verifier = false,
    this.cni1,
    this.cni2,
    this.selfie,
    this.numeroCNI,
    this.specialite,
    this.anneeExperience,
    this.description,
    this.rayonIntervention,
    this.zoneIntervention,
    this.tarifHoraireMin,
    this.tarifHoraireMax,
    this.diplomeCertificat,
    this.attestationAssurance,
    this.numeroAssurance,
    this.numeroRCCM,
  });

  factory Prestataire.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return Prestataire(
      idprestataire: map['_id'] as String,
      utilisateur: Utilisateur.fromJson(map['utilisateur']),
      service: Service.fromJson(map['service']),
      prixprestataire: (map['prixprestataire'] as num).toDouble(),
      localisation: map['localisation'] as String,
      localisationMaps: map['localisationmaps'] != null
          ? LocalisationMaps.fromJson(map['localisationmaps'])
          : null,
      note: map['note'] as String?,
      verifier: map['verifier'] as bool? ?? false,
      cni1: map['cni1'] as String?,
      cni2: map['cni2'] as String?,
      selfie: map['selfie'] as String?,
      numeroCNI: map['numeroCNI'] as String?,
      specialite: map['specialite'] != null ? List<String>.from(map['specialite']) : null,
      anneeExperience: map['anneeExperience'] as String?,
      description: map['description'] as String?,
      rayonIntervention: map['rayonIntervention'] != null ? (map['rayonIntervention'] as num).toDouble() : null,
      zoneIntervention: map['zoneIntervention'] != null ? List<String>.from(map['zoneIntervention']) : null,
      tarifHoraireMin: map['tarifHoraireMin'] != null ? (map['tarifHoraireMin'] as num).toDouble() : null,
      tarifHoraireMax: map['tarifHoraireMax'] != null ? (map['tarifHoraireMax'] as num).toDouble() : null,
      diplomeCertificat: map['diplomeCertificat'] != null ? List<String>.from(map['diplomeCertificat']) : null,
      attestationAssurance: map['attestationAssurance'] as String?,
      numeroAssurance: map['numeroAssurance'] as String?,
      numeroRCCM: map['numeroRCCM'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': idprestataire,
      'utilisateur': utilisateur.toJson(),
      'service': service.toJson(),
      'prixprestataire': prixprestataire,
      'localisation': localisation,
      'localisationmaps': localisationMaps?.toJson(),
      'note': note,
      'verifier': verifier,
      'cni1': cni1,
      'cni2': cni2,
      'selfie': selfie,
      'numeroCNI': numeroCNI,
      'specialite': specialite,
      'anneeExperience': anneeExperience,
      'description': description,
      'rayonIntervention': rayonIntervention,
      'zoneIntervention': zoneIntervention,
      'tarifHoraireMin': tarifHoraireMin,
      'tarifHoraireMax': tarifHoraireMax,
      'diplomeCertificat': diplomeCertificat,
      'attestationAssurance': attestationAssurance,
      'numeroAssurance': numeroAssurance,
      'numeroRCCM': numeroRCCM,
    };
  }

  Map<String, dynamic> toMap() => toJson();
}


class LocalisationMaps {
  double latitude;
  double longitude;

  LocalisationMaps({required this.latitude, required this.longitude});

  factory LocalisationMaps.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return LocalisationMaps(
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  Map<String, dynamic> toMap() => toJson();
}
