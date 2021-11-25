import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';

import 'audio_player_controller.dart';

class ExhibitEntryPointPage extends StatefulWidget {
  const ExhibitEntryPointPage({Key? key, required this.entry})
      : super(key: key);

  final Entry entry;

  static const type = 'entryPoint';

  @override
  State<ExhibitEntryPointPage> createState() => _ExhibitEntryPointPageState();
}

class _ExhibitEntryPointPageState extends State<ExhibitEntryPointPage> {
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
