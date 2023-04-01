import 'package:flutter/material.dart';

import '../settings/settings.dart';
import 'SliderPrincipal.dart';

class VentanaEmergente extends StatelessWidget {
  const VentanaEmergente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 60.0,
              decoration: const BoxDecoration(color: bgPrimary_2),
              child: TextButton.icon(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                icon: const Icon(
                  Icons.arrow_back,
                  color: textPrimary,
                ),
                label: const Text(''),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: bgPrimary,
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                      ),
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                              foregroundColor: textPrimary),
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text(
                            '1080P',
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
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                      ),
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                              foregroundColor: textPrimary),
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text(
                            '720P',
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
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ],
                      ),
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                              foregroundColor: textPrimary),
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text(
                            '480P',
                            style: TextStyle(fontSize: bodySize_1),
                          )),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
