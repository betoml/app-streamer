import 'package:euforia/SearchPage/PeliculasSearch.dart';
import 'package:flutter/material.dart';
import '../servicios/Search/searchFilmService.dart';
import '../servicios/Search/searchSeriesService,.dart';
import '../settings/settings.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController textImput = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textImput;
  }

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
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
              child: Container(
                width: double.infinity,
                height: 160.0,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          blurRadius: 12.0,
                          spreadRadius: 5,
                          blurStyle: BlurStyle.outer,
                          offset: Offset.zero)
                    ],
                    color: bgSecondary_4,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: TextFormField(
                        controller: textImput,
                        style: const TextStyle(
                            color: textPrimary, fontSize: bodySize_1),
                        decoration: const InputDecoration(
                          labelText: 'Titulo de la Serie/Película',
                          labelStyle:
                              TextStyle(color: textPrimary, fontSize: 16.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: bgPrimary, width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: bgPrimary_2, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0),
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 50.0),
                              backgroundColor: bgPrimary,
                              foregroundColor: textPrimary),
                          onPressed: () async {
                            print(textImput.text.toString());
                            setState(() {
                              searchFilm(textImput.text.toString());
                              searchSeries(textImput.text.toString());
                            });
                          },
                          icon: Icon(Icons.search),
                          label: Text(
                            'Buscar',
                            style: TextStyle(fontSize: 18.0),
                          )),
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: PeliculasSearch(textImput.text.toString()))
          ],
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textImput.dispose();
  }
}
