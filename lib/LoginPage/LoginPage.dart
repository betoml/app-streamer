// ignore_for_file: file_names

import 'dart:convert';

import 'package:euforia/servicios/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final emailField = TextEditingController();
final passField = TextEditingController();

var client = http.Client();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void iniState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    verificarToken() async {
      final Future<SharedPreferences> _localStorage =
          SharedPreferences.getInstance();
      final SharedPreferences localStorage = await _localStorage;

      if (localStorage.getString('token') != null) {
        var headers = {'Authorization': 'Bearer ${localStorage.get('token')}'};
        var request = http.Request('POST',
            Uri.parse(EndPoints().baseUrlApi + EndPoints().verificarToken));

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          // print(true);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/home');
        } else {
          // print(false);
          // ignore: use_build_context_synchronously

          localStorage.remove('token');
        }
      }
    }

    verificarToken();

    return const Scaffold(
      body: Background(),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [bgSecondary_2, bgSecondary],
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        stops: [0.2, 0.8],
      )),
      child: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Box(),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Container(
        width: double.infinity,
        height: 460,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(61, 54, 54, 0.09),
                Color.fromRGBO(32, 30, 30, 1),
                Color.fromRGBO(61, 54, 54, 0.09),
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomCenter,
              stops: [0.01, 0.5, 0.9],
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                width: 1, color: const Color.fromARGB(58, 136, 136, 136)),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 12), // changes position of shadow
              ),
            ]),
        child: const BoxContent(),
      ),
    );
  }
}

class BoxContent extends StatelessWidget {
  const BoxContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [Logo(), BoxInputs(), BtnLogin()],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: Image.asset('assets/logo_rojo.png'),
    );
  }
}

class BoxInputs extends StatelessWidget {
  const BoxInputs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailField,
          style: const TextStyle(color: textPrimary, fontSize: bodySize_1),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.email,
              color: bgPrimary,
              size: 30.0,
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: textPrimary),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgPrimary, width: 2.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgPrimary_2, width: 2.0),
            ),
          ),
        ),
        TextField(
          controller: passField,
          style: const TextStyle(color: textPrimary, fontSize: bodySize_1),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: bgPrimary,
              size: 30.0,
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: textPrimary),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgPrimary, width: 2.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgPrimary_2, width: 2.0),
            ),
          ),
          obscureText: true,
        ),
      ],
    );
  }
}

class BtnLogin extends StatelessWidget {
  const BtnLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 50.0),
          foregroundColor: textPrimary,
          backgroundColor: bgPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          elevation: 6.0),
      onPressed: () async {
        Map<String, String> data;
        data = {"email": emailField.text, "password": passField.text};

        final response = await http.post(
          Uri.parse(EndPoints().baseUrlApi + EndPoints().login),
          headers: <String, String>{
            'Accept': 'application/json;',
          },
          body: data,
        );

        //print(response.body);

        Map<String, dynamic> user = jsonDecode(response.body);
        //print(response.body);
        if (user['code'] == 1) {
          // return SnackBar(content: Text('asdas'));
          // ignore: use_build_context_synchronously
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  iconColor: bgPrimary,
                  icon: const Icon(
                    Icons.warning,
                    size: 40.0,
                  ),
                  content: Text(
                    textAlign: TextAlign.center,
                    user['message'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                );
              });
        }

        if (user['code'] == 2) {
          // ignore: use_build_context_synchronously
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor: bgPrimary,
                            foregroundColor: textPrimary),
                        onPressed: () async {
                          await http.post(
                              Uri.parse(
                                  EndPoints().baseUrlApi + EndPoints().logouts),
                              body: {"id": user['user']['id'].toString()});
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              duration: Duration(seconds: 30),
                              content: Text(
                                  'Se ha eliminado las otras sesiones, ahora puede iniciar sesión nuevamente')));
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text(
                          'Eliminar sesiones',
                          style: TextStyle(color: textPrimary),
                        ))
                  ],
                  backgroundColor: Colors.black,
                  iconColor: bgPrimary,
                  icon: const Icon(
                    Icons.warning,
                    size: 40.0,
                  ),
                  content: Text(
                    textAlign: TextAlign.center,
                    user['message'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                );
              });
        }

        if (user['code'] == 3) {
          // ignore: use_build_context_synchronously

          final Future<SharedPreferences> _localStorage =
              SharedPreferences.getInstance();
          final SharedPreferences localStorage = await _localStorage;

          localStorage.setString('token', user['access_token']);
          localStorage.setString('user_id', user['user']['id'].toString());

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/home');
        }

        // loginEuforia(emailField.toString(), passField.toString());
      },
      icon: const Icon(Icons.login),
      label: const Text(
        'LOGIN',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}

@override
void dispose() {
  emailField.dispose();
  passField.dispose();
}
