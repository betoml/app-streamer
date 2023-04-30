import 'package:euforia/models/SeriesAll/SeriesAllModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../servicios/PeliculasAll/getPeliculasAllService.dart';
import '../servicios/SeriesAllService.dart/getSeriesAllService.dart';
import '../settings/settings.dart';
import '../widgetsGlobales/preload.dart';

class SeriesAllPage extends StatefulWidget {
  const SeriesAllPage({Key? key}) : super(key: key);

  @override
  _SeriesAllPageState createState() => _SeriesAllPageState();
}

class _SeriesAllPageState extends State<SeriesAllPage> {
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
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SeriesListado(),
        ),
      ),
    );
  }
}

class SeriesListado extends StatefulWidget {
  @override
  State<SeriesListado> createState() => _SeriesListadoState();
}

class _SeriesListadoState extends State<SeriesListado> {
  late Future<List<GetSeriesAllModel>> setSeriesAll;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSeriesAll = getSeriesAllService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setSeriesAll,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Preload();
        } else {
          if (snapshot.data == null) {
            return Text('Todavía no se subieron Series');
          } else {
            final datos_pelis = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 140,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemCount: datos_pelis.length,
              itemBuilder: (context, index) {
                final data_pelis = datos_pelis[index];
                return GestureDetector(
                    onTap: () async {
                      final Future<SharedPreferences> _localStorage =
                          SharedPreferences.getInstance();
                      final SharedPreferences localStorage =
                          await _localStorage;
                      localStorage.setString('series_id', data_pelis.idMovie);
                      print(localStorage.get('series_id'));
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, '/seriesdetail');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        data_pelis.imgPortada,
                      ),
                    ));
              },
            );
          }
        }
      },
    );
  }
}
