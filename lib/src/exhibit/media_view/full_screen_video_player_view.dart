import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/exhibit/media_view/video_player_controller_view.dart';

import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer({
    Key? key,
    required this.isLooping,
    required this.videoFile,
    required this.autoplay,
    required this.position,
  }) : super(key: key);

  final bool isLooping;
  final File videoFile;
  final bool autoplay;
  final Duration position;

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.file(
      widget.videoFile,
    );
    _controller.setLooping(widget.isLooping);

    _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

      _controller.seekTo(widget.position);
      setState(() {});

      if (widget.autoplay) {
        _controller.play();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   body: Stack(
    //     children: [
    //       Center(
    //         child: AspectRatio(
    //             aspectRatio: widget.controller.value.aspectRatio,
    //             child: VideoPlayer(widget.controller)),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
        backgroundColor: Colors.black,
        body: RotatedBox(
          quarterTurns: 1,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller)),
              ),
              VideoPlayerControllerView(
                backgroundColor: Colors.transparent,
                videoPlayerController: _controller,
                isLooping: widget.isLooping,
                trailingActionButton: IconButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    icon:
                        const Icon(Icons.fullscreen_exit, color: Colors.white)),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    print("disposing");
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }
}
