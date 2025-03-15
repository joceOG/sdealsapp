import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sdealsapp/web/data/models/categorie.dart';

import '../models/article.dart';
import '../models/groupe.dart';
import '../models/service.dart';


// http://180.149.197.115:3000/


class ApiClient {
  final String baseUrl='http://180.149.197.115:3000/api';

  Future<List<Categorie>> fetchCategorie(String nomgroupe) async {
    print('Base Url ' + baseUrl );
    List<Groupe> listgroupe = [] ;
    String idgroupe ="";

    //vérification des groupes

    var requestgroupe = http.MultipartRequest('GET', Uri.parse('$baseUrl/groupe'));
    final http.StreamedResponse responsegroupe = await requestgroupe.send();
    if (responsegroupe.statusCode == 200) {
      var get_groupe_response_string = await responsegroupe.stream.bytesToString();
      var add1 = '{"groupe" : ' ;
      var add2 = '}';
      var get_groupe_response_string_json = add1 + get_groupe_response_string + add2 ;
      //print( 'Cate' + get_categorie_response_string_json );
      List<Groupe> list_groupe = [];
      var tagObjsJson = jsonDecode(get_groupe_response_string_json)['groupe'] as List;
      //print(tagObjsJson);
      // print('DOS') ;
      list_groupe = tagObjsJson.map((tagJson) => Groupe.fromJson(tagJson)).toList();
      listgroupe = list_groupe ;
      Groupe g = listgroupe.firstWhere((listgroupe) => listgroupe.nomgroupe == nomgroupe);
      print("id trouvé " + g.idgroupe);
      idgroupe = '/'+g.idgroupe ;
    }

    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/groupe$idgroupe'));
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       //print(await response.stream.bytesToString());
      var get_categorie_response_string = await response.stream.bytesToString();
      //print('uno') ;
      //print(get_categorie_response_string);
      var add1 = '{"categorie" : ' ;
      var add2 = '}';
      var get_categorie_response_string_json = add1 + get_categorie_response_string + add2 ;
      //print( 'Cate' + get_categorie_response_string_json );
      List<Categorie> list_categorie = [];
      var tagObjsJson = jsonDecode(get_categorie_response_string_json)['categorie'] as List;
      //print(tagObjsJson);
     // print('DOS') ;
      list_categorie = tagObjsJson.map((tagJson) => Categorie.fromJson(tagJson)).toList();
     // print('tres');
     // print('Liste Categorie' + list_categorie.toString() ) ;
      return list_categorie;
    } else {
      throw Exception('Failed to load items');
    }

  }

  Future<List<Service>> fetchService(String categorieid) async {
    print('Base Url ' + baseUrl );

    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/service/$categorieid'));
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      var get_service_response_string = await response.stream.bytesToString();
      print('uno') ;
      //print(get_article_response_string);
      var add1 = '{"service" : ' ;
      var add2 = '}';
      var get_service_response_string_json = add1 + get_service_response_string + add2 ;
      print( 'serv' + get_service_response_string_json );
      List<Service> list_service = [];
      var tagObjsJson = jsonDecode(get_service_response_string_json)['service'] as List;
      //print(tagObjsJson);
      print('DOS') ;
      list_service = tagObjsJson.map((tagJson) => Service.fromJson(tagJson)).toList();
      print('tres');
      print('Liste Service' + list_service.toString() ) ;
      return list_service;
    } else {
      throw Exception('Failed to load items');
    }

  }




  Future<List<Article>> fetchArticle() async {
    print('Base Url' + baseUrl );
    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/articles'));
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      var get_article_response_string = await response.stream.bytesToString();
      print('uno') ;
      //print(get_article_response_string);
      var add1 = '{"article" : ' ;
      var add2 = '}';
      var get_article_response_string_json = add1 + get_article_response_string + add2 ;
      print( 'art' + get_article_response_string_json );
      List<Article> list_article = [];
      var tagObjsJson = jsonDecode(get_article_response_string_json)['article'] as List;
      //print(tagObjsJson);
      print('DOS') ;
      list_article = tagObjsJson.map((tagJson) => Article.fromJson(tagJson)).toList();
      print('tres');
      print('Liste Article' + list_article.toString() ) ;
      return list_article;
    } else {
      throw Exception('Failed to load items');
    }

  }

}



// 180.149.197.115:3000/api/categorie
//https://api.soutralideals.net/api