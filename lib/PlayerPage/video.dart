import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  var urlVideo =
      "https://download1486.mediafire.com/dyqnjcj6iekg/6udcu6b0onjnuv5/Santa+RM+-+Mucho+Para+M%C3%AD+%28Ft.+Franco+Escamilla%29+%5BVideo+Oficial%5D_2.mp4";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(urlVideo)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
