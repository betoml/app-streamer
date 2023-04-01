import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/LoginModel.dart';
import 'endpoints.dart';

/* class LoginApi {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = EndPoints().baseUrlApi + EndPoints().login;

    final response = await http.post(url as Uri, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
} */

class TestApi {
  late String email;
  late String passowrd;
}

/* var client = http.Client();

loginEuforia(email, passowrd) async {
  try {
    var response = await http.post(
        Uri.parse('https://euforia.up.railway.app/api/login'),
        body: {'email': email, 'password': passowrd});

    //print(response.body);

    Map<String, dynamic> user = jsonDecode(response.body);

    //return user;
  } finally {
    client.close();
  }
} */
