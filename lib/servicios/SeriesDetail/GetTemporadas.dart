import 'dart:convert';
import 'dart:io';
import 'package:euforia/models/SeriesDetail/getTemporadasModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../endpoints.dart';

Future<String> getTemporadas() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().seriesTemporadas),
    body: {'id_thmdb_series': localStorage.getString('series_id')},
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );
  print(getTemporadasModelFromJson(response.body));
  return response.body;
}
