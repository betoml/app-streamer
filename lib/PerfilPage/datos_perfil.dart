import 'package:euforia/models/UsuarioInfo.dart';

import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import '../servicios/UserInfoServices.dart';

import '../widgetsGlobales/preload.dart';

class DatosPerfil extends StatefulWidget {
  const DatosPerfil({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DatosPerfilState createState() => _DatosPerfilState();
}

class _DatosPerfilState extends State<DatosPerfil> {
  late Future<UsuarioInfo> setUsuarioinfo;

// ignore: non_constant_identifier_names

  @override
  void initState() {
    super.initState();

    setUsuarioinfo = getUsuarioInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: setUsuarioinfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Preload(),
              );
            } else {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: 120.0,
                        child: Image.asset('assets/user-icon.png'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          snapshot.data!.nombresUsers,
                          style: const TextStyle(
                              fontSize: 20.0, color: textPrimary),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            snapshot.data!.apellidos,
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: textPrimary,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.person_2, color: textPrimary),
                        Text(
                          snapshot.data!.username,
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: textPrimary,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.email, color: textPrimary, size: 16.0),
                        Text(
                          snapshot.data!.email,
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: textPrimary,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          snapshot.data!.nombrePlan,
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: bgPrimary,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 15),
                    content: Text(
                        'Se ha cerrado la sesión, otro usuario ha entrado y se ha superado el limite de conexiones de su plan')));
                Navigator.pushNamed(context, '/');
                return const Text('Datos no cargados');
              }
            }
          },
        ),
      ],
    );
  }
}
