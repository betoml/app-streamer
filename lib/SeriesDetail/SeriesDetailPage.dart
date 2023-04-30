import 'dart:convert';

import 'package:euforia/SeriesDetail/Sipnosis.dart';

import 'package:euforia/models/SeriesDetail/SeriesDetailModel.dart';
import 'package:euforia/servicios/SeriesDetail/SeriesDetailServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../settings/settings.dart';
import '../widgetsGlobales/preload.dart';
import 'SliderPrincipal.dart';

class SeriesDetailPage extends StatefulWidget {
  const SeriesDetailPage({Key? key}) : super(key: key);

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  late Future<SeriesDetailModel> setPeliculasDetail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPeliculasDetail = getSeriesDetail();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: removeTemp,
      child: Scaffold(
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
                        snapshot.data!.imgPortadaSeries,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 35.0,
                      ),

                      Sipnosis(
                        snapshot.data!.tituloSeries,
                        snapshot.data!.temporadas.toString(),
                        snapshot.data!.descripcionSeries,
                        snapshot.data!.genero1,
                        snapshot.data!.genero2,
                        snapshot.data!.genero3,
                      ),
                      // ignore: prefer_const_constructors

                      SizedBox(
                        height: 70.0,
                      ),
                    ]),
                  );
                }
              },
            )),
      ),
    );
  }

  Future<bool> removeTemp() async {
    final Future<SharedPreferences> _localStorage =
        SharedPreferences.getInstance();
    final SharedPreferences localStorage = await _localStorage;
    // print('Borrado!!!!');
    return await localStorage.remove('temporada');
  }
}
