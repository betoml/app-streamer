import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:euforia/widgetsGlobales/Componentes/IconBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../FavoritosPage/FavoritosPage.dart';
import '../PerfilPage/PerfilPage.dart';
import '../SearchPage/SearchPage.dart';
import '../servicios/endpoints.dart';
import '../servicios/verificar-token.dart';
import '../settings/settings.dart';
import 'ContainerPrincipal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const ContainerPrincipal(),
    SearchPage(),
    const FavoritosPage(),
    const PerfilPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    verificarToken() async {
      final Future<SharedPreferences> _localStorage =
          SharedPreferences.getInstance();
      final SharedPreferences localStorage = await _localStorage;

      var headers = {'Authorization': 'Bearer ${localStorage.get('token')}'};
      var request = http.Request('POST',
          Uri.parse(EndPoints().baseUrlApi + EndPoints().verificarToken));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(true);
        return true;
      } else {
        // print(false);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/');
        localStorage.remove('token');
        return false;
      }
    }

    verificarToken();
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: textPrimary)),
        child: CurvedNavigationBar(
          height: 70.0,
          items: [
            Icon(
              Icons.home,
              size: 25.0,
            ),
            Icon(
              Icons.search,
              size: 25.0,
            ),
            Icon(
              Icons.favorite,
              size: 25.0,
            ),
            Icon(
              Icons.person,
              size: 25.0,
            ),
          ],
          index: _selectedIndex,
          buttonBackgroundColor: bgPrimary,
          color: Color.fromRGBO(236, 1, 1, 1),
          backgroundColor: Colors.transparent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
