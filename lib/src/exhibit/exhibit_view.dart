import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:location/location.dart';
import 'package:collection/collection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExhibitView extends StatelessWidget {
  const ExhibitView({Key? key, required this.exhibit}) : super(key: key);
  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    print(exhibit.entries.length);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: ExhibitAppBar(exhibit: exhibit),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              TabBarView(
                children: [
                  ...exhibit.entries.map((currentEntry) {
                    switch (currentEntry.type) {
                      case ExhibitEntryPoint.type:
                        return ExhibitEntryPoint(
                          entry: currentEntry,
                        );

                      default:
                        return Center(
                            child: Text(
                                'Exhibit Entry Type not implemented : ${currentEntry.type}'));
                    }
                  }).toList(),
                ],
              ),
              Container(
                height: 7.5,
                color: Colors.white,
              ),
              SizedBox(
                height: 15,
                child: TabBar(
                    indicator: const BoxDecoration(color: deepOrange),
                    indicatorWeight: 15,
                    tabs: List.generate(
                        exhibit.entries.length, (index) => Container())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExhibitAppBar extends StatelessWidget {
  const ExhibitAppBar({
    Key? key,
    required this.exhibit,
  }) : super(key: key);

  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      centerTitle: true,
      leadingWidth: 145,
      leading: Container(
        color: Colors.white,
      ),
      title: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          )),
      actions: [
        Container(
            margin: const EdgeInsets.only(bottom: 12),
            width: 87,
            height: 77,
            child: Center(
                child: Text(exhibit.name,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.white)))),
      ],
    );
  }
}

class ExhibitEntryPoint extends StatefulWidget {
  const ExhibitEntryPoint({Key? key, required this.entry}) : super(key: key);

  final Entry entry;

  static const type = 'entryPoint';

  @override
  State<ExhibitEntryPoint> createState() => _ExhibitEntryPointState();
}

class _ExhibitEntryPointState extends State<ExhibitEntryPoint> {
  late Asset? backgroundImageAsset;
  late Asset audioAsset;
  var audioPlayer = AudioPlayer();

  @override
  void initState() {
    backgroundImageAsset = getFirstEntryByType(assetType: AssetType.image);
    audioAsset = getFirstEntryByType(assetType: AssetType.audio)!;
    super.initState();
  }

  Asset? getFirstEntryByType({required AssetType assetType}) {
    return widget.entry.assets.firstWhereOrNull((element) {
      return element.assetType == assetType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackgroundImage(),
        buildGradientImageOverlay(),
        buildHeadline(),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 111),
              child: AudioPlayerController(
                  audioPlayer: audioPlayer, audioAsset: audioAsset),
            )),
      ],
    );
  }

  Widget buildBackgroundImage() {
    if (!hasBackgroundImage) {
      return Container();
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: FutureBuilder(
        future: backgroundImageAsset?.localFile(),
        builder: (context, AsyncSnapshot<File> snapshot) {
          if (snapshot.hasData) {
            return Image.file(
              snapshot.data!,
              height: 628,
              fit: BoxFit.cover,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  bool get hasBackgroundImage => backgroundImageAsset != null;
  Widget buildHeadline() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 300,
        child: Text(
          widget.entry.title,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: darkGrey,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }

  Widget buildGradientImageOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              lightGrey,
              lightGrey.withOpacity(0.9),
              lightGrey.withOpacity(0.7),
              lightGrey.withOpacity(0.5),
              lightGrey.withOpacity(0),
            ],
            stops: const [
              0.0,
              0.25,
              0.5,
              0.75,
              1.0
            ]),
      ),
    );
  }
}

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

  @override
  void initState() {
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
            stream: widget.audioPlayer.onAudioPositionChanged,
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
    int result = await widget.audioPlayer.play(audioPath, isLocal: true);
    if (result != 1) {
      logger.i('todo show snackbar: could not play audio ');
      // success
    } else {
      audioDuration = await widget.audioPlayer.getDuration();
    }
  }

  Future<void> pause() async {
    int result = await widget.audioPlayer.pause();
    if (result != 1) {
      logger.i('todo show snackbar: could not play audio ');
      // success
    }
  }

  Future<void> resume() async {
    int result = await widget.audioPlayer.resume();
    if (result != 1) {
      logger.i('todo show snackbar: could not play audio ');
      // success
    }
  }

  Widget buildAudioPlayerActionButton() {
    var icon = const Icon(Icons.play_arrow, size: 43, color: Colors.white);
    var onTap = play;

    if (widget.audioPlayer.state == PlayerState.PLAYING) {
      icon = const Icon(Icons.pause, size: 43, color: Colors.white);
      onTap = pause;
    } else if (widget.audioPlayer.state == PlayerState.PAUSED) {
      onTap = resume;
    }

    return InkWell(
      onTap: onTap,
      child: icon,
    );
  }
}
