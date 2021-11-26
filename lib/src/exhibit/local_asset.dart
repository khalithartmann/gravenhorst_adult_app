import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:video_player/video_player.dart';

import 'local_video_player.dart';

class LocalAsset extends StatelessWidget {
  const LocalAsset({
    Key? key,
    required this.asset,
    this.height = 230,
    this.margin = const EdgeInsets.only(top: 30),
  }) : super(key: key);

  final Asset asset;
  final double height;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      child: FutureBuilder<File>(
        future: asset.localFile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (asset.assetType == AssetType.image) {
            return Image.file(
              snapshot.data!,
              fit: BoxFit.contain,
            );
          } else if (asset.assetType == AssetType.video) {
            return LocalVideoPlayer(
              localFile: snapshot.data!,
            );
          } else {
            throw Exception('Unsupported asset format ');
          }
        },
      ),
    );
  }
}
