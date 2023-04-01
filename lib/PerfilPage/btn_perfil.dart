import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:euforia/PerfilPage/PerfilPage.dart';
import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/UsuarioInfo.dart';
import '../servicios/UserInfoServices.dart';
import '../servicios/UserPerfil/modificarPerfil.dart';
import '../servicios/endpoints.dart';

class BtnPerfil extends StatefulWidget {
  const BtnPerfil({Key? key}) : super(key: key);

  @override
  State<BtnPerfil> createState() => _BtnPerfilState();
}

class _BtnPerfilState extends State<BtnPerfil> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(7, 6, 6, 0.082),
                Color.fromRGBO(6, 6, 6, 0.082),
              ],
              begin: FractionalOffset.center,
              end: FractionalOffset.bottomCenter,
              stops: [0.01, 0.9],
            ),
            borderRadius: BorderRadius.circular(20),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  blurRadius: 12.0,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.outer,
                  offset: Offset.zero)
            ]
            // ignore: prefer_const_literals_to_create_immutables
            ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50.0),
                      alignment: Alignment.center,
                      backgroundColor: bgSecondary,
                      foregroundColor: textPrimary),
                  onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const EditarPerfil(),
                      ),
                  icon: const Icon(
                    Icons.person,
                    size: 25.0,
                  ),
                  label: const Text(
                    'EDITAR PERFIL',
                    style: TextStyle(fontSize: 15.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50.0),
                      alignment: Alignment.center,
                      backgroundColor: bgSecondary,
                      foregroundColor: textPrimary),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.lock,
                    size: 25.0,
                  ),
                  label: const Text(
                    'CAMBIAR CONTRASEÑA',
                    style: TextStyle(fontSize: 15.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50.0),
                      alignment: Alignment.center,
                      backgroundColor: bgSecondary,
                      foregroundColor: textPrimary),
                  onPressed: () async {
                    final Future<SharedPreferences> _localStorage =
                        SharedPreferences.getInstance();
                    final SharedPreferences localStorage = await _localStorage;
                    final response = await http.post(
                      Uri.parse(EndPoints().baseUrlApi + EndPoints().logout),
                      body: {"token": localStorage.getString('token')},
                      headers: {
                        'Accept': 'application/json, charset: utf-8',
                        HttpHeaders.authorizationHeader:
                            'Bearer ${localStorage.getString('token')}'
                      },
                    );
                    //   print(json.decode(response.body));
                    localStorage.remove('token');
                    localStorage.remove('user_id');

                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, '/');
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 25.0,
                  ),
                  label: const Text(
                    'SALIR',
                    style: TextStyle(fontSize: 15.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({
    super.key,
  });

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final celular = TextEditingController();
  final email = TextEditingController();
  final vencimiento = TextEditingController();

  late Future<UsuarioInfo> getUserInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo = getUsuarioInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: bgSecondary_4),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: textPrimary),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  FutureBuilder(
                    future: getUserInfo,
                    builder: (context, snapshot) {
                      final datosUsuarios = snapshot.data;

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        if (datosUsuarios == null) {
                          return CircularProgressIndicator();
                        } else {
                          nombres.text = datosUsuarios.nombresUsers;
                          apellidos.text = datosUsuarios.apellidos;
                          celular.text = datosUsuarios.telefonos;
                          ;
                          email.text = datosUsuarios.email;
                          final String venc =
                              '${datosUsuarios.vencimientoPlan.day}/${datosUsuarios.vencimientoPlan.month}/${datosUsuarios.vencimientoPlan.year}';
                          vencimiento.text = venc.toString();

                          return Column(
                            children: [
                              TextField(
                                controller: nombres,
                                style: const TextStyle(
                                    color: textPrimary, fontSize: bodySize_1),
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.person,
                                    color: bgPrimary,
                                    size: 20.0,
                                  ),
                                  labelText: 'Nombre(s)',
                                  labelStyle: TextStyle(color: textPrimary),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary, width: 2.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary_2, width: 2.0),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: apellidos,
                                style: const TextStyle(
                                    color: textPrimary, fontSize: bodySize_1),
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.person,
                                    color: bgPrimary,
                                    size: 20.0,
                                  ),
                                  labelText: 'Apellido(s)',
                                  labelStyle: TextStyle(color: textPrimary),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary, width: 2.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary_2, width: 2.0),
                                  ),
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: celular,
                                style: const TextStyle(
                                    color: textPrimary, fontSize: bodySize_1),
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.phone,
                                    color: bgPrimary,
                                    size: 20.0,
                                  ),
                                  labelText: 'Celular',
                                  labelStyle: TextStyle(color: textPrimary),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary, width: 2.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary_2, width: 2.0),
                                  ),
                                ),
                              ),
                              TextField(
                                readOnly: true,
                                controller: email,
                                style: const TextStyle(
                                    color: textPrimary, fontSize: bodySize_1),
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.email,
                                    color: bgPrimary,
                                    size: 20.0,
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: textPrimary),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary, width: 2.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary_2, width: 2.0),
                                  ),
                                ),
                              ),
                              TextField(
                                readOnly: true,
                                controller: vencimiento,
                                style: const TextStyle(
                                    color: textPrimary, fontSize: bodySize_1),
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: bgPrimary,
                                    size: 20.0,
                                  ),
                                  labelText: 'Expiración del Plan',
                                  labelStyle: TextStyle(color: textPrimary),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary, width: 2.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: bgPrimary_2, width: 2.0),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      modificarPerfil(nombres.text.toString(),
                          apellidos.text.toString(), celular.text.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 10),
                          backgroundColor: bgPrimary,
                          content: Text(
                              'Cambios realizados, por favor, para ver los cambios vuelva atras y recargue la pantalla')));
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'SALVAR CAMBIOS',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                        backgroundColor: bgPrimary,
                        foregroundColor: textPrimary,
                        minimumSize: const Size(double.infinity, 50.0)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
