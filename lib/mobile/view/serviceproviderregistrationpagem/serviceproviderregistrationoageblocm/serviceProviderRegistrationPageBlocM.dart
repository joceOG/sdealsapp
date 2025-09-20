import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'serviceProviderRegistrationPageEventM.dart';
import 'serviceProviderRegistrationPageStateM.dart';

class ServiceProviderRegistrationBlocM extends Bloc<
    ServiceProviderRegistrationEventM, ServiceProviderRegistrationStateM> {
  ServiceProviderRegistrationBlocM()
      : super(ServiceProviderRegistrationInitial()) {
    on<SubmitServiceProviderRegistrationEvent>(_onSubmitRegistration);
  }

  Future<void> _onSubmitRegistration(
    SubmitServiceProviderRegistrationEvent event,
    Emitter<ServiceProviderRegistrationStateM> emit,
  ) async {
    emit(ServiceProviderRegistrationLoading());
    print("🚀 Démarrage inscription prestataire: ${event.formData.toString()}");

    try {
      final apiUrl = dotenv.env['API_URL'];
      if (apiUrl == null) {
        throw Exception('URL API non configurée');
      }

      // ✅ ÉTAPE 1: Utiliser l'utilisateur existant si présent, sinon créer
      String userId;
      if ((event.formData['existingUserId'] as String?)?.isNotEmpty == true) {
        userId = event.formData['existingUserId'];
        print("✅ Utilisateur existant détecté: $userId (pas de réinscription)");
      } else {
        final userData = _prepareUserData(event.formData);
        print("📤 Création utilisateur: $userData");

        final userResponse = await http.post(
          Uri.parse("$apiUrl/register"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userData),
        );

        if (userResponse.statusCode != 200 && userResponse.statusCode != 201) {
          final errorData = jsonDecode(userResponse.body);
          throw Exception(
              "Erreur création utilisateur: ${errorData['error'] ?? userResponse.body}");
        }

        final userResult = jsonDecode(userResponse.body);
        userId = userResult['utilisateur']['_id'];
        print("✅ Utilisateur créé avec ID: $userId");
      }

      // ✅ ÉTAPE 2: Créer le prestataire avec le nouveau modèle
      final prestataireData = _preparePrestataireData(event.formData, userId);
      print("📤 Création prestataire: $prestataireData");

      final prestataireResponse = await http.post(
        Uri.parse("$apiUrl/prestataire"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(prestataireData),
      );

      if (prestataireResponse.statusCode == 201 ||
          prestataireResponse.statusCode == 200) {
        print("✅ Prestataire créé avec succès!");
        emit(ServiceProviderRegistrationSuccess(
            message:
                "🎉 Inscription réussie ! Bienvenue chez Soutrali Deals !"));
      } else {
        final errorData = jsonDecode(prestataireResponse.body);
        print("❌ Erreur création prestataire: ${prestataireResponse.body}");
        emit(ServiceProviderRegistrationFailure(
          error:
              "Erreur création prestataire: ${errorData['error'] ?? prestataireResponse.body}",
        ));
      }
    } catch (e) {
      print("💥 Erreur inscription: $e");
      emit(ServiceProviderRegistrationFailure(
          error: "Erreur d'inscription: $e"));
    }
  }

  // ✅ PRÉPARATION DES DONNÉES UTILISATEUR
  Map<String, dynamic> _prepareUserData(Map<String, dynamic> formData) {
    // Séparer le nom complet en nom et prénom
    final fullName = formData['fullName'] as String? ?? '';
    final nameParts = fullName.trim().split(' ');
    final nom = nameParts.isNotEmpty ? nameParts.first : '';
    final prenom = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return {
      "nom": nom,
      "prenom": prenom,
      "telephone": formData['phone'] ?? '',
      "email": formData['email'] ?? '',
      "password": formData['password'] ?? '',
      "genre": formData['gender'] ?? 'Homme',
    };
  }

  // ✅ PRÉPARATION DES DONNÉES PRESTATAIRE (NOUVEAU MODÈLE)
  Map<String, dynamic> _preparePrestataireData(
      Map<String, dynamic> formData, String userId) {
    return {
      // Champs de base
      "utilisateur": userId,
      "name": formData['fullName'] ?? '',
      "job": formData['category'] ?? '',
      "category": formData['category'] ?? '',

      // Système de performance
      "rating": 0,
      "completedJobs": 0,
      "isTopRated": false,
      "isFeatured": false,
      "isNew": true,
      "responseTime": 24,

      // Compétences et tarification
      "skills": formData['specialties'] ?? [],
      "hourlyRate": formData['minimumHourlyRate'] ?? 0,
      "description": formData['serviceDescription'] ?? '',

      // Informations professionnelles
      "experienceLevel": _convertExperience(formData['yearsOfExperience']),
      "availabilityStatus": "Disponible",
      "workingHours": "Temps partiel",

      // Localisation et contact
      "location": _getFirstLocation(formData['serviceAreas']),
      "phoneNumber": formData['phone'] ?? '',

      // Portfolio vide pour l'instant
      "portfolioItems": [],

      // Documents de vérification
      "verificationDocuments": {
        "isVerified": false
        // Les fichiers seront uploadés séparément
      },

      // Statistiques business
      "totalEarnings": 0,
      "currentProjects": 0,
      "clientSatisfaction": 0,

      // Préférences
      "preferredCategories": [formData['category'] ?? ''],
      "minimumProjectBudget":
          (formData['minimumHourlyRate'] ?? 0) * 2, // Estimation
      "maxProjectsPerMonth": 10,

      // Statut du compte
      "accountStatus": "Pending",
      "subscriptionType": "Free"
    };
  }

  // ✅ CONVERTIR LES ANNÉES D'EXPÉRIENCE EN NIVEAU
  String _convertExperience(dynamic years) {
    final exp = years is int ? years : (int.tryParse(years.toString()) ?? 0);
    if (exp < 2) return 'Débutant';
    if (exp < 5) return 'Intermédiaire';
    return 'Expert';
  }

  // ✅ RÉCUPÉRER LA PREMIÈRE LOCALISATION
  String _getFirstLocation(dynamic serviceAreas) {
    if (serviceAreas is List && serviceAreas.isNotEmpty) {
      return serviceAreas.first.toString();
    }
    return '';
  }
}
