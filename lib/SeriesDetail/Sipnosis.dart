import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:euforia/models/SeriesDetail/getCapitulosModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../PlayerPage/PlayerPage.dart';
import '../servicios/SeriesDetail/GetCapitulosService.dart';
import '../servicios/descargasUrl.dart';
import '../servicios/endpoints.dart';
import '../settings/settings.dart';

import '../servicios/SeriesDetail/GetTemporadas.dart';
import '../widgetsGlobales/Componentes/BtnFavoritos.dart';
import '../widgetsGlobales/preload.dart';

class Sipnosis extends StatefulWidget {
  late String titulo;
  late String duracion;
  late String descripcion;
  final String genero1;
  final String genero2;
  final String genero3;

  Sipnosis(
    this.titulo,
    this.duracion,
    this.descripcion,
    this.genero1,
    this.genero2,
    this.genero3,
  );

  @override
  State<Sipnosis> createState() => _SipnosisState();
}

class _SipnosisState extends State<Sipnosis> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Text(
              widget.titulo,
              style: TextStyle(
                  fontSize: 18.0,
                  color: textPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Temporadas: ',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: bgPrimary,
                  ),
                ),
                Text(
                  '${widget.duracion}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Genero(s): ',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: bgPrimary,
                    ),
                  ),
                  Text(
                    '${widget.genero1}${widget.genero2}${widget.genero3}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BtnFavoritos(
                  'series_id',
                  'series_id',
                  EndPoints().seriesFavoritosVerificar,
                  EndPoints().seriesFavoritosBorrar,
                  EndPoints().seriesFavoritosCrear)
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.descripcion,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16.0,
                  color: textPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Temporadas(),
        ],
      ),
    );
  }
}

class Temporadas extends StatefulWidget {
  @override
  State<Temporadas> createState() => _TemporadasState();
}

class _TemporadasState extends State<Temporadas> {
  String? dropdownValue;
  List dataTemporadas = [];
  late Future<List<GetCapitulosModel>> setCapitulos;

  void getNumberTemporadas() async {
    final Future<SharedPreferences> _localStorage =
        SharedPreferences.getInstance();
    final SharedPreferences localStorage = await _localStorage;
    final response = await http.post(
      Uri.parse(EndPoints().baseUrlApi + EndPoints().seriesTemporadas),
      body: {'id_thmdb_series': localStorage.getString('series_id')},
      headers: {
        'Accept': 'application/json, charset: utf-8',
        HttpHeaders.authorizationHeader:
            'Bearer ${localStorage.getString('token')}'
      },
    );

    var listData = jsonDecode(response.body);
    await localStorage.setString('temporada', listData[0]);
    setState(() {
      dataTemporadas = listData;
      //   dropdownValue = listData[0];
    });
    //  print(localStorage.getString('temporada'));
  }

  late Stream verTemp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNumberTemporadas();

