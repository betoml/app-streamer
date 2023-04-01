import 'package:euforia/PeliculasDetailPage/PeliculasDetailPage.dart';
import 'package:euforia/models/FilmDetail/FilmDetail.dart';
import 'package:euforia/servicios/FilmDetail/FilmDetailServive.dart';
import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderPrincipal extends StatelessWidget {
  late String imgPortada;

  SliderPrincipal(this.imgPortada, {super.key});

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
      ],
    );
  }
}
