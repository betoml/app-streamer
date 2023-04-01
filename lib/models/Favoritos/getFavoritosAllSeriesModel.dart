// To parse this JSON data, do
//
//     final getFavoritosAllSeries = getFavoritosAllSeriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetFavoritosAllSeries> getFavoritosAllSeriesFromJson(String str) =>
    List<GetFavoritosAllSeries>.from(
        json.decode(str).map((x) => GetFavoritosAllSeries.fromJson(x)));

String getFavoritosAllSeriesToJson(List<GetFavoritosAllSeries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFavoritosAllSeries {
  GetFavoritosAllSeries({
    required this.idThmdbSeries,
    required this.imgThumbSeries,
  });

  final String idThmdbSeries;
  final String imgThumbSeries;

  factory GetFavoritosAllSeries.fromJson(Map<String, dynamic> json) =>
      GetFavoritosAllSeries(
        idThmdbSeries: json["id_thmdb_series"],
        imgThumbSeries: json["img_thumb_series"],
      );

  Map<String, dynamic> toJson() => {
        "id_thmdb_series": idThmdbSeries,
        "img_thumb_series": imgThumbSeries,
      };
}
