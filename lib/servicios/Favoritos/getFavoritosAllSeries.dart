import 'dart:io';

import 'package:euforia/models/Favoritos/getFavoritosAll.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Favoritos/getFavoritosAllSeriesModel.dart';
import '../endpoints.dart';
import 'package:http/http.dart' as http;

Future<List<GetFavoritosAllSeries>> getFavoritosAllSeries() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().seriesFavoritos),
    body: {'users_id': localStorage.getString('user_id')},
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  // print(json.decode(response.body));

  return getFavoritosAllSeriesFromJson(response.body);
}
