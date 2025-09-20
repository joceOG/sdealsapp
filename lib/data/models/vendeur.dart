// Modèle Vendeur pour sdealsapp - Compatible avec l'API backend modernisée
class Vendeur {
  final String id;
  final Utilisateur? utilisateur;

  // 🏪 Informations boutique
  final String shopName;
  final String shopDescription;
  final String? shopLogo;
  final String businessType;
  final List<String> businessCategories;

  // ⭐ Système de notation
  final double rating;
  final int completedOrders;
  final bool isTopRated;
  final bool isFeatured;
  final bool isNew;
  final int responseTime;

  // 💰 Statistiques business
  final double totalEarnings;
  final int totalSales;
  final int currentOrders;
  final double customerSatisfaction;
  final double returnRate;

  // 🚚 Livraison & logistique
  final List<String> deliveryZones;
  final List<String> shippingMethods;
  final Map<String, String> deliveryTimes;

  // 💳 Paiements
  final List<String> paymentMethods;
  final double commissionRate;
  final String payoutFrequency;

  // 📦 Produits
  final List<String> productCategories;
  final int totalProducts;
  final int activeProducts;
  final double averageProductPrice;

  // 🏢 Informations légales
  final String? businessRegistrationNumber;
  final BusinessAddress? businessAddress;
  final String? businessPhone;
  final String? businessEmail;

  // 📊 Politiques
  final String returnPolicy;
  final String? warrantyInfo;
  final double minimumOrderAmount;
  final int maxOrdersPerDay;

  // 🔐 Vérification
  final String verificationLevel;
  final VerificationDocuments? verificationDocuments;
  final bool identityVerified;
  final bool businessVerified;

  // 📈 Activité
  final DateTime lastActive;
  final DateTime joinedDate;
  final int profileViews;
  final double conversionRate;

  // ⚙️ Statut compte
  final String accountStatus;
  final String subscriptionType;
  final List<String> premiumFeatures;

  // 🌐 Réseaux sociaux
  final SocialMedia? socialMedia;
  final String preferredContactMethod;
  final List<String> tags;
  final String? notes;

  const Vendeur({
    required this.id,
    this.utilisateur,
    required this.shopName,
    required this.shopDescription,
    this.shopLogo,
    required this.businessType,
    required this.businessCategories,
    required this.rating,
    required this.completedOrders,
    required this.isTopRated,
    required this.isFeatured,
    required this.isNew,
    required this.responseTime,
    required this.totalEarnings,
    required this.totalSales,
    required this.currentOrders,
    required this.customerSatisfaction,
    required this.returnRate,
    required this.deliveryZones,
    required this.shippingMethods,
    required this.deliveryTimes,
    required this.paymentMethods,
    required this.commissionRate,
    required this.payoutFrequency,
    required this.productCategories,
    required this.totalProducts,
    required this.activeProducts,
    required this.averageProductPrice,
    this.businessRegistrationNumber,
    this.businessAddress,
    this.businessPhone,
    this.businessEmail,
    required this.returnPolicy,
    this.warrantyInfo,
    required this.minimumOrderAmount,
    required this.maxOrdersPerDay,
    required this.verificationLevel,
    this.verificationDocuments,
    required this.identityVerified,
    required this.businessVerified,
    required this.lastActive,
    required this.joinedDate,
    required this.profileViews,
    required this.conversionRate,
    required this.accountStatus,
    required this.subscriptionType,
    required this.premiumFeatures,
    this.socialMedia,
    required this.preferredContactMethod,
    required this.tags,
    this.notes,
  });

