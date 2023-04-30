//import 'package:euforia/PeliculasDetailPage/ButtonActions.dart';
import 'dart:convert';

import 'package:euforia/PeliculasDetailPage/Sipnosis.dart';
import 'package:euforia/models/FilmDetail/FilmDetail.dart';
import 'package:flutter/material.dart';

import '../servicios/FilmDetail/FilmDetailServive.dart';
import '../settings/settings.dart';
import '../widgetsGlobales/preload.dart';
import 'SliderPrincipal.dart';

class PeliculasDetailPage extends StatefulWidget {
  const PeliculasDetailPage({Key? key}) : super(key: key);

  @override
  State<PeliculasDetailPage> createState() => _PeliculasDetailPageState();
}

class _PeliculasDetailPageState extends State<PeliculasDetailPage> {
  late Future<PeliculasDetailModel> setPeliculasDetail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPeliculasDetail = getPeliculasDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [bgSecondary_2, bgSecondary],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: [0.2, 0.8],
          )),
          child: FutureBuilder(
            future: setPeliculasDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Preload();
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    SliderPrincipal(
                        snapshot.data!.imgPortada,
                        snapshot.data!.url1080,
                        snapshot.data!.url720,
                        snapshot.data!.url480),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 35.0,
                    ),

                    Sipnosis(
                        snapshot.data!.titulo,
                        snapshot.data!.duracion.toString(),
                        snapshot.data!.descripcion,
                        snapshot.data!.genero1,
                        snapshot.data!.genero2,
                        snapshot.data!.genero3,
                        snapshot.data!.url1080,
                        snapshot.data!.url720,
                        snapshot.data!.url480),
                    // ignore: prefer_const_constructors

                    SizedBox(
                      height: 35.0,
                    ),
                  ]),
                );
              }
            },
          )),
    );
  }
}
