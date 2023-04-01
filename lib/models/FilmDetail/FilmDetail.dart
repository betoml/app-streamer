// To parse this JSON data, do
//
//     final peliculasDetailModel = peliculasDetailModelFromJson(jsonString);

import 'dart:convert';

PeliculasDetailModel peliculasDetailModelFromJson(String str) =>
    PeliculasDetailModel.fromJson(json.decode(str));

String peliculasDetailModelToJson(PeliculasDetailModel data) =>
    json.encode(data.toJson());

class PeliculasDetailModel {
  PeliculasDetailModel({
    required this.imgPortada,
    required this.titulo,
    required this.descripcion,
    required this.duracion,
    required this.genero1,
    required this.genero2,
    required this.genero3,
    required this.url1080,
    required this.url720,
    required this.url480,
  });

  final String imgPortada;
  final String titulo;
  final String descripcion;
  final int duracion;
  final String genero1;
  final String genero2;
  final String genero3;
  final String url1080;
  final String url720;
  final String url480;

  factory PeliculasDetailModel.fromJson(Map<String, dynamic> json) =>
      PeliculasDetailModel(
        imgPortada: json["img_portada"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        duracion: json["duracion"],
        genero1: json["genero1"],
        genero2: json["genero2"],
        genero3: json["genero3"],
        url1080: json["url_1080"],
        url720: json["url_720"],
        url480: json["url_480"],
      );

  Map<String, dynamic> toJson() => {
        "img_portada": imgPortada,
        "titulo": titulo,
        "descripcion": descripcion,
        "duracion": duracion,
        "genero1": genero1,
        "genero2": genero2,
        "genero3": genero3,
        "url_1080": url1080,
        "url_720": url720,
        "url_480": url480,
      };
}
