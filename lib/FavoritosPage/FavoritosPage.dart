import 'package:euforia/models/Favoritos/getFavoritosAll.dart';
import 'package:euforia/servicios/Favoritos/getFavoritosAll.dart';
import 'package:euforia/servicios/endpoints.dart';
import 'package:euforia/widgetsGlobales/Componentes/gridThumbsSeries.dart';
import 'package:flutter/material.dart';

import '../settings/settings.dart';
import '../widgetsGlobales/Componentes/gridThumbs.dart';
import 'PeliculasFavoritos.dart';
import 'SeriesFavoritas.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({Key? key}) : super(key: key);

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
        )),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
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
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: bgSecondary_4,
              ),
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 10.0, right: 10.0),
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
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: GridThumbs(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 10.0, right: 10.0),
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
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: GridThumbSeries(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
