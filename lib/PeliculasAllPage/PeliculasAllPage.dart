import 'package:euforia/models/PeliculasAll/getPeliculasAllModel.dart';
import 'package:euforia/servicios/PeliculasAll/getPeliculasAllService.dart';
import 'package:flutter/material.dart';
import 'package:euforia/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PeliculasAllPage extends StatefulWidget {
  const PeliculasAllPage({Key? key}) : super(key: key);

  @override
  State<PeliculasAllPage> createState() => _PeliculasAllPageState();
}

class _PeliculasAllPageState extends State<PeliculasAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [bgSecondary_2, bgSecondary],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: [0.2, 0.8],
          ),
        ),
        child: Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: PeliculasListado(),
        )),
      ),
    );
  }
}

class PeliculasListado extends StatefulWidget {
  @override
  State<PeliculasListado> createState() => _PeliculasListadoState();
}

class _PeliculasListadoState extends State<PeliculasListado> {
  late Future<List<GetPeliculasAllModel>> setPeliculasAll;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPeliculasAll = getPeliculasAllService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setPeliculasAll,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == null) {
            return Text('Todavía no se subieron películas');
          } else {
            final datos_pelis = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 140,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemCount: datos_pelis.length,
              itemBuilder: (context, index) {
                final data_pelis = datos_pelis[index];
                return GestureDetector(
                    onTap: () async {
                      final Future<SharedPreferences> _localStorage =
                          SharedPreferences.getInstance();
                      final SharedPreferences localStorage =
                          await _localStorage;
                      localStorage.setString(
                          'peliculas_id', data_pelis.idMovie);
                      print(localStorage.get('peliculas_id'));
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, '/peliculasdetail');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        data_pelis.imgPortada,
                      ),
                    ));
              },
            );
          }
        }
      },
    );
  }
}
