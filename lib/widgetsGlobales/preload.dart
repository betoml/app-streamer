import 'package:flutter/material.dart';

class Preload extends StatelessWidget {
  const Preload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
