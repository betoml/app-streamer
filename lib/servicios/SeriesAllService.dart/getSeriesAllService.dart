import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:euforia/models/SeriesAll/SeriesAllModel.dart';
import 'package:euforia/servicios/endpoints.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

Future<List<GetSeriesAllModel>> getSeriesAllService() async {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();
  final SharedPreferences localStorage = await _localStorage;
  final response = await http.post(
    Uri.parse(EndPoints().baseUrlApi + EndPoints().seriesAll),
    headers: {
      'Accept': 'application/json, charset: utf-8',
      HttpHeaders.authorizationHeader:
          'Bearer ${localStorage.getString('token')}'
    },
  );

  // print(json.decode(response.body));

  //print(jsonDecode(response.body));

  return getSeriesAllModelFromJson(response.body);
}
