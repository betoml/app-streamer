import 'package:euforia/models/Favoritos/getFavoritosAll.dart';
import 'package:euforia/servicios/Favoritos/getFavoritosAll.dart';
import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Favoritos/getFavoritosAllSeriesModel.dart';
import '../../servicios/Favoritos/getFavoritosAllSeries.dart';
import '../preload.dart';

class GridThumbSeries extends StatefulWidget {
  @override
  _GridThumbSeriesState createState() => _GridThumbSeriesState();
}

class _GridThumbSeriesState extends State<GridThumbSeries> {
  late Future<List<GetFavoritosAllSeries>> favoritos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    favoritos = getFavoritosAllSeries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: favoritos,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Preload();
        } else {
          if (data == null) {
            return const Text('No hay elementos');
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 140,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final _datos = data[index];
                return GestureDetector(
                    onTap: () async {
                      final Future<SharedPreferences> _localStorage =
                          SharedPreferences.getInstance();
                      final SharedPreferences localStorage =
                          await _localStorage;
                      localStorage.setString('series_id', _datos.idThmdbSeries);
                      Navigator.pushNamed(context, '/seriesdetail');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        _datos.imgThumbSeries,
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
