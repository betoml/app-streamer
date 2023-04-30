// To parse this JSON data, do
//
//     final mensajeModel = mensajeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MensajeModel mensajeModelFromJson(String str) =>
    MensajeModel.fromJson(json.decode(str));

String mensajeModelToJson(MensajeModel data) => json.encode(data.toJson());

class MensajeModel {
  MensajeModel({
    required this.message,
  });

  final String message;

  factory MensajeModel.fromJson(Map<String, dynamic> json) => MensajeModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
