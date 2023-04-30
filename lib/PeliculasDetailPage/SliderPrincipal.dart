import 'package:euforia/PeliculasDetailPage/PeliculasDetailPage.dart';
import 'package:euforia/PlayerPage/PlayerPage.dart';
import 'package:euforia/models/FilmDetail/FilmDetail.dart';
import 'package:euforia/servicios/FilmDetail/FilmDetailServive.dart';
import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderPrincipal extends StatelessWidget {
  late String imgPortada;
  late String url1080;
  late String url720;
  late String url480;

  SliderPrincipal(this.imgPortada, this.url1080, this.url720, this.url480,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: 610.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0)),
            image: DecorationImage(
                image: NetworkImage(imgPortada), fit: BoxFit.cover),
          ),
        ),
        Container(
          width: double.infinity,
          height: 610.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(7, 6, 6, 0.0),
                  Color.fromRGBO(6, 6, 6, 0.5),
                  Color.fromRGBO(6, 6, 6, 1),
                ],
                begin: FractionalOffset.center,
                end: FractionalOffset.bottomCenter,
                stops: [0.1, 0.5, 0.9],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0)),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    blurRadius: 12.0,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.outer,
                    offset: Offset.zero)
              ]
              // ignore: prefer_const_literals_to_create_immutables
              ),
        ),
        Container(
          width: double.infinity,
          height: 350.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(7, 6, 6, 0),
                Color.fromRGBO(6, 6, 6, 0.9),
              ],
              begin: FractionalOffset.center,
              end: FractionalOffset.bottomCenter,
              stops: [0.3, 0.7],
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0)),
            // ignore: prefer_const_literals_to_create_immutables

            // ignore: prefer_const_literals_to_create_immutables
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              minimumSize: const Size(230.0, 43.0),
              backgroundColor: bgPrimary,
              foregroundColor: textPrimary,
              elevation: 20.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
              ),
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: bgSecondary_3.withOpacity(0.0),
                content: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(7, 6, 6, 1),
                          Color.fromRGBO(6, 6, 6, 1),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Elige la calidad: ',
                        style: TextStyle(fontSize: 21.0, color: textPrimary),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayerPage(url1080.toString())),
                          );
                        },
                        icon: Icon(Icons.movie_filter),
                        label: Text('1080p'),
                        style: TextButton.styleFrom(foregroundColor: bgPrimary),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayerPage(url720.toString())),
                          );
                        },
                        icon: Icon(Icons.movie_filter),
                        label: Text('720p'),
                        style: TextButton.styleFrom(foregroundColor: bgPrimary),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayerPage(url480.toString())),
                          );
                        },
                        icon: Icon(Icons.movie_filter),
                        label: Text('480p'),
                        style: TextButton.styleFrom(foregroundColor: bgPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            icon: Icon(Icons.play_circle),
            label: Text('REPRODCIR'),
          ),
        ),
      ],
    );
  }
}
