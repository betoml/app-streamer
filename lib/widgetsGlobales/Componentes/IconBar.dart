import 'package:flutter/material.dart';

class IconBar extends StatefulWidget {
  String text;
  dynamic icon;

  IconBar(this.icon, this.text, {super.key});

  @override
  State<IconBar> createState() => _IconBarState();
}

class _IconBarState extends State<IconBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          widget.icon,
          size: 30.0,
        )
      ],
    );
  }
}
