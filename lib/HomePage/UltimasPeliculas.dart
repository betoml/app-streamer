import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:euforia/models/Tops/UltimasPeliculasModel.dart';
import 'package:euforia/widgetsGlobales/preload.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../servicios/Tops/UltimasPeliculasService.dart';
import '../servicios/endpoints.dart';
import '../settings/settings.dart';
import 'package:http/http.dart' as http;

class UltimasPeliculas extends StatefulWidget {
  const UltimasPeliculas({Key? key}) : super(key: key);

  @override
  _UltimasPeliculasState createState() => _UltimasPeliculasState();
}

class _UltimasPeliculasState extends State<UltimasPeliculas> {
  late Future<List<UltimasPeliculasModel>> setUltimasPeliculas;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUltimasPeliculas = getUltimasPeliculas();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('asdsa asdasda');
    return FutureBuilder(
      future: setUltimasPeliculas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Preload();
        } else {
          if (snapshot.data == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 15),
                content: Text(
                    'Se ha cerrado la sesión, otro usuario ha entrado y se ha superado el limite de conexiones de su plan')));

            Navigator.pushNamed(context, '/');

            return const Text('Todavía no se subieron Peliculas');
          } else {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
              child: Container(
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
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        'Ultimas Películas',
                        style: TextStyle(
                            fontSize: titleSize_2,
                            color: textPrimary,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: bgSecondary_4,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)),
                        ),
                        height: 250.0,
                        child: ListaUltimasPelis(snapshot.data!)),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}

class ListaUltimasPelis extends StatelessWidget {
  final List<UltimasPeliculasModel> ultimas;
  ListaUltimasPelis(this.ultimas);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ultimas.length,
      itemBuilder: (context, i) {
        final ult = ultimas[i];
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                final Future<SharedPreferences> _localStorage =
                    SharedPreferences.getInstance();
                final SharedPreferences localStorage = await _localStorage;
                localStorage.setString('peliculas_id', ult.idThmdb);
                //  print(localStorage.get('peliculas_id'));
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/peliculasdetail');
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  ult.imgThumb,
                  width: 130.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
