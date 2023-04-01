import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:euforia/servicios/endpoints.dart';
import 'package:euforia/servicios/secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../models/UsuarioInfo.dart';

Future<UsuarioInfo> getUsuarioInfo() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().userInfo),
    body: {"id": localStorage.getString('user_id')},
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  // print(json.decode(tokens));
  return UsuarioInfo.fromJson(json.decode(response.body));
}
