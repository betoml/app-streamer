// To parse this JSON data, do
//
//     final getSeriesAllModel = getSeriesAllModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetSeriesAllModel> getSeriesAllModelFromJson(String str) =>
    List<GetSeriesAllModel>.from(
        json.decode(str).map((x) => GetSeriesAllModel.fromJson(x)));

String getSeriesAllModelToJson(List<GetSeriesAllModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSeriesAllModel {
  GetSeriesAllModel({
    required this.idMovie,
    required this.imgPortada,
  });

  final String idMovie;
  final String imgPortada;

  factory GetSeriesAllModel.fromJson(Map<String, dynamic> json) =>
      GetSeriesAllModel(
        idMovie: json["id_movie"],
        imgPortada: json["img_portada"],
      );

  Map<String, dynamic> toJson() => {
        "id_movie": idMovie,
        "img_portada": imgPortada,
      };
}
