import 'dart:async';

import 'package:euforia/models/Tops/UltimasPeliculasModel.dart';
import 'package:euforia/models/Tops/UltimasSeries.dart';
import 'package:euforia/servicios/Tops/UltimasSeriesService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../settings/settings.dart';
import 'package:http/http.dart' as http;

class UltimasSeries extends StatefulWidget {
  const UltimasSeries({Key? key}) : super(key: key);

  @override
  _UltimasSeriesState createState() => _UltimasSeriesState();
}

class _UltimasSeriesState extends State<UltimasSeries> {
  late Future<List<UltimasSeriesModel>> setUltimasSeries;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUltimasSeries = getUltimasSeries();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('asdsa asdasda');
    return FutureBuilder(
      future: setUltimasSeries,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                      'Ultimas Series',
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
                      child: ListaUltimasSeries(snapshot.data!)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ListaUltimasSeries extends StatelessWidget {
  final List<UltimasSeriesModel> ultimasSeries;
  ListaUltimasSeries(this.ultimasSeries);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ultimasSeries.length,
      itemBuilder: (context, i) {
        final ult = ultimasSeries[i];
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                final Future<SharedPreferences> _localStorage =
                    SharedPreferences.getInstance();
                final SharedPreferences localStorage = await _localStorage;
                localStorage.setString('series_id', ult.idThmdbSeries);
                // print(localStorage.get('series_id'));
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/seriesdetail');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.network(
                  ult.imgThumbSeries,
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
