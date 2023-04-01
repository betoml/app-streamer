// To parse this JSON data, do
//
//     final getFavoritosAll = getFavoritosAllFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetFavoritosAll> getFavoritosAllFromJson(String str) =>
    List<GetFavoritosAll>.from(
        json.decode(str).map((x) => GetFavoritosAll.fromJson(x)));

String getFavoritosAllToJson(List<GetFavoritosAll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFavoritosAll {
  GetFavoritosAll({
    required this.idThmdb,
    required this.imgThumb,
  });

  final String idThmdb;
  final String imgThumb;

  factory GetFavoritosAll.fromJson(Map<String, dynamic> json) =>
      GetFavoritosAll(
        idThmdb: json["id_thmdb"],
        imgThumb: json["img_thumb"],
      );

  Map<String, dynamic> toJson() => {
        "id_thmdb": idThmdb,
        "img_thumb": imgThumb,
      };
}
