import 'dart:io';

import 'package:euforia/models/Search/SearchPeliculasModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../servicios/Search/searchFilmService.dart';
import '../servicios/Search/searchSeriesService,.dart';
import '../servicios/endpoints.dart';
import '../settings/settings.dart';
import '../widgetsGlobales/preload.dart';

class PeliculasSearch extends StatefulWidget {
  String textSearch;

  PeliculasSearch(this.textSearch);

  @override
  State<PeliculasSearch> createState() => _PeliculasSearchState();
}

class _PeliculasSearchState extends State<PeliculasSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchFilm(widget.textSearch);
    searchSeries(widget.textSearch);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
      child: Container(
          width: double.infinity,
          height: 110.0,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    blurRadius: 5.0,
                    spreadRadius: 5,
                    blurStyle: BlurStyle.outer,
                    offset: Offset.zero)
              ],
              color: bgSecondary_4,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(75.0),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: bgSecondary_4,
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.movie),
                          text: 'PELICULAS',
                        ),
                        Tab(
                          icon: Icon(Icons.theaters),
                          text: 'SERIES',
                        ),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(color: bgSecondary_4),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 10.0, right: 10.0),
                            child: FutureBuilder(
                              future: searchFilm(widget.textSearch),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Preload();
                                } else {
                                  if (snapshot.data == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 15),
                                            content: Text(
                                                'Se ha cerrado la sesión, otro usuario ha entrado y se ha superado el limite de conexiones de su plan')));
                                    Navigator.pushNamed(context, '/');
                                    return const Text(
                                        'No se ha podido cargar los elementos');
                                  } else {
                                    return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 140,
                                              childAspectRatio: 2 / 3,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final datosFilm = snapshot.data![index];
                                        return GestureDetector(
                                          onTap: () async {
                                            final Future<SharedPreferences>
                                                _localStorage =
                                                SharedPreferences.getInstance();
                                            final SharedPreferences
                                                localStorage =
                                                await _localStorage;
                                            localStorage.setString(
                                                'peliculas_id',
                                                datosFilm.idThmdb.toString());
                                            // ignore: use_build_context_synchronously
                                            Navigator.pushNamed(
                                                context, '/peliculasdetail');
                                          },
                                          child:
                                              Image.network(datosFilm.imgThumb),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                            )),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(color: bgSecondary_4),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 10.0, right: 10.0),
                            child: FutureBuilder(
                              future: searchSeries(widget.textSearch),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Preload();
                                } else {
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 140,
                                            childAspectRatio: 2 / 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      final datosFilm = snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () async {
                                          final Future<SharedPreferences>
                                              _localStorage =
                                              SharedPreferences.getInstance();
                                          final SharedPreferences localStorage =
                                              await _localStorage;
                                          localStorage.setString(
                                              'series_id',
                                              datosFilm.idThmdbSeries
                                                  .toString());
                                          Navigator.pushNamed(
                                              context, '/seriesdetail');
                                        },
                                        child: Image.network(
                                            datosFilm.imgThumbSeries),
                                      );
                                    },
                                  );
                                }
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