    dataTemporadas;
    dropdownValue;
    verTemp = getCapitulosTemp();
  }

  @override
  Widget build(BuildContext context) {
    //  print(dataTemporadas);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: DropdownButton<String>(
            dropdownColor: bgSecondary_4,
            hint: const Text(
              'Escoge una temporada',
              style: TextStyle(color: textPrimary),
            ),
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: textPrimary),
            underline: Container(
              height: 2,
              color: bgPrimary,
            ),
            onChanged: (String? value) async {
              final Future<SharedPreferences> _localStorage =
                  SharedPreferences.getInstance();
              final SharedPreferences localStorage = await _localStorage;
              await localStorage.setString('temporada', value!);
              setState(() {
                dropdownValue = value;
                verTemp = getCapitulosTemp();
              });

              // print(await localStorage.getString("temporada"));
            },
            items: dataTemporadas.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                alignment: Alignment.center,
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        StreamBuilder(
          stream: verTemp,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Preload();
            } else {
              final data = snapshot.data;
              if (data == null) {
                return const Text('');
              } else {
                return Container(
                  height: 400.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      final datos = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          decoration: const BoxDecoration(color: bgSecondary_4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        bgSecondary_3.withOpacity(0.0),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // ignore: prefer_const_literals_to_create_immutables
                                          boxShadow: [
                                            const BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                blurRadius: 12.0,
                                                spreadRadius: 0,
                                                blurStyle: BlurStyle.outer,
                                                offset: Offset.zero)
                                          ]
                                          // ignore: prefer_const_literals_to_create_immutables
                                          ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Elige la calidad: ',
                                            style: TextStyle(
                                                fontSize: 21.0,
                                                color: textPrimary),
                                          ),
                                          TextButton.icon(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlayerPage(
                                                            datos.url1080S)),
                                              );
                                            },
                                            icon: Icon(Icons.movie_filter),
                                            label: Text('1080p'),
                                            style: TextButton.styleFrom(
                                                foregroundColor: bgPrimary),
                                          ),
                                          TextButton.icon(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlayerPage(
                                                            datos.url720S)),
                                              );
                                            },
                                            icon: Icon(Icons.movie_filter),
                                            label: Text('720p'),
                                            style: TextButton.styleFrom(
                                                foregroundColor: bgPrimary),
                                          ),
                                          TextButton.icon(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlayerPage(
                                                            datos.url480S)),
                                              );
                                            },
                                            icon: Icon(Icons.movie_filter),
                                            label: Text('480p'),
                                            style: TextButton.styleFrom(
                                                foregroundColor: bgPrimary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              leading: Image.network(datos.miniatura),
                              title: Text(
                                datos.titulo,
                                style: const TextStyle(
                                    color: textPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                datos.descripcion,
                                style: const TextStyle(color: textPrimary),
                              ),
                              /* trailing: IconButton(
                                icon: const Icon(
                                  Icons.download,
                                  color: textPrimary,
                                ),
                                onPressed: () {
                                  /* showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor:
                                          bgSecondary_3.withOpacity(0.0),
                                      content: Container(
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color.fromRGBO(7, 6, 6, 1),
                                                Color.fromRGBO(6, 6, 6, 1),
                                              ],
                                              begin: FractionalOffset.center,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [0.01, 0.9],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            // ignore: prefer_const_literals_to_create_immutables
                                            boxShadow: [
                                              const BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  blurRadius: 12.0,
                                                  spreadRadius: 0,
                                                  blurStyle: BlurStyle.outer,
                                                  offset: Offset.zero)
                                            ]
                                            // ignore: prefer_const_literals_to_create_immutables
                                            ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Elige la calidad de: ',
                                              style: TextStyle(
                                                  fontSize: 21.0,
                                                  color: textPrimary),
                                            ),
                                            TextButton.icon(
                                              onPressed: () async {
                                                getDescarga(
                                                    Uri.parse(datos.url1080S));
                                              },
                                              icon: Icon(Icons.movie_filter),
                                              label: Text('1080p'),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: bgPrimary),
                                            ),
                                            TextButton.icon(
                                              onPressed: () async {
                                                getDescarga(
                                                    Uri.parse(datos.url1720S));
                                              },
                                              icon: Icon(Icons.movie_filter),
                                              label: Text('720p'),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: bgPrimary),
                                            ),
                                            TextButton.icon(
                                              onPressed: () async {
                                                getDescarga(
                                                    Uri.parse(datos.url480S));
                                              },
                                              icon: Icon(Icons.movie_filter),
                                              label: Text('480p'),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: bgPrimary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ); */
                                },
                              ), */
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
        const SizedBox(
          height: 50.0,
        )
      ],
    );
  }
}

class Capitulos extends StatefulWidget {
  late List setCapitulos;

  Capitulos(this.setCapitulos);

  @override
  State<Capitulos> createState() => _CapitulosState();
}

class _CapitulosState extends State<Capitulos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(color: bgSecondary_4),
            child: ListTile(
              leading: Image.network(
                  'https://www.themoviedb.org/t/p/w227_and_h127_bestv2/lr8OEa0GzjZ0qmD9NuuMj6TRWxF.jpg'),
              title: Text(
                '1 El mandaloriano',
                style:
                    TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Un cazarrecompensas mandaloriano rastrea un objetivo para un cliente que paga bien.',
                style: TextStyle(color: textPrimary),
              ),
              trailing: Icon(
                Icons.download,
                color: textPrimary,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(color: bgSecondary_4),
            child: ListTile(
              onTap: () {},
              leading: Image.network(
                  'https://www.themoviedb.org/t/p/w227_and_h127_bestv2/lr8OEa0GzjZ0qmD9NuuMj6TRWxF.jpg'),
              title: Text(
                '1 El mandaloriano',
                style:
                    TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Un cazarrecompensas mandaloriano rastrea un objetivo para un cliente que paga bien.',
                style: TextStyle(color: textPrimary),
              ),
              trailing: Icon(
                Icons.download,
                color: textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
