import 'dart:convert';
import 'dart:io';

import 'package:euforia/models/Search/SearchSeriesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/Search/SearchPeliculasModel.dart';
import '../endpoints.dart';

Future<List<SearchSeriesModel>> searchSeries(textSearch) async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().seriesSearch),
    body: {'title': textSearch},
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  // print(json.decode(response.body));

  //print(jsonDecode(response.body));

  return searchSeriesModelFromJson(response.body);
}
