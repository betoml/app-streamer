// To parse this JSON data, do
//
//     final btnFavoritoStateModel = btnFavoritoStateModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BtnFavoritoStateModel btnFavoritoStateModelFromJson(String str) =>
    BtnFavoritoStateModel.fromJson(json.decode(str));

String btnFavoritoStateModelToJson(BtnFavoritoStateModel data) =>
    json.encode(data.toJson());

class BtnFavoritoStateModel {
  BtnFavoritoStateModel({
    required this.message,
  });

  final bool message;

  factory BtnFavoritoStateModel.fromJson(Map<String, dynamic> json) =>
      BtnFavoritoStateModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
