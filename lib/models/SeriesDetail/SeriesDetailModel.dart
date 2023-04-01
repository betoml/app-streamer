// To parse this JSON data, do
//
//     final seriesDetailModel = seriesDetailModelFromJson(jsonString);

import 'dart:convert';

SeriesDetailModel seriesDetailModelFromJson(String str) =>
    SeriesDetailModel.fromJson(json.decode(str));

String seriesDetailModelToJson(SeriesDetailModel data) =>
    json.encode(data.toJson());

class SeriesDetailModel {
  SeriesDetailModel({
    required this.imgPortadaSeries,
    required this.tituloSeries,
    required this.descripcionSeries,
    required this.temporadas,
    required this.genero1,
    required this.genero2,
    required this.genero3,
  });

  final String imgPortadaSeries;
  final String tituloSeries;
  final String descripcionSeries;
  final int temporadas;
  final String genero1;
  final String genero2;
  final String genero3;

  factory SeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      SeriesDetailModel(
        imgPortadaSeries: json["img_portada_series"],
        tituloSeries: json["titulo_series"],
        descripcionSeries: json["descripcion_series"],
        temporadas: json["temporadas"],
        genero1: json["genero1"],
        genero2: json["genero2"],
        genero3: json["genero3"],
      );

  Map<String, dynamic> toJson() => {
        "img_portada_series": imgPortadaSeries,
        "titulo_series": tituloSeries,
        "descripcion_series": descripcionSeries,
        "temporadas": temporadas,
        "genero1": genero1,
        "genero2": genero2,
        "genero3": genero3,
      };
}