  factory Vendeur.fromJson(Map<String, dynamic> json) {
    try {
      print(
          '🔍 Parsing vendeur: ${json['shopName'] ?? json['_id'] ?? 'Inconnu'}');

      return Vendeur(
        id: json['_id'] ?? json['id'] ?? '',
        utilisateur: _parseUtilisateur(json['utilisateur']),

        // 🏪 Informations boutique
        shopName: _cleanString(
            json['shopName'] ?? json['nom'] ?? 'Boutique sans nom'),
        shopDescription:
            _cleanString(json['shopDescription'] ?? json['description'] ?? ''),
        shopLogo: json['shopLogo'] ?? json['logo'],
        businessType:
            _cleanString(json['businessType'] ?? json['type'] ?? 'Particulier'),
        businessCategories:
            _parseStringList(json['businessCategories'] ?? json['categories']),

        // ⭐ Système de notation
        rating: _parseDouble(json['rating']),
        completedOrders: _parseInt(json['completedOrders']),
        isTopRated: json['isTopRated'] ?? false,
        isFeatured: json['isFeatured'] ?? false,
        isNew: json['isNew'] ?? true,
        responseTime: _parseInt(json['responseTime']) ?? 24,

        // 💰 Statistiques business
        totalEarnings: _parseDouble(json['totalEarnings']),
        totalSales: _parseInt(json['totalSales']),
        currentOrders: _parseInt(json['currentOrders']),
        customerSatisfaction: _parseDouble(json['customerSatisfaction']),
        returnRate: _parseDouble(json['returnRate']),

        // 🚚 Livraison
        deliveryZones: _parseStringList(json['deliveryZones']),
        shippingMethods: _parseStringList(json['shippingMethods']),
        deliveryTimes: _parseDeliveryTimes(json['deliveryTimes']),

        // 💳 Paiements
        paymentMethods: _parseStringList(json['paymentMethods']),
        commissionRate: _parseDouble(json['commissionRate']) ?? 5.0,
        payoutFrequency: json['payoutFrequency'] ?? 'Mensuelle',

        // 📦 Produits
        productCategories: _parseStringList(json['productCategories']),
        totalProducts: _parseInt(json['totalProducts']),
        activeProducts: _parseInt(json['activeProducts']),
        averageProductPrice: _parseDouble(json['averageProductPrice']),

        // 🏢 Informations légales
        businessRegistrationNumber: json['businessRegistrationNumber'],
        businessAddress: json['businessAddress'] != null
            ? BusinessAddress.fromJson(json['businessAddress'])
            : null,
        businessPhone: json['businessPhone'],
        businessEmail: json['businessEmail'],

        // 📊 Politiques
        returnPolicy: _cleanString(
            json['returnPolicy'] ?? 'Retour accepté sous 14 jours'),
        warrantyInfo: _cleanString(json['warrantyInfo']),
        minimumOrderAmount: _parseDouble(json['minimumOrderAmount']),
        maxOrdersPerDay: _parseInt(json['maxOrdersPerDay']) ?? 50,

        // 🔐 Vérification
        verificationLevel: json['verificationLevel'] ?? 'Basic',
        verificationDocuments: json['verificationDocuments'] != null
            ? VerificationDocuments.fromJson(json['verificationDocuments'])
            : null,
        identityVerified: json['identityVerified'] ?? false,
        businessVerified: json['businessVerified'] ?? false,

        // 📈 Activité
        lastActive:
            DateTime.tryParse(json['lastActive'] ?? '') ?? DateTime.now(),
        joinedDate:
            DateTime.tryParse(json['joinedDate'] ?? '') ?? DateTime.now(),
        profileViews: _parseInt(json['profileViews']),
        conversionRate: _parseDouble(json['conversionRate']),

        // ⚙️ Statut compte
        accountStatus: json['accountStatus'] ?? 'Pending',
        subscriptionType: json['subscriptionType'] ?? 'Free',
        premiumFeatures: _parseStringList(json['premiumFeatures']),

        // 🌐 Réseaux sociaux
        socialMedia: json['socialMedia'] != null
            ? SocialMedia.fromJson(json['socialMedia'])
            : null,
        preferredContactMethod:
            _cleanString(json['preferredContactMethod'] ?? 'Email'),
        tags: _parseStringList(json['tags']),
        notes: _cleanString(json['notes']),
      );
    } catch (e) {
      print('⚠️ Erreur parsing vendeur: $e');
      print('📄 Données JSON: $json');

      // Retourner un vendeur minimal en cas d'erreur
      return Vendeur(
        id: json['_id'] ??
            json['id'] ??
            'unknown_${DateTime.now().millisecondsSinceEpoch}',
        shopName: json['shopName'] ?? json['nom'] ?? 'Boutique inconnue',
        shopDescription: 'Données incomplètes',
        businessType: 'Particulier',
        businessCategories: [],
        rating: 0.0,
        completedOrders: 0,
        isTopRated: false,
        isFeatured: false,
        isNew: true,
        responseTime: 24,
        totalEarnings: 0.0,
        totalSales: 0,
        currentOrders: 0,
        customerSatisfaction: 0.0,
        returnRate: 0.0,
        deliveryZones: [],
        shippingMethods: [],
        deliveryTimes: {'standard': '3-5 jours'},
        paymentMethods: [],
        commissionRate: 5.0,
        payoutFrequency: 'Mensuelle',
        productCategories: [],
        totalProducts: 0,
        activeProducts: 0,
        averageProductPrice: 0.0,
        returnPolicy: 'Retour accepté sous 14 jours',
        minimumOrderAmount: 0.0,
        maxOrdersPerDay: 50,
        verificationLevel: 'Basic',
        identityVerified: false,
        businessVerified: false,
        lastActive: DateTime.now(),
        joinedDate: DateTime.now(),
        profileViews: 0,
        conversionRate: 0.0,
        accountStatus: 'Pending',
        subscriptionType: 'Free',
        premiumFeatures: [],
        preferredContactMethod: 'Email',
        tags: [],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'utilisateur': utilisateur?.toJson(),
      'shopName': shopName,
      'shopDescription': shopDescription,
      'shopLogo': shopLogo,
      'businessType': businessType,
      'businessCategories': businessCategories,
      'rating': rating,
      'completedOrders': completedOrders,
      'isTopRated': isTopRated,
      'isFeatured': isFeatured,
      'isNew': isNew,
      'responseTime': responseTime,
      'totalEarnings': totalEarnings,
      'totalSales': totalSales,
      'currentOrders': currentOrders,
      'customerSatisfaction': customerSatisfaction,
      'returnRate': returnRate,
      'deliveryZones': deliveryZones,
      'shippingMethods': shippingMethods,
      'deliveryTimes': deliveryTimes,
      'paymentMethods': paymentMethods,
      'commissionRate': commissionRate,
      'payoutFrequency': payoutFrequency,
      'productCategories': productCategories,
      'totalProducts': totalProducts,
      'activeProducts': activeProducts,
      'averageProductPrice': averageProductPrice,
      'businessRegistrationNumber': businessRegistrationNumber,
      'businessAddress': businessAddress?.toJson(),
      'businessPhone': businessPhone,
      'businessEmail': businessEmail,
      'returnPolicy': returnPolicy,
      'warrantyInfo': warrantyInfo,
      'minimumOrderAmount': minimumOrderAmount,
      'maxOrdersPerDay': maxOrdersPerDay,
      'verificationLevel': verificationLevel,
      'verificationDocuments': verificationDocuments?.toJson(),
      'identityVerified': identityVerified,
      'businessVerified': businessVerified,
      'lastActive': lastActive.toIso8601String(),
      'joinedDate': joinedDate.toIso8601String(),
      'profileViews': profileViews,
      'conversionRate': conversionRate,
      'accountStatus': accountStatus,
      'subscriptionType': subscriptionType,
      'premiumFeatures': premiumFeatures,
      'socialMedia': socialMedia?.toJson(),
      'preferredContactMethod': preferredContactMethod,
      'tags': tags,
      'notes': notes,
    };
  }

  // Méthodes utilitaires statiques
  static String _cleanString(dynamic value) {
    if (value == null) return '';
    String str = value.toString();
    // Nettoyer les caractères Unicode mal encodés
    str = str.replaceAll('�', '');
    str = str.replaceAll('Ã´', 'ô');
    str = str.replaceAll('Ã©', 'é');
    str = str.replaceAll('Ã¨', 'è');
    str = str.replaceAll('Ã ', 'à');
    str = str.replaceAll('Ã»', 'û');
    str = str.replaceAll('Ã§', 'ç');
    return str.trim();
  }

  static Utilisateur? _parseUtilisateur(dynamic value) {
    if (value == null) return null;
    try {
      if (value is Map<String, dynamic>) {
        return Utilisateur.fromJson(value);
      }
      return null;
    } catch (e) {
      print('⚠️ Erreur parsing utilisateur: $e');
      return null;
    }
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .map((e) => _cleanString(e))
          .where((s) => s.isNotEmpty)
          .toList();
    }
    if (value is String) {
      if (value.isEmpty) return [];
      // Essayer de séparer par espaces ou virgules
      return value
          .split(RegExp(r'[\s,]+'))
          .map((s) => _cleanString(s))
          .where((s) => s.isNotEmpty)
          .toList();
    }
    return [];
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static Map<String, String> _parseDeliveryTimes(dynamic value) {
    if (value == null) return {'standard': '3-5 jours', 'express': '1-2 jours'};
    if (value is Map<String, dynamic>) {
      return Map<String, String>.from(value);
    }
    return {'standard': '3-5 jours', 'express': '1-2 jours'};
  }
}

// Classes auxiliaires
class Utilisateur {
  final String id;
  final String nom;
  final String prenom;
  final String? email;
  final String? telephone;
  final String? photoProfil;

