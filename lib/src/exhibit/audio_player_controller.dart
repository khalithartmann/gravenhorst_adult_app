import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AudioPlayerController extends StatefulWidget {
  const AudioPlayerController({
    Key? key,
    required this.audioPlayer,
    required this.audioAsset,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final Asset audioAsset;

  @override
  _AudioPlayerControllerState createState() => _AudioPlayerControllerState();
}

class _AudioPlayerControllerState extends State<AudioPlayerController> {
  var currentPositionInPercent = 0.0;
  var audioDuration;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    streamSubscription =
        widget.audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {});
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
          buildAudioPlayerActionButton(),
          StreamBuilder<Duration>(
            stream: widget.audioPlayer.onPositionChanged,
            builder: (context, positionSnapshot) {
              if (audioDuration == null || !positionSnapshot.hasData) {
                currentPositionInPercent = 0.0;
              } else {
                currentPositionInPercent =
                    positionSnapshot.data!.inMilliseconds / audioDuration;
              }

              return Row(
                children: [
                  LinearPercentIndicator(
                    percent: currentPositionInPercent,
                    width: 218,
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
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> play() async {
    var audioPath = (await widget.audioAsset.localFile()).path;

    await widget.audioPlayer.play(DeviceFileSource(audioPath));

    // workaround [https://github.com/bluefireteam/audioplayers/issues/588]
    await Future.delayed(const Duration(milliseconds: 100));

    audioDuration = await widget.audioPlayer.getDuration();
  }

  Future<void> pause() async {
    await widget.audioPlayer.pause();
  }

  Future<void> resume() async {
    await widget.audioPlayer.resume();
  }

  Widget buildAudioPlayerActionButton() {
    var icon = const Icon(Icons.play_arrow, size: 43, color: Colors.white);
    var onTap = play;

    if (widget.audioPlayer.state == PlayerState.playing) {
      icon = const Icon(Icons.pause, size: 43, color: Colors.white);
      onTap = pause;
    } else if (widget.audioPlayer.state == PlayerState.paused) {
      onTap = resume;
    }

    return InkWell(
      onTap: onTap,
      child: icon,
    );
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}
