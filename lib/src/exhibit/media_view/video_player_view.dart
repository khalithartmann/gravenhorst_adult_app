import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/exhibit/media_view/video_player_controller_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

import '../../core/globals.dart';
import 'full_screen_video_player_view.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    Key? key,
    required this.localFile,
    required this.isLooping,
    required this.autoplay,
  }) : super(key: key);

  final File localFile;
  final bool isLooping;
  final bool autoplay;

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  double sliderValue = 0;
  bool loadingNewVideo = false;
  bool fullScreenShowing = false;

  @override
  void initState() {
    _controller = VideoPlayerController.file(widget.localFile,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    _controller.setLooping(widget.isLooping);
    _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
      print("state set ");
      if (widget.autoplay) {
        _controller.play();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadedFileName = _controller.dataSource.split('/').last;
    final currentFileName = widget.localFile.path.split('/').last;
    if (loadedFileName != currentFileName) {
      loadingNewVideo = true;
      _controller = VideoPlayerController.file(widget.localFile,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

      _controller.setLooping(widget.isLooping);
      _controller.initialize().then((_) {
        loadingNewVideo = false;
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        print("state set ");
        if (widget.autoplay) {
          _controller.play();
        }
      });
    }
    if (loadingNewVideo) {
      return Container();
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
                onPressed: () async {
                  var position = await _controller.position;
                  await Navigator.of(context).push(PageTransition(
                      child: FullScreenVideoPlayer(
                        isLooping: widget.isLooping,
                        autoplay: widget.autoplay,
                        videoFile: widget.localFile,
                        position: position ?? Duration.zero,
                      ),
                      type: PageTransitionType.fade));
                },
                icon: const Icon(Icons.fullscreen, color: Colors.white)),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
