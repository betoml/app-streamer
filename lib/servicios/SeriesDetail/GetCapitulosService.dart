import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/SeriesDetail/getCapitulosModel.dart';
import '../endpoints.dart';

Stream<List<GetCapitulosModel>> getCapitulosTemp() async* {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;

  if (localStorage.getString('temporada') != null) {
    final response = await http.post(
      Uri.parse(EndPoints().baseUrlApi + EndPoints().getCapitulos),
      body: {
        'id_serie_tmdb': localStorage.getString('series_id'),
        'temporada': localStorage.getString('temporada')
      },
      headers: {
        'Accept': 'application/json, charset: utf-8',
        HttpHeaders.authorizationHeader:
            'Bearer ${localStorage.getString('token')}'
      },
    );

    // print(getCapitulosModelFromJson(capitulos[0]));
    yield getCapitulosModelFromJson(response.body);
  }
}
