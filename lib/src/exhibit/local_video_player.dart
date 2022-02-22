import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LocalVideoPlayer extends StatefulWidget {
  const LocalVideoPlayer({Key? key, required this.localFile}) : super(key: key);

  final File localFile;

  @override
  _LocalVideoPlayerState createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  late VideoPlayerController _controller;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    print('this is my local file ');
    print(widget.localFile);

    _controller = VideoPlayerController.file(widget.localFile)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(_controller),
          Positioned(
            bottom: 10,
            child: Slider(
                min: 0,
                max: 1,
                value: sliderValue,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                    _controller.seekTo(_controller.value.duration * value);
                  });
                }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
