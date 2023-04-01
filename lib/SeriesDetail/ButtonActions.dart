import 'package:euforia/settings/settings.dart';
import 'package:flutter/material.dart';

class ButtonActions extends StatelessWidget {
  const ButtonActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              color: bgPrimary,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: textPrimary),
                onPressed: () {
                  Navigator.pushNamed(context, '/player');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'REPRODUCIR',
                  style: TextStyle(fontSize: bodySize_1),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              color: textPrimary,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: bgPrimary),
                onPressed: () {
                  Navigator.pushNamed(context, '/venatana-emergente');
                },
                icon: const Icon(Icons.download),
                label: const Text(
                  'DESCARGAR',
                  style: TextStyle(fontSize: bodySize_1),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              color: bgPrimary,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: textPrimary),
                onPressed: () {},
                icon: const Icon(Icons.favorite),
                label: const Text(
                  'AÑADIR A FAVORITOS',
                  style: TextStyle(fontSize: bodySize_1),
                )),
          ),
        ),
      ],
    );
  }
}
