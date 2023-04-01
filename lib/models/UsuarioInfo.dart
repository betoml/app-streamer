// To parse this JSON data, do
//
//     final usuarioInfo = usuarioInfoFromJson(jsonString);

import 'dart:convert';

UsuarioInfo usuarioInfoFromJson(String str) =>
    UsuarioInfo.fromJson(json.decode(str));

String usuarioInfoToJson(UsuarioInfo data) => json.encode(data.toJson());

class UsuarioInfo {
  UsuarioInfo({
    required this.id,
    required this.nombresUsers,
    required this.apellidos,
    required this.username,
    required this.email,
    required this.admin,
    required this.telefonos,
    required this.planesId,
    required this.nombrePlan,
    required this.vencimientoPlan,
  });

  final String id;
  final String nombresUsers;
  final String apellidos;
  final String username;
  final String email;
  final String admin;
  final String telefonos;
  final String planesId;
  final String nombrePlan;
  final DateTime vencimientoPlan;

  factory UsuarioInfo.fromJson(Map<String, dynamic> json) => UsuarioInfo(
        id: json["id"],
        nombresUsers: json["nombres_users"],
        apellidos: json["apellidos"],
        username: json["username"],
        email: json["email"],
        admin: json["admin"],
        telefonos: json["telefonos"],
        planesId: json["planes_id"],
        nombrePlan: json["nombre_plan"],
        vencimientoPlan: DateTime.parse(json["vencimiento_plan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres_users": nombresUsers,
        "apellidos": apellidos,
        "username": username,
        "email": email,
        "admin": admin,
        "telefonos": telefonos,
        "planes_id": planesId,
        "nombre_plan": nombrePlan,
        "vencimiento_plan":
            "${vencimientoPlan.year.toString().padLeft(4, '0')}-${vencimientoPlan.month.toString().padLeft(2, '0')}-${vencimientoPlan.day.toString().padLeft(2, '0')}",
      };
}
