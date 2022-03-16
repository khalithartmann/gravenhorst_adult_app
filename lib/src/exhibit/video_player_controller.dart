import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

import 'local_video_player.dart';

class VideoPlayerControllerView extends StatefulWidget {
  const VideoPlayerControllerView({
    Key? key,
    required this.videoPlayerController,
    required this.isLooping,
    this.trailingActionButton,
  }) : super(key: key);

  final VideoPlayerController videoPlayerController;
  final bool isLooping;
  final Widget? trailingActionButton;

  @override
  _VideoPlayerControllerViewState createState() =>
      _VideoPlayerControllerViewState();
}

class _VideoPlayerControllerViewState extends State<VideoPlayerControllerView> {
  var currentPositionInPercent = 0.0;

  final _videoPositionStreamController = StreamController<Duration>();

  @override
  void initState() {
    widget.videoPlayerController.addListener(() async {
      var duration = await widget.videoPlayerController.position;
      if (duration != null) {
        _videoPositionStreamController.add(duration);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 70,
      decoration: const BoxDecoration(
          color: darkGrey,
          boxShadow: [BoxShadow(color: darkGrey, blurRadius: 10)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildVideoPlayerControllerActionButton(),
          StreamBuilder<Duration>(
            stream: _videoPositionStreamController.stream,
            builder: (context, positionSnapshot) {
              var videoOrientation =
                  getOrientation(size: widget.videoPlayerController.value.size);
              if (!positionSnapshot.hasData) {
                currentPositionInPercent = 0.0;
              } else {
                currentPositionInPercent = positionSnapshot
                        .data!.inMilliseconds /
                    widget.videoPlayerController.value.duration.inMilliseconds;

                if (currentPositionInPercent >= 1) {
                  currentPositionInPercent = 0;
                  // widget.videoPlayerController.pause();
                  widget.videoPlayerController.seekTo(Duration.zero);

                  if (!widget.isLooping) {
                    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      setState(() {});
                    });
                  }
                }
              }

              return Row(
                children: [
                  LinearPercentIndicator(
                    percent: currentPositionInPercent,
                    width: 180,
                    lineHeight: 1,
                    backgroundColor: Colors.white60,
                    progressColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                        positionSnapshot.data == null
                            ? '00:00'
                            : positionSnapshot.data!.toString().substring(2, 7),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white)),
                  ),
                  if (widget.trailingActionButton != null)
                    widget.trailingActionButton!,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> play() async {
    await widget.videoPlayerController.play();
    setState(() {});
  }

  Future<void> pause() async {
    await widget.videoPlayerController.pause();
    setState(() {});
  }

  Future<void> resume() async {
    await widget.videoPlayerController.play();
    setState(() {});
  }

  Widget buildVideoPlayerControllerActionButton() {
    var icon = const Icon(Icons.play_arrow, size: 43, color: Colors.white);
    var onTap = play;

    if (widget.videoPlayerController.value.isPlaying) {
      icon = const Icon(Icons.pause, size: 43, color: Colors.white);
      onTap = pause;
    } else {
      onTap = resume;
    }

    return InkWell(
      onTap: onTap,
      child: icon,
    );
  }
}
