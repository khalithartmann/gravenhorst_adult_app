import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';

import 'audio_player_controller.dart';
import 'image_description.dart';
import 'title_text.dart';

class ExhibitEntryPointPage extends StatefulWidget {
  const ExhibitEntryPointPage({
    Key? key,
    required this.entry,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final Entry entry;

  static const type = 'EntryPoint';

  @override
  State<ExhibitEntryPointPage> createState() => _ExhibitEntryPointPageState();
}

class _ExhibitEntryPointPageState extends State<ExhibitEntryPointPage> {
  late Asset? backgroundImageAsset;
  late Asset? audioAsset;

  @override
  void initState() {
    backgroundImageAsset = getFirstEntryByType(assetType: AssetType.image);
    audioAsset = getFirstEntryByType(assetType: AssetType.audio);
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
        buildHeadline(),
        if (audioAsset != null)
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 111),
                child: AudioPlayerController(
                    audioPlayer: widget.audioPlayer, audioAsset: audioAsset!),
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
        child: FutureBuilder<File>(
            future: backgroundImageAsset!.localFile(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.file(
                    snapshot.data!,
                    height: screenHeight(context),
                    width: screenWidth(context),
                    fit: BoxFit.cover,
                  ),
                  if (backgroundImageAsset!.copyright != null)
                    Positioned(
                      bottom: 30,
                      child: ImageDescriptionText(
                        text: backgroundImageAsset!.copyright!,
                      ),
                    ),
                ],
              );
            }));
  }

  bool get hasBackgroundImage => backgroundImageAsset != null;
  Widget buildHeadline() {
    if (widget.entry.title == null) {
      return Container();
    }
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: screenWidth(context),
        margin: const EdgeInsets.only(
          top: 30,
          left: 60,
          right: 30,
        ),
        child: Headline2Text(text: widget.entry.title!),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.audioPlayer.dispose();
  }
}
