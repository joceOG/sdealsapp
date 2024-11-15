import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sdealsapp/web/data/models/categorie.dart';

import '../models/groupe.dart';
import '../models/service.dart';

class ApiClient {
  final String baseUrl='http://180.149.197.115:3000/api';
  Future<List<Categorie>> fetchCategorie() async {
    print('Base Url' + baseUrl );
    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/categorie'));
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       //print(await response.stream.bytesToString());
      var get_categorie_response_string = await response.stream.bytesToString();
      print('uno') ;
      //print(get_categorie_response_string);
      var add1 = '{"categorie" : ' ;
      var add2 = '}';
      var get_categorie_response_string_json = add1 + get_categorie_response_string + add2 ;
     // print(get_categorie_response_string_json );
      List<Categorie> list_categorie = [];
      var tagObjsJson = jsonDecode(get_categorie_response_string_json)['categorie'] as List;
      //   print(tagObjsJson);
      list_categorie = tagObjsJson.map((tagJson) => Categorie.fromJson(tagJson)).toList();
      print('Liste Categorie' + list_categorie.toString() ) ;

      return list_categorie;
    } else {
      throw Exception('Failed to load items');
    }

  }

}

// 180.149.197.115:3000/api/categorie
//https://api.soutralideals.net/api