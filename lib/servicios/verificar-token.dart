import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'endpoints.dart';

Future verificarToken() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;

  var headers = {'Authorization': 'Bearer ${localStorage.get('token')}'};
  var request = http.Request(
      'POST', Uri.parse(EndPoints().baseUrlApi + EndPoints().verificarToken));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // ignore: use_build_context_synchronously
    //Navigator.pushNamed(context, '/home');
  } else {
    // ignore: use_build_context_synchronously

    VerificarToken();

    localStorage.remove('token');
  }
}

class VerificarToken extends StatefulWidget {
  @override
  _VerificarTokenState createState() => _VerificarTokenState();
}

class _VerificarTokenState extends State<VerificarToken> {
  @override
  Widget build(BuildContext context) {
    Navigator.pushNamed(context, '/');
    return SizedBox();
  }
}
