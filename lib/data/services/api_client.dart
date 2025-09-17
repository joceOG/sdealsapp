import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sdealsapp/data/models/categorie.dart';
import 'package:diacritic/diacritic.dart';
import '../models/article.dart';
import '../models/groupe.dart';
import '../models/service.dart';
import '../models/utilisateur.dart';


// http://180.149.197.115:3000/


class ApiClient {
  // URL de production
  // final String baseUrl='http://180.149.197.115:3000/api';
  // URL configurable selon la plateforme

  var apiUrl = dotenv.env['API_URL'] ;

   Future<List<Categorie>> fetchCategorie(String nomGroupe) async {
     print('Récupération des catégories pour le groupe: $nomGroupe');
     try {
       final response = await http.get(Uri.parse('$apiUrl/categorie'));
       if (response.statusCode == 200) {
         List<dynamic> categoriesJson = jsonDecode(response.body);
         List<Categorie> allCategories = [];
         for (var json in categoriesJson) {
           try {
             // Si 'groupe' est un objet (populate), récupérer l'id et le nom
             if (json['groupe'] is Map<String, dynamic>) {
               var groupeJson = json['groupe'];
               var jsonCopy = Map<String, dynamic>.from(json);
               jsonCopy['groupe'] = {
                 '_id': groupeJson['_id'] as String,
                 'nomgroupe': groupeJson['nomgroupe'] as String
               };
               allCategories.add(Categorie.fromJson(jsonCopy));
             } else {
               // Cas où 'groupe' est déjà un ID ou nom
               allCategories.add(Categorie.fromJson(json));
             }
           } catch (e) {
             print('Erreur parsing catégorie: $e pour ${json.toString()}');
           }
         }

         // Filtrer les catégories par nom de groupe (insensible à casse et accents)
         final filteredCategories = allCategories.where((cat) {
           final groupeNom = removeDiacritics(cat.groupe.nomgroupe.toLowerCase());
           final targetNom = removeDiacritics(nomGroupe.toLowerCase());
           return groupeNom == targetNom;
         }).toList();

         print('Catégories trouvées pour le groupe "$nomGroupe": ${filteredCategories.length}');
         return filteredCategories;
       } else {
         throw Exception('Échec de récupération des catégories: ${response.statusCode}');
       }
     } catch (e) {
       print('Erreur dans fetchCategorie: $e');
       throw Exception('Échec de chargement des catégories: $e');
     }
   }
  // Méthode pour récupérer toutes les catégories sans filtrage (pour débogage)
  Future<List<Categorie>> fetchAllCategories() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/categorie'));
      
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
        Set<Groupe> groupes = allCategories.map((c) => c.groupe).toSet();
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

  Future<List<Service>> fetchServices(String nomGroupe) async {
    print('Récupération des services pour le groupe: $nomGroupe');

    try {
      final response = await http.get(Uri.parse('$apiUrl/service'));

      print('Status code de la réponse: ${response.statusCode}');

      if (response.statusCode == 200) {
        List<dynamic> servicesJson = jsonDecode(response.body);
        print('Nombre total de services reçus: ${servicesJson.length}');

        List<Service> allServices = servicesJson.map((json) {
          try {
            return Service.fromJson(json);
          } catch (e) {
            print('Erreur parsing service: $e pour $json');
            return null;
          }
        }).whereType<Service>().toList(); // filtre les null

        // Afficher les services avec données manquantes pour debug
        for (var s in allServices) {
          if (s.categorie == null ||
              s.categorie?.groupe == null ||
              s.categorie?.groupe.nomgroupe == null) {
            print('Service avec valeur manquante: ${s.nomservice}');
          }
        }

        // Filtrage sûr par groupe
        List<Service> filteredServices = allServices.where((s) {
          final groupeNom = s.categorie?.groupe?.nomgroupe;
          return groupeNom != null &&
              groupeNom.toLowerCase() == nomGroupe.toLowerCase();
        }).toList();

        print('Services filtrés: ${filteredServices.length}');
        return filteredServices;

      } else {
        throw Exception(
            'Échec de récupération des services: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur dans fetchServicesByGroupe: $e');
      throw Exception('Échec de chargement des services: $e');
    }
  }



  Future<List<Article>> fetchArticle() async {
    print('Récupération des articles');
    
    try {
      final response = await http.get(Uri.parse('$apiUrl/articles'));
      
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
      final response = await http.get(Uri.parse('$apiUrl/groupe'));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      print('Erreur de connexion au backend: $e');
      return false;
    }
  }

   Future<Map<String, dynamic>> registerUser({ required String fullName, required String phone, required String password }) async {
     final url = Uri.parse("$apiUrl/register");

     // Découper le fullName en nom et prénom
     final parts = fullName.trim().split(" ");
     final nom = parts.isNotEmpty ? parts.first : "";
     final prenom = parts.length > 1 ? parts.sublist(1).join(" ") : "";

     print("🌍 Appel API: $url");
     print("📤 Données envoyées: { nom: $nom, prenom: $prenom, telephone: $phone, password: ***** }");

     final response = await http.post(
       url,
       headers: {"Content-Type": "application/json"},
       body: jsonEncode({
         "nom": nom,
         "prenom": prenom,
         "telephone": phone,
         "password": password, // 👈 correspond à ton backend
       }),
     );

     print("📥 StatusCode: ${response.statusCode}");
     print("📥 Réponse brute: ${response.body}");

     if (response.statusCode == 200 || response.statusCode == 201) {
       final data = jsonDecode(response.body);
       print("✅ Succès Register: $data");
       return data;
     } else {
       try {
         final error = jsonDecode(response.body);
         print("❌ Erreur API Register: $error");
         throw Exception(error["error"] ?? error["message"] ?? "Erreur d'inscription");
       } catch (e) {
         print("⚠️ Impossible de parser l'erreur: ${response.body}");
         throw Exception("Erreur inconnue (${response.statusCode})");
       }
     }
   }

   Future<Map<String, dynamic>> loginUser({
     required String identifiant,
     required String password,
     bool rememberMe = false,
   }) async {
     try {
       // Vérification locale
       if (identifiant.trim().isEmpty || password.trim().isEmpty) {
         throw Exception("Identifiant et mot de passe requis");
       }

       // Construire le body avec identifiant unique attendu par le backend
       final Map<String, String> body = {
         "identifiant": identifiant.trim(),
         "password": password.trim(),
       };

       final response = await http.post(
         Uri.parse("$apiUrl/login"),
         headers: {"Content-Type": "application/json"},
         body: jsonEncode(body),
       );

       final data = jsonDecode(response.body);

       if (response.statusCode == 200) {
         // Sauvegarde du token si rememberMe activé
         if (rememberMe && data["token"] != null) {
           // Exemple: SharedPreferences
           // final prefs = await SharedPreferences.getInstance();
           // await prefs.setString("token", data["token"]);
         }
         return data; // { utilisateur: {...}, token: "xxx" }
       } else {
         throw Exception(data["error"] ?? "Erreur inconnue lors de la connexion");
       }
     } catch (e) {
       throw Exception("Erreur de connexion: $e");
     }
   }

}

// 180.149.197.115:3000/api/categorie
//https://api.soutralideals.net/api