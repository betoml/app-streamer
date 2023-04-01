// To parse this JSON data, do
//
//     final getCapitulosModel = getCapitulosModelFromJson(jsonString);

import 'dart:convert';

List<GetCapitulosModel> getCapitulosModelFromJson(String str) =>
    List<GetCapitulosModel>.from(
        json.decode(str).map((x) => GetCapitulosModel.fromJson(x)));

String getCapitulosModelToJson(List<GetCapitulosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCapitulosModel {
  GetCapitulosModel({
    required this.id,
    required this.idTemporadasSeries,
    required this.idThmdbSeries,
    required this.episodios,
    required this.titulo,
    required this.descripcion,
    required this.miniatura,
    required this.url1080S,
    required this.url720S,
    required this.url480S,
  });

  final int id;
  final int idTemporadasSeries;
  final int idThmdbSeries;
  final String episodios;
  final String titulo;
  final String descripcion;
  final String miniatura;
  final String url1080S;
  final String url720S;
  final String url480S;

  factory GetCapitulosModel.fromJson(Map<String, dynamic> json) =>
      GetCapitulosModel(
        id: json["id"],
        idTemporadasSeries: json["id_temporadas_series"],
        idThmdbSeries: json["id_thmdb_series"],
        episodios: json["episodios"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        miniatura: json["miniatura"],
        url1080S: json["url_1080_s"],
        url720S: json["url_720_s"],
        url480S: json["url_480_s"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_temporadas_series": idTemporadasSeries,
        "id_thmdb_series": idThmdbSeries,
        "episodios": episodios,
        "titulo": titulo,
        "descripcion": descripcion,
        "miniatura": miniatura,
        "url_1080_s": url1080S,
        "url_720_s": url720S,
        "url_480_s": url480S,
      };
}