  const Utilisateur({
    required this.id,
    required this.nom,
    required this.prenom,
    this.email,
    this.telephone,
    this.photoProfil,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    try {
      return Utilisateur(
        id: json['_id'] ?? json['id'] ?? '',
        nom: Vendeur._cleanString(json['nom'] ?? json['lastName'] ?? ''),
        prenom: Vendeur._cleanString(json['prenom'] ?? json['firstName'] ?? ''),
        email: json['email'] ?? json['adresseEmail'],
        telephone:
            json['telephone'] ?? json['phone'] ?? json['numeroTelephone'],
        photoProfil: json['photoProfil'] ?? json['profilePhoto'],
      );
    } catch (e) {
      print('⚠️ Erreur parsing utilisateur: $e');
      return Utilisateur(
        id: json['_id'] ?? json['id'] ?? 'unknown',
        nom: 'Nom inconnu',
        prenom: 'Prénom inconnu',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'photoProfil': photoProfil,
    };
  }

  String get fullName => '$nom $prenom';
}

class BusinessAddress {
  final String? street;
  final String city;
  final String? postalCode;
  final String country;
  final Coordinates? coordinates;

  const BusinessAddress({
    this.street,
    required this.city,
    this.postalCode,
    required this.country,
    this.coordinates,
  });

  factory BusinessAddress.fromJson(Map<String, dynamic> json) {
    try {
      return BusinessAddress(
        street: Vendeur._cleanString(
            json['street'] ?? json['rue'] ?? json['address']),
        city: Vendeur._cleanString(
            json['city'] ?? json['ville'] ?? json['localisation'] ?? ''),
        postalCode: json['postalCode'] ?? json['codePostal'],
        country: json['country'] ?? json['pays'] ?? 'Côte d\'Ivoire',
        coordinates: json['coordinates'] != null
            ? Coordinates.fromJson(json['coordinates'])
            : null,
      );
    } catch (e) {
      print('⚠️ Erreur parsing BusinessAddress: $e');
      return BusinessAddress(
        city: json['city'] ??
            json['ville'] ??
            json['localisation'] ??
            'Ville inconnue',
        country: 'Côte d\'Ivoire',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'coordinates': coordinates?.toJson(),
    };
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    try {
      return Coordinates(
        latitude: _parseDouble(json['latitude'] ?? json['lat']),
        longitude:
            _parseDouble(json['longitude'] ?? json['lng'] ?? json['lon']),
      );
    } catch (e) {
      print('⚠️ Erreur parsing Coordinates: $e');
      return const Coordinates(latitude: 0.0, longitude: 0.0);
    }
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class VerificationDocuments {
  final String? cni1;
  final String? cni2;
  final String? selfie;
  final String? businessLicense;
  final String? taxDocument;
  final bool isVerified;

  const VerificationDocuments({
    this.cni1,
    this.cni2,
    this.selfie,
    this.businessLicense,
    this.taxDocument,
    required this.isVerified,
  });

  factory VerificationDocuments.fromJson(Map<String, dynamic> json) {
    try {
      return VerificationDocuments(
        cni1: json['cni1'] ?? json['cni'],
        cni2: json['cni2'] ?? json['cni_verso'],
        selfie: json['selfie'] ?? json['photo'],
        businessLicense: json['businessLicense'] ?? json['licenseCommerciale'],
        taxDocument: json['taxDocument'] ?? json['documentFiscal'],
        isVerified: json['isVerified'] ?? json['verifier'] ?? false,
      );
    } catch (e) {
      print('⚠️ Erreur parsing VerificationDocuments: $e');
      return const VerificationDocuments(isVerified: false);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'cni1': cni1,
      'cni2': cni2,
      'selfie': selfie,
      'businessLicense': businessLicense,
      'taxDocument': taxDocument,
      'isVerified': isVerified,
    };
  }
}

class SocialMedia {
  final String? facebook;
  final String? instagram;
  final String? whatsapp;
  final String? website;

  const SocialMedia({
    this.facebook,
    this.instagram,
    this.whatsapp,
    this.website,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    try {
      return SocialMedia(
        facebook: json['facebook'] ?? json['facebookUrl'],
        instagram: json['instagram'] ?? json['instagramUrl'],
        whatsapp: json['whatsapp'] ?? json['whatsappNumber'],
        website: json['website'] ?? json['siteWeb'] ?? json['websiteUrl'],
      );
    } catch (e) {
      print('⚠️ Erreur parsing SocialMedia: $e');
      return const SocialMedia();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'instagram': instagram,
      'whatsapp': whatsapp,
      'website': website,
    };
  }
}
