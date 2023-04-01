// To parse this JSON data, do
//
//     final searchPeliculasModel = searchPeliculasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SearchPeliculasModel> searchPeliculasModelFromJson(String str) =>
    List<SearchPeliculasModel>.from(
        json.decode(str).map((x) => SearchPeliculasModel.fromJson(x)));

String searchPeliculasModelToJson(List<SearchPeliculasModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchPeliculasModel {
  SearchPeliculasModel({
    required this.idThmdb,
    required this.imgThumb,
  });

  final String idThmdb;
  final String imgThumb;

  factory SearchPeliculasModel.fromJson(Map<String, dynamic> json) =>
      SearchPeliculasModel(
        idThmdb: json["id_thmdb"],
        imgThumb: json["img_thumb"],
      );

  Map<String, dynamic> toJson() => {
        "id_thmdb": idThmdb,
        "img_thumb": imgThumb,
      };
}
