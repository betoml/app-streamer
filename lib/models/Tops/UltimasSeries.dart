// To parse this JSON data, do
//
//     final ultimasSeriesModel = ultimasSeriesModelFromJson(jsonString);

import 'dart:convert';

List<UltimasSeriesModel> ultimasSeriesModelFromJson(String str) =>
    List<UltimasSeriesModel>.from(
        json.decode(str).map((x) => UltimasSeriesModel.fromJson(x)));

String ultimasSeriesModelToJson(List<UltimasSeriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UltimasSeriesModel {
  UltimasSeriesModel({
    required this.id,
    required this.imgThumbSeries,
    required this.imgPortadaSeries,
    required this.idThmdbSeries,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String imgThumbSeries;
  final String imgPortadaSeries;
  final String idThmdbSeries;
  final String active;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UltimasSeriesModel.fromJson(Map<String, dynamic> json) =>
      UltimasSeriesModel(
        id: json["id"],
        imgThumbSeries: json["img_thumb_series"],
        imgPortadaSeries: json["img_portada_series"],
        idThmdbSeries: json["id_thmdb_series"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img_thumb_series": imgThumbSeries,
        "img_portada_series": imgPortadaSeries,
        "id_thmdb_series": idThmdbSeries,
        "active": active,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
