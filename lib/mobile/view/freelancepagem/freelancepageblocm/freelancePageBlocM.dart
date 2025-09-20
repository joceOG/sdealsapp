import 'package:sdealsapp/mobile/view/freelancepagem/freelancepageblocm/freelancePageEventM.dart';
import 'package:sdealsapp/mobile/view/freelancepagem/freelancepageblocm/freelancePageStateM.dart';
import 'package:sdealsapp/mobile/view/freelancepagem/models/freelance_model.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/services/api_client.dart';

class FreelancePageBlocM
    extends Bloc<FreelancePageEventM, FreelancePageStateM> {
  FreelancePageBlocM() : super(FreelancePageStateM.initial()) {
    on<LoadCategorieDataM>(_onLoadCategorieDataM);
    on<LoadFreelancersEvent>(_onLoadFreelancers);
    on<FilterByCategoryEvent>(_onFilterByCategory);
    on<SearchFreelancerEvent>(_onSearchFreelancer);
    on<ClearFiltersEvent>(_onClearFilters);
    on<SubmitFreelanceRegistrationEvent>(_onSubmitFreelanceRegistration);
  }

  Future<void> _onLoadCategorieDataM(
    LoadCategorieDataM event,
    Emitter<FreelancePageStateM> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    ApiClient apiClient = ApiClient();
    try {
      // Revenir à l'ancien nom du groupe qui fonctionne
      var nomgroupe = "Freelance"; // Sans trait d'union
      print("Chargement des catégories pour le groupe: $nomgroupe");
      List<Categorie> list_categorie =
          await apiClient.fetchCategorie(nomgroupe);

      // Charger également les freelancers par défaut
      add(LoadFreelancersEvent());

      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      if (kDebugMode) {
        print("Erreur chargement catégories: $error");
      }
    }
  }

  Future<void> _onLoadFreelancers(
    LoadFreelancersEvent event,
    Emitter<FreelancePageStateM> emit,
  ) async {
    // ✅ MAINTENANT CONNECTÉ AU VRAI BACKEND !
    try {
      ApiClient apiClient = ApiClient();
      print("🚀 Chargement des freelances depuis le backend...");

      final List<Map<String, dynamic>> freelancesData =
          await apiClient.fetchFreelances();

      // Convertir les données backend en FreelanceModel
      final List<FreelanceModel> freelancers = freelancesData
          .map((data) => FreelanceModel.fromBackend(data))
          .toList();

      print("✅ Freelances chargés depuis le backend: ${freelancers.length}");

      emit(state.copyWith(
        freelancers: freelancers,
        filteredFreelancers: freelancers,
      ));
    } catch (error) {
      // ⚠️ Fallback vers les données mock en cas d'erreur
      if (kDebugMode) {
        print("❌ Erreur backend, utilisation des données mock: $error");
      }

      try {
        final List<FreelanceModel> mockFreelancers = getMockFreelancers();
        emit(state.copyWith(
          freelancers: mockFreelancers,
          filteredFreelancers: mockFreelancers,
        ));
        print("🔄 Fallback vers données mock réussi");
      } catch (mockError) {
        if (kDebugMode) {
          print("💥 Erreur critique: $mockError");
        }
        emit(state.copyWith(error: error.toString()));
      }
    }
  }

  void _onFilterByCategory(
    FilterByCategoryEvent event,
    Emitter<FreelancePageStateM> emit,
  ) {
    final category = event.category;

    if (category == null || category == 'Tous') {
      // Si aucune catégorie ou 'Tous' est sélectionnée, montrer tous les freelancers
      emit(state.copyWith(
        selectedCategory: category,
        filteredFreelancers: _applySearch(state.freelancers, state.searchQuery),
      ));
    } else {
      // Filtrer les freelancers par catégorie
      final filtered = state.freelancers
          .where((freelancer) => freelancer.category == category)
          .toList();

      emit(state.copyWith(
        selectedCategory: category,
        filteredFreelancers: _applySearch(filtered, state.searchQuery),
      ));
    }
  }

  void _onSearchFreelancer(
    SearchFreelancerEvent event,
    Emitter<FreelancePageStateM> emit,
  ) {
    final query = event.query.toLowerCase();

    // Appliquer d'abord le filtre de catégorie s'il existe
    List<FreelanceModel> categoryFiltered = state.freelancers;
    if (state.selectedCategory != null && state.selectedCategory != 'Tous') {
      categoryFiltered = state.freelancers
          .where((freelancer) => freelancer.category == state.selectedCategory)
          .toList();
    }

    // Appliquer ensuite la recherche sur les résultats filtrés par catégorie
    final List<FreelanceModel> searchFiltered =
        _applySearch(categoryFiltered, query);

    emit(state.copyWith(
      searchQuery: query,
      filteredFreelancers: searchFiltered,
    ));
  }

  void _onClearFilters(
    ClearFiltersEvent event,
    Emitter<FreelancePageStateM> emit,
  ) {
    emit(state.copyWith(
      selectedCategory: null,
      searchQuery: '',
      filteredFreelancers: state.freelancers,
    ));
  }

  // ✅ NOUVELLE MÉTHODE : Gérer l'inscription freelance
  Future<void> _onSubmitFreelanceRegistration(
    SubmitFreelanceRegistrationEvent event,
    Emitter<FreelancePageStateM> emit,
  ) async {
    emit(state.copyWith(
      isRegistrationLoading: true,
      registrationError: null,
      registrationSuccess: null,
    ));

    print("🚀 Démarrage inscription freelance: ${event.formData.toString()}");

    try {
      final apiUrl = dotenv.env['API_URL'];
      if (apiUrl == null) {
        throw Exception('URL API non configurée');
      }

      // ✅ ÉTAPE 1: Utiliser user existant si présent, sinon créer
      String userId;
      if ((event.formData['existingUserId'] as String?)?.isNotEmpty == true) {
        userId = event.formData['existingUserId'];
        print("✅ Utilisateur existant détecté: $userId (pas de réinscription)");
      } else {
        final userData = _prepareUserDataForFreelance(event.formData);
        print("📤 Création utilisateur pour freelance: $userData");

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

      // ✅ ÉTAPE 2: Créer le freelance avec le nouveau modèle
      final freelanceData = _prepareFreelanceData(event.formData, userId);
      print("📤 Création freelance: $freelanceData");

      final freelanceResponse = await http.post(
        Uri.parse("$apiUrl/freelance"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(freelanceData),
      );

      if (freelanceResponse.statusCode == 201 ||
          freelanceResponse.statusCode == 200) {
        print("✅ Freelance créé avec succès!");

        // Recharger la liste des freelances pour inclure le nouveau
        add(LoadFreelancersEvent());

        emit(state.copyWith(
          isRegistrationLoading: false,
          registrationSuccess:
              "🎉 Inscription freelance réussie ! Bienvenue dans l'équipe Soutrali !",
        ));
      } else {
        final errorData = jsonDecode(freelanceResponse.body);
        print("❌ Erreur création freelance: ${freelanceResponse.body}");
        emit(state.copyWith(
          isRegistrationLoading: false,
          registrationError:
              "Erreur création freelance: ${errorData['error'] ?? freelanceResponse.body}",
        ));
      }
    } catch (e) {
      print("💥 Erreur inscription freelance: $e");
      emit(state.copyWith(
        isRegistrationLoading: false,
        registrationError: "Erreur d'inscription: $e",
      ));
    }
  }

  // ✅ PRÉPARATION DES DONNÉES UTILISATEUR POUR FREELANCE
  Map<String, dynamic> _prepareUserDataForFreelance(
      Map<String, dynamic> formData) {
    // Récupérer les données personnelles
    final fullName = formData['fullName'] as String? ?? '';
    final nameParts = fullName.trim().split(' ');
    final nom = nameParts.isNotEmpty ? nameParts.first : '';
    final prenom = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return {
      "nom": nom,
      "prenom": prenom,
      "telephone": formData['phone'] ?? '',
      "email": formData['email'] ?? '',
      "password":
          formData['password'] ?? 'freelance123', // Mot de passe par défaut
      "genre": formData['gender'] ?? 'Homme',
    };
  }

  // ✅ PRÉPARATION DES DONNÉES FREELANCE (MODÈLE UNIFIÉ)
  Map<String, dynamic> _prepareFreelanceData(
      Map<String, dynamic> formData, String userId) {
    // Convertir les catégories sélectionnées
    final selectedCategories =
        formData['selectedCategories'] as Set<String>? ?? {};
    final mainCategory =
        selectedCategories.isNotEmpty ? selectedCategories.first : 'Autre';

    // Compétences depuis les étapes du formulaire
    final skills = <String>[];
    if (formData['skills'] != null) {
      skills.addAll(List<String>.from(formData['skills']));
    }
    if (formData['selectedServices'] != null) {
      final services = formData['selectedServices'] as Set<String>? ?? {};
      skills.addAll(services);
    }

    return {
      // Champs de base
      "utilisateur": userId,
      "name": formData['fullName'] ?? '',
      "job": mainCategory,
      "category": mainCategory,

      // Image de profil
      "imagePath": formData['profileImagePath'] ?? '',

      // Système de performance
      "rating": 0,
      "completedJobs": 0,
      "isTopRated": false,
      "isFeatured": false,
      "isNew": true,
      "responseTime": 24,

      // Compétences et tarification
      "skills": skills,
      "hourlyRate": formData['hourlyRate'] ?? formData['minimumRate'] ?? 0,
      "description": formData['description'] ?? formData['bio'] ?? '',

      // Informations professionnelles
      "experienceLevel": _convertExperienceLevel(formData['experienceLevel']),
      "availabilityStatus": _convertAvailability(formData['availability']),
      "workingHours": formData['workingHours'] ?? 'Temps partiel',

      // Localisation et contact
      "location": formData['location'] ?? '',
      "phoneNumber": formData['phone'] ?? '',

      // Portfolio (sera rempli plus tard)
      "portfolioItems": _preparePortfolioItems(formData),

      // Documents de vérification
      "verificationDocuments": {
        "isVerified": false,
        "cni1": formData['cniImagePath'],
        "selfie": formData['selfieImagePath'],
      },

      // Statistiques business
      "totalEarnings": 0,
      "currentProjects": 0,
      "clientSatisfaction": 0,

      // Préférences
      "preferredCategories": selectedCategories.toList(),
      "minimumProjectBudget":
          (formData['hourlyRate'] ?? 0) * 8, // Estimation 1 jour
      "maxProjectsPerMonth": formData['maxProjectsPerMonth'] ?? 5,

      // Statut du compte
      "accountStatus": "Pending",
      "subscriptionType": "Free"
    };
  }

  // ✅ CONVERTIR LE NIVEAU D'EXPÉRIENCE
  String _convertExperienceLevel(dynamic experience) {
    if (experience == null) return 'Débutant';
    final exp = experience.toString().toLowerCase();
    if (exp.contains('expert') || exp.contains('senior')) return 'Expert';
    if (exp.contains('intermédiaire') || exp.contains('intermediate'))
      return 'Intermédiaire';
    return 'Débutant';
  }

  // ✅ CONVERTIR LA DISPONIBILITÉ
  String _convertAvailability(dynamic availability) {
    if (availability == null) return 'Disponible';
    final avail = availability.toString().toLowerCase();
    if (avail.contains('temps plein') || avail.contains('full'))
      return 'Temps plein';
    if (avail.contains('occupé') || avail.contains('busy')) return 'Occupé';
    return 'Disponible';
  }

  // ✅ PRÉPARER LES ÉLÉMENTS DU PORTFOLIO
  List<Map<String, dynamic>> _preparePortfolioItems(
      Map<String, dynamic> formData) {
    final portfolioItems = <Map<String, dynamic>>[];

    // Récupérer les projets du portfolio si disponibles
    if (formData['portfolioProjects'] != null) {
      final projects = formData['portfolioProjects'] as List?;
      for (var project in projects ?? []) {
        if (project is Map<String, dynamic>) {
          portfolioItems.add({
            'title': project['title'] ?? '',
            'description': project['description'] ?? '',
            'imageUrl': project['imageUrl'] ?? '',
            'projectUrl': project['projectUrl'] ?? '',
            'technologies': project['technologies'] ?? [],
          });
        }
      }
    }

    return portfolioItems;
  }

  // Méthode utilitaire pour appliquer la recherche
  List<FreelanceModel> _applySearch(
      List<FreelanceModel> freelancers, String query) {
    if (query.isEmpty) {
      return freelancers;
    }

    return freelancers.where((freelancer) {
      return freelancer.name.toLowerCase().contains(query) ||
          freelancer.job.toLowerCase().contains(query) ||
          freelancer.description.toLowerCase().contains(query) ||
          freelancer.skills.any((skill) => skill.toLowerCase().contains(query));
    }).toList();
  }
}
