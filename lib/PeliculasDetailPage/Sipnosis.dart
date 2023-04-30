import 'dart:convert';

import 'package:euforia/servicios/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../servicios/descargasUrl.dart';
import '../settings/settings.dart';
import '../widgetsGlobales/Componentes/BtnFavoritos.dart';

class Sipnosis extends StatefulWidget {
  late String titulo;
  late String duracion;
  late String descripcion;
  final String genero1;
  final String genero2;
  final String genero3;
  final String url1080;
  final String url720;
  final String url480;

  Sipnosis(this.titulo, this.duracion, this.descripcion, this.genero1,
      this.genero2, this.genero3, this.url1080, this.url720, this.url480);

  @override
  State<Sipnosis> createState() => _SipnosisState();
}

class _SipnosisState extends State<Sipnosis> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Text(
              widget.titulo,
              style: TextStyle(
                  fontSize: 18.0,
                  color: textPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Duracion: ',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: bgPrimary,
                  ),
                ),
                Text(
                  '${widget.duracion} minutos',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Genero(s): ',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: bgPrimary,
                    ),
                  ),
                  Text(
                    '${widget.genero1}${widget.genero2}${widget.genero3}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
/*               IconButton(
                  color: textPrimary,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: bgSecondary_3.withOpacity(0.0),
                        content: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(7, 6, 6, 1),
                                  Color.fromRGBO(6, 6, 6, 1),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Elige la calidad: ',
                                style: TextStyle(
                                    fontSize: 21.0, color: textPrimary),
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  getDescarga(Uri.parse(widget.url1080));
                                },
                                icon: Icon(Icons.movie_filter),
                                label: Text('1080p'),
                                style: TextButton.styleFrom(
                                    foregroundColor: bgPrimary),
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  getDescarga(Uri.parse(widget.url720));
                                },
                                icon: Icon(Icons.movie_filter),
                                label: Text('720p'),
                                style: TextButton.styleFrom(
                                    foregroundColor: bgPrimary),
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  getDescarga(Uri.parse(widget.url480));
                                },
                                icon: Icon(Icons.movie_filter),
                                label: Text('480p'),
                                style: TextButton.styleFrom(
                                    foregroundColor: bgPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.download)), */
              BtnFavoritos(
                  'peliculas_id',
                  'peliculas_id',
                  EndPoints().peliculasFavoritosVerificar,
                  EndPoints().peliculasFavoritosBorrar,
                  EndPoints().peliculasFavoritosCrear)
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.descripcion,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16.0,
                  color: textPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
