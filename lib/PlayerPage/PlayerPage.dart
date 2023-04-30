import 'package:flutter/material.dart';

import 'SamplePlayer.dart';

class PlayerPage extends StatefulWidget {
  String url;

  PlayerPage(this.url, {super.key});

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    final urlv = widget.url;
    return Material(
        color: Colors.black,
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return RotatedBox(quarterTurns: 1, child: SamplePlayer(urlv));
            } else {
              return RotatedBox(quarterTurns: 4, child: SamplePlayer(urlv));
            }
          },
        ));
  }
}
