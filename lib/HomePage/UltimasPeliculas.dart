import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:euforia/models/Tops/UltimasPeliculasModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../servicios/Tops/UltimasPeliculasService.dart';
import '../servicios/endpoints.dart';
import '../settings/settings.dart';
import 'package:http/http.dart' as http;

class UltimasPeliculas extends StatefulWidget {
  const UltimasPeliculas({Key? key}) : super(key: key);

  @override
  _UltimasPeliculasState createState() => _UltimasPeliculasState();
}

class _UltimasPeliculasState extends State<UltimasPeliculas> {
  late Future<List<UltimasPeliculasModel>> setUltimasPeliculas;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUltimasPeliculas = getUltimasPeliculas();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('asdsa asdasda');
    return FutureBuilder(
      future: setUltimasPeliculas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
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
                      'Ultimas Películas',
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
                      child: ListaUltimasPelis(snapshot.data!)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ListaUltimasPelis extends StatelessWidget {
  final List<UltimasPeliculasModel> ultimas;
  ListaUltimasPelis(this.ultimas);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ultimas.length,
      itemBuilder: (context, i) {
        final ult = ultimas[i];
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                final Future<SharedPreferences> _localStorage =
                    SharedPreferences.getInstance();
                final SharedPreferences localStorage = await _localStorage;
                localStorage.setString('peliculas_id', ult.idThmdb);
                print(localStorage.get('peliculas_id'));
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/peliculasdetail');
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  ult.imgThumb,
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

/* 
class UltimasPeliculas extends StatelessWidget {
    late Future<UltimasPeliculas> setUltimasPeliculas;
 // const UltimasPeliculas({Key? key}) : super(key: key);
 @override
void initState(){
  super.initSta
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Ultimas Peliculas',
              style: TextStyle(fontSize: titleSize_2, color: textPrimary),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/peliculasdetail');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                        child: Container(
                          width: 88.0,
                          height: 130.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                      child: Container(
                        width: 88.0,
                        height: 130.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/rHyB15bJiZKZUR6ZNgvcUxy9pVq.jpg'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      width: 89.0,
                      height: 60.0,
                      child: Text(
                        'Titulo de la Pelicula aqui es asd asdsdas',
                        style:
                            TextStyle(color: textPrimary, fontSize: bodySize_2),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 */