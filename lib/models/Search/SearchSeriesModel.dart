// To parse this JSON data, do
//
//     final searchSeriesModel = searchSeriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SearchSeriesModel> searchSeriesModelFromJson(String str) =>
    List<SearchSeriesModel>.from(
        json.decode(str).map((x) => SearchSeriesModel.fromJson(x)));

String searchSeriesModelToJson(List<SearchSeriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchSeriesModel {
  SearchSeriesModel({
    required this.idThmdbSeries,
    required this.imgThumbSeries,
  });

  final String idThmdbSeries;
  final String imgThumbSeries;

  factory SearchSeriesModel.fromJson(Map<String, dynamic> json) =>
      SearchSeriesModel(
        idThmdbSeries: json["id_thmdb_series"],
        imgThumbSeries: json["img_thumb_series"],
      );

  Map<String, dynamic> toJson() => {
        "id_thmdb_series": idThmdbSeries,
        "img_thumb_series": imgThumbSeries,
      };
}
