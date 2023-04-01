import 'package:flutter/material.dart';

import 'SamplePlayer.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black,
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return RotatedBox(quarterTurns: 1, child: SamplePlayer());
            } else {
              return RotatedBox(quarterTurns: 4, child: SamplePlayer());
            }
          },
        ));
  }
}
