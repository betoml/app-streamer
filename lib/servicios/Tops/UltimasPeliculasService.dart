import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:euforia/servicios/endpoints.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Tops/UltimasPeliculasModel.dart';

Future<List<UltimasPeliculasModel>> getUltimasPeliculas() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().ultimasPelis),
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  // print(json.decode(response.body));

  return ultimasPeliculasModelFromJson(response.body);
}
