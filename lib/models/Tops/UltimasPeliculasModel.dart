// To parse this JSON data, do
//
//     final ultimasPeliculasModel = ultimasPeliculasModelFromJson(jsonString);

import 'dart:convert';

List<UltimasPeliculasModel> ultimasPeliculasModelFromJson(String str) =>
    List<UltimasPeliculasModel>.from(
        json.decode(str).map((x) => UltimasPeliculasModel.fromJson(x)));

String ultimasPeliculasModelToJson(List<UltimasPeliculasModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UltimasPeliculasModel {
  UltimasPeliculasModel({
    required this.id,
    required this.idThmdb,
    required this.imgThumb,
    required this.imgPortada,
    required this.url1080,
    required this.url720,
    required this.url480,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String idThmdb;
  final String imgThumb;
  final String imgPortada;
  final String url1080;
  final String url720;
  final String url480;
  final String active;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UltimasPeliculasModel.fromJson(Map<String, dynamic> json) =>
      UltimasPeliculasModel(
        id: json["id"],
        idThmdb: json["id_thmdb"],
        imgThumb: json["img_thumb"],
        imgPortada: json["img_portada"],
        url1080: json["url_1080"],
        url720: json["url_720"],
        url480: json["url_480"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_thmdb": idThmdb,
        "img_thumb": imgThumb,
        "img_portada": imgPortada,
        "url_1080": url1080,
        "url_720": url720,
        "url_480": url480,
        "active": active,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
