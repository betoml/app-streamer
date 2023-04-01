// To parse this JSON data, do
//
//     final getTemporadasModel = getTemporadasModelFromJson(jsonString);

import 'dart:convert';

List<GetTemporadasModel> getTemporadasModelFromJson(String str) =>
    List<GetTemporadasModel>.from(
        json.decode(str).map((x) => GetTemporadasModel.fromJson(x)));

String getTemporadasModelToJson(List<GetTemporadasModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTemporadasModel {
  GetTemporadasModel({
    required this.temporadas,
  });

  final String temporadas;

  factory GetTemporadasModel.fromJson(Map<String, dynamic> json) =>
      GetTemporadasModel(
        temporadas: json["temporadas"],
      );

  Map<String, dynamic> toJson() => {
        "temporadas": temporadas,
      };
}
