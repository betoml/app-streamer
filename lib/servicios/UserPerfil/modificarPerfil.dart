import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:euforia/servicios/endpoints.dart';
import 'package:euforia/servicios/secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

void modificarPerfil(nombres, apellidos, telefonos) async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().userUpdate),
    body: {
      "id": localStorage.getString('user_id'),
      "nombres": nombres,
      "apellidos": apellidos,
      "telefonos": telefonos
    },
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );
}
