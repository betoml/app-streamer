import 'dart:ffi';
import 'dart:io';
import 'package:euforia/models/PeliculasAll/btnFavoritoStateModel.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../servicios/endpoints.dart';

class BtnFavoritos extends StatefulWidget {
  final String idSeccion,
      seccionField,
      endpointVerificar,
      endpointBorrar,
      endpointCrear;

  BtnFavoritos(this.idSeccion, this.seccionField, this.endpointVerificar,
      this.endpointBorrar, this.endpointCrear);
//peliculas_id o series_id
//users_id
//peliculas_id o series_id field
//endpoint
  @override
  _BtnFavoritosState createState() => _BtnFavoritosState();
}

class _BtnFavoritosState extends State<BtnFavoritos> {
  Stream<BtnFavoritoStateModel> getFavoritos() async* {
    final Future<SharedPreferences> _localStorage =
        SharedPreferences.getInstance();
    final SharedPreferences localStorage = await _localStorage;
    final res = await http.post(
      Uri.parse(EndPoints().baseUrlApi + widget.endpointVerificar),
      body: {
        widget.idSeccion: localStorage.getString(widget.seccionField),
        'users_id': localStorage.getString('user_id')
      },
      headers: {
        'Accept': 'application/json, charset: utf-8',
        HttpHeaders.authorizationHeader:
            'Bearer ${localStorage.getString('token')}'
      },
    );

    //  print(res.body);
    yield btnFavoritoStateModelFromJson(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getFavoritos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final mess = snapshot.data!;
          if (mess.message == true) {
            return TextButton.icon(
                onPressed: () async {
                  final Future<SharedPreferences> _localStorage =
                      SharedPreferences.getInstance();
                  final SharedPreferences localStorage = await _localStorage;
                  final favRemove = await http.post(
                    Uri.parse(EndPoints().baseUrlApi + widget.endpointBorrar),
                    body: {
                      widget.idSeccion:
                          localStorage.getString(widget.seccionField),
                      'users_id': localStorage.getString('user_id')
                    },
                    headers: {
                      'Accept': 'application/json, charset: utf-8',
                      HttpHeaders.authorizationHeader:
                          'Bearer ${localStorage.getString('token')}'
                    },
                  );
                  setState(() {
                    getFavoritos();
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: bgPrimary,
                ),
                label: Text(''));
          } else {
            return TextButton.icon(
                onPressed: () async {
                  final Future<SharedPreferences> _localStorage =
                      SharedPreferences.getInstance();
                  final SharedPreferences localStorage = await _localStorage;
                  final favAdd = await http.post(
                    Uri.parse(EndPoints().baseUrlApi + widget.endpointCrear),
                    body: {
                      widget.idSeccion:
                          localStorage.getString(widget.seccionField),
                      'users_id': localStorage.getString('user_id')
                    },
                    headers: {
                      'Accept': 'application/json, charset: utf-8',
                      HttpHeaders.authorizationHeader:
                          'Bearer ${localStorage.getString('token')}'
                    },
                  );
                  print(favAdd.body);
                  setState(() {
                    getFavoritos();
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: textPrimary,
                ),
                label: Text(''));
          }
        }
      },
    );
  }
}
