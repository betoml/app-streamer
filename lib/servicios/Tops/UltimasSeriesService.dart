import 'dart:convert';
import 'dart:io';

import 'package:euforia/models/Tops/UltimasSeries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../endpoints.dart';
import 'package:http/http.dart' as http;

Future<List<UltimasSeriesModel>> getUltimasSeries() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().ultimasSeries),
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  //print(json.decode(response.body));

  return ultimasSeriesModelFromJson(response.body);
}
