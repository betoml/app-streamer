import 'package:euforia/PerfilPage/btn_perfil.dart';

import 'package:flutter/material.dart';
import 'package:euforia/settings/settings.dart';

import 'datos_perfil.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [bgSecondary_2, bgSecondary],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          stops: [0.2, 0.8],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [DatosPerfil(), BtnPerfil()],
      ),
    );
  }
}
