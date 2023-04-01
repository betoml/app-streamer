import 'package:flutter/material.dart';
import '../settings/settings.dart';
import 'FlimPrincipal.dart';
import 'UltimasPeliculas.dart';
import 'UltimasSeries.dart';

class ContainerPrincipal extends StatelessWidget {
  const ContainerPrincipal({Key? key}) : super(key: key);

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
      child: ListView(
        children: const [
          FilmPrincipal(),
          UltimasPeliculas(),
          UltimasSeries(),
          //    UltimasPeliculas(),
          //   UltimasPeliculas(),
          //  UltimasPeliculas(),
          //  UltimasPeliculas(),
          //  UltimasPeliculas(),
          SizedBox(
            height: 40.0,
          )
        ],
      ),
    );
  }
}
