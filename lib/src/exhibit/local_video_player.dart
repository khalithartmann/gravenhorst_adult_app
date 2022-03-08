import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/exhibit/video_player_controller.dart';
import 'package:video_player/video_player.dart';

class LocalVideoPlayer extends StatefulWidget {
  const LocalVideoPlayer({
    Key? key,
    required this.localFile,
    required this.isLooping,
    required this.autoplay,
  }) : super(key: key);

  final File localFile;
  final bool isLooping;
  final bool autoplay;

  @override
  _LocalVideoPlayerState createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  late VideoPlayerController _controller;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(
      widget.localFile,
    );
    _controller.setLooping(widget.isLooping);
    _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
      if (widget.autoplay) {
        _controller.play();
      }
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
              bottom: 30,
              child: VideoPlayerControllerView(
                videoPlayerController: _controller,
                isLooping: widget.isLooping,
              ))
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
