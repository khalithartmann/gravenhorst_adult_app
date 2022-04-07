import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gravenhorst_adults_app/src/exhibit/video_player_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

import '../core/globals.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape &&
          _controller.value.size.width > _controller.value.size.height) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          _controller.pause();
          Navigator.of(context).push(PageTransition(
              type: PageTransitionType.fade,
              child: FullScreenVideoPlayer(
                controller: _controller,
                isLooping: widget.isLooping,
              )));
        });
      }

      return Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenHeight(context) - 300),
            child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: VideoPlayerControllerView(
              videoPlayerController: _controller,
              isLooping: widget.isLooping,
              trailingActionButton: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: FullScreenVideoPlayer(
                          controller: _controller,
                          isLooping: widget.isLooping,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.fullscreen, color: Colors.white)),
            ),
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer({
    Key? key,
    required this.controller,
    required this.isLooping,
  }) : super(key: key);

  final VideoPlayerController controller;
  final bool isLooping;

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    widget.controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller)),
          ),
        ],
      ),
    );
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller)),
            ),
            Positioned(
              bottom: 30,
              child: VideoPlayerControllerView(
                videoPlayerController: widget.controller,
                isLooping: widget.isLooping,
                trailingActionButton: IconButton(
                    onPressed: () async {
                      await SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                      Navigator.of(context).pop();
                    },
                    icon:
                        const Icon(Icons.fullscreen_exit, color: Colors.white)),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
