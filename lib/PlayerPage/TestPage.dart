import 'package:flutter/material.dart';

import 'SamplePlayer.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black,
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return RotatedBox(quarterTurns: 1, child: SamplePlayer(''));
            } else {
              return RotatedBox(quarterTurns: 4, child: SamplePlayer(''));
            }
          },
        ));
  }
}
