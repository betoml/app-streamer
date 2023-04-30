import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../endpoints.dart';
import '../mensajeModel.dart';
import 'package:http/http.dart' as http;

Future<MensajeModel> obtenerToken() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final usr = localStorage.getString('user_id');
  final response = await http.post(
    Uri.parse(
        '${EndPoints().baseUrlApi}${EndPoints().obtenerToken}?id_users=$usr'),
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );
  print(localStorage.getString('user_id'));
  print(json.decode(response.body));

  return mensajeModelFromJson(response.body);
}
