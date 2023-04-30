import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:euforia/servicios/endpoints.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/FilmDetail/FilmDetail.dart';

Future<PeliculasDetailModel> getPeliculasDetail() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().peliculasDetalle),
    body: {'id_thmdb': localStorage.getString('peliculas_id')},
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  // print(json.decode(response.body));

  // print(jsonDecode(response.body));

  return peliculasDetailModelFromJson(response.body);
}
