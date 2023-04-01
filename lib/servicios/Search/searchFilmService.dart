import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/Search/SearchPeliculasModel.dart';
import '../endpoints.dart';

Future<List<SearchPeliculasModel>> searchFilm(textSearch) async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().peliculasSearch),
    body: {'title': textSearch},
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  // print(json.decode(response.body));

  //print(jsonDecode(response.body));

  return searchPeliculasModelFromJson(response.body);
}
