import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sdealsapp/web/data/models/categorie.dart';

import '../models/article.dart';
import '../models/groupe.dart';
import '../models/service.dart';


// http://180.149.197.115:3000/


class ApiClient {
  // URL de production
  // final String baseUrl='http://180.149.197.115:3000/api';
  
  // URL configurable selon la plateforme
  String get baseUrl {
    // Si on est sur le web
    if (kIsWeb) {
      return 'http://localhost:3000/api';
    } 
    // Si on est sur mobile - à remplacer par votre IP locale
    else {
      return 'http://192.168.1.100:3000/api';
    }
  }

  Future<List<Categorie>> fetchCategorie(String nomgroupe) async {
    print('Récupération des catégories pour le groupe: $nomgroupe');
    String idgroupe = "";
    
    try {
      // 1. D'abord, récupérer tous les groupes
      final groupeResponse = await http.get(Uri.parse('$baseUrl/groupe'));
      
      if (groupeResponse.statusCode == 200) {
        // Convertir directement la réponse JSON en liste
        List<dynamic> groupesJson = jsonDecode(groupeResponse.body);
        List<Groupe> groupes = groupesJson.map((json) => Groupe.fromJson(json)).toList();
        
        // Trouver le groupe par son nom
        try {
          Groupe groupe = groupes.firstWhere((g) => g.nomgroupe == nomgroupe);
          idgroupe = groupe.idgroupe;
          print('ID du groupe "$nomgroupe" trouvé: $idgroupe');
        } catch (e) {
          print('Groupe "$nomgroupe" non trouvé: $e');
          return [];
        }
      } else {
        throw Exception('Échec de récupération des groupes: ${groupeResponse.statusCode}');
      }
      
      // 2. Ensuite, récupérer toutes les catégories
      final categorieResponse = await http.get(Uri.parse('$baseUrl/categorie'));
      
      if (categorieResponse.statusCode == 200) {
        List<dynamic> allCategoriesJson = jsonDecode(categorieResponse.body);
        List<Categorie> allCategories = [];
        
        // Traiter chaque catégorie et gérer le cas où 'groupe' est un objet ou une chaîne
        for (var json in allCategoriesJson) {
          try {
            // Si groupe est un objet avec _id (cas populate)
            if (json['groupe'] is Map<String, dynamic>) {
              // Créer une copie du JSON avec groupe remplacé par son ID
              var jsonCopy = Map<String, dynamic>.from(json);
              jsonCopy['groupe'] = json['groupe']['_id'] as String;
              allCategories.add(Categorie.fromJson(jsonCopy));
            } else {
              // Cas standard où groupe est déjà une chaîne
              allCategories.add(Categorie.fromJson(json));
            }
          } catch (e) {
            print('Erreur parsing catégorie: $e pour ${json.toString()}');
          }
        }
        
        // Filtrer les catégories qui appartiennent au groupe demandé
        List<Categorie> filteredCategories = allCategories.where((cat) => cat.groupe == idgroupe).toList();
        print('Catégories trouvées pour le groupe "$nomgroupe": ${filteredCategories.length}');
        
        return filteredCategories;
      } else {
        throw Exception('Échec de récupération des catégories: ${categorieResponse.statusCode}');
      }
    } catch (e) {
      print('Erreur dans fetchCategorie: $e');
      throw Exception('Échec de chargement des catégories: $e');
    }
  }

  // Méthode pour récupérer toutes les catégories sans filtrage (pour débogage)
  Future<List<Categorie>> fetchAllCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categorie'));
      
      if (response.statusCode == 200) {
        List<dynamic> allCategoriesJson = jsonDecode(response.body);
        List<Categorie> allCategories = [];
        
        // Traiter chaque catégorie
        for (var json in allCategoriesJson) {
          try {
            // Si groupe est un objet avec _id (cas populate)
            if (json['groupe'] is Map<String, dynamic>) {
              var jsonCopy = Map<String, dynamic>.from(json);
              jsonCopy['groupe'] = json['groupe']['_id'] as String;
              allCategories.add(Categorie.fromJson(jsonCopy));
            } else {
              allCategories.add(Categorie.fromJson(json));
            }
          } catch (e) {
            print('Erreur parsing catégorie: $e pour ${json.toString()}');
          }
        }
        
        // Log tous les groupes trouvés pour débogage
        Set<String> groupes = allCategories.map((c) => c.groupe).toSet();
        print('Tous les IDs de groupe disponibles: $groupes');
        
        return allCategories;
      } else {
        throw Exception('Échec de récupération des catégories: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur dans fetchAllCategories: $e');
      return [];
    }
  }
  
  Future<List<Service>> fetchService(String categorieid) async {
    print('Récupération des services pour la catégorie: $categorieid');
    
    try {
      final response = await http.get(Uri.parse('$baseUrl/service/$categorieid'));
      
      if (response.statusCode == 200) {
        List<dynamic> servicesJson = jsonDecode(response.body);
        List<Service> services = servicesJson.map((json) => Service.fromJson(json)).toList();
        print('Services récupérés: ${services.length}');
        return services;
      } else {
        throw Exception('Échec de récupération des services: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur dans fetchService: $e');
      throw Exception('Échec de chargement des services: $e');
    }
  }




  Future<List<Article>> fetchArticle() async {
    print('Récupération des articles');
    
    try {
      final response = await http.get(Uri.parse('$baseUrl/articles'));
      
      if (response.statusCode == 200) {
        List<dynamic> articlesJson = jsonDecode(response.body);
        List<Article> articles = articlesJson.map((json) => Article.fromJson(json)).toList();
        print('Articles récupérés: ${articles.length}');
        return articles;
      } else {
        throw Exception('Échec de récupération des articles: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur dans fetchArticle: $e');
      throw Exception('Échec de chargement des articles: $e');
    }
  }
  
  // Méthode utilitaire pour tester la connexion au backend
  Future<bool> testConnexion() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/groupe'));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      print('Erreur de connexion au backend: $e');
      return false;
    }
  }

}



// 180.149.197.115:3000/api/categorie
//https://api.soutralideals.net/api