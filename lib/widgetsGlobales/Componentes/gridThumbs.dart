import 'package:euforia/models/Favoritos/getFavoritosAll.dart';
import 'package:euforia/servicios/Favoritos/getFavoritosAll.dart';
import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../preload.dart';

class GridThumbs extends StatefulWidget {
  @override
  _GridThumbsState createState() => _GridThumbsState();
}

class _GridThumbsState extends State<GridThumbs> {
  late Future<List<GetFavoritosAll>> favoritos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    favoritos = getFavoritosAll();
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
            Navigator.pushNamed(context, '/');
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
                      localStorage.setString('peliculas_id', _datos.idThmdb);
                      Navigator.pushNamed(context, '/peliculasdetail');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        _datos.imgThumb,
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
