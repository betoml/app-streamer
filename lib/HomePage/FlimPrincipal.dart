import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';

class FilmPrincipal extends StatelessWidget {
  const FilmPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500/5XJabHGBaH2qAZAE2kVKCmrnY70.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: bgSecondary_5, boxShadow: [
            const BoxShadow(
                color: bgSecondary_4,
                blurRadius: 12.0,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer,
                offset: Offset.zero)
          ]),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: textPrimary),
                  onPressed: () {
                    Navigator.pushNamed(context, '/peliculas-all');
                  },
                  icon: Icon(Icons.movie),
                  label: Text('Películas')),
              TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: textPrimary),
                  onPressed: () {
                    Navigator.pushNamed(context, '/series-all');
                  },
                  icon: Icon(Icons.theaters),
                  label: Text('Series')),
            ],
          ),
        ),
      ],
    );
  }
}
