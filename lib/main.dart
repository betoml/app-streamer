import 'dart:io';

import 'package:euforia/PeliculasDetailPage/PeliculasDetailPage.dart';
import 'package:euforia/PeliculasDetailPage/VentanaEmergente.dart';
import 'package:euforia/SeriesAll/SeriesAllPage.dart';
import 'package:euforia/SeriesDetail/SeriesDetailPage.dart';
import 'package:euforia/PeliculasAllPage/PeliculasAllPage.dart';

import 'package:google_fonts/google_fonts.dart';

import 'HomePage/HomePage.dart';
import 'LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';

//import 'PlayerPage/PlayerPage.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const EuforiaApp());
}

class EuforiaApp extends StatelessWidget {
  const EuforiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/': (context) => const LoginPage(),
        '/peliculasdetail': (context) => const PeliculasDetailPage(),
        '/seriesdetail': (context) => const SeriesDetailPage(),
        '/venatana-emergente': (context) => const VentanaEmergente(),
        // '/player': (context) => PlayerPage(''),
        '/peliculas-all': (context) => const PeliculasAllPage(),
        '/series-all': (context) => const SeriesAllPage(),
      },
      initialRoute: '/',
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
