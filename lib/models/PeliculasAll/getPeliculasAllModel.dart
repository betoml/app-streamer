// To parse this JSON data, do
//
//     final getPeliculasAllModel = getPeliculasAllModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetPeliculasAllModel> getPeliculasAllModelFromJson(String str) =>
    List<GetPeliculasAllModel>.from(
        json.decode(str).map((x) => GetPeliculasAllModel.fromJson(x)));

String getPeliculasAllModelToJson(List<GetPeliculasAllModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPeliculasAllModel {
  GetPeliculasAllModel({
    required this.idMovie,
    required this.imgPortada,
  });

  final String idMovie;
  final String imgPortada;

  factory GetPeliculasAllModel.fromJson(Map<String, dynamic> json) =>
      GetPeliculasAllModel(
        idMovie: json["id_movie"],
        imgPortada: json["img_portada"],
      );

  Map<String, dynamic> toJson() => {
        "id_movie": idMovie,
        "img_portada": imgPortada,
      };
}
