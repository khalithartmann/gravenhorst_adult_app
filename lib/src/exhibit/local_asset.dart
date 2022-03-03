import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/assets.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/exhibit/360_video.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

import 'local_video_player.dart';

class LocalAsset extends StatelessWidget {
  const LocalAsset({
    Key? key,
    required this.asset,
    this.height,
    this.width,
    this.imageFit = BoxFit.contain,
  }) : super(key: key);

  final Asset asset;
  final double? height;
  final double? width;
  final BoxFit imageFit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: FutureBuilder<File>(
          future: asset.localFile(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (asset.assetType == AssetType.image) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullScreenImageView(
                      localFile: snapshot.data!,
                    );
                  }));
                },
                child: Hero(
                  tag: 'imageHero',
                  child: Image.file(
                    snapshot.data!,
                    fit: imageFit,
                    height: height,
                    width: width,
                    errorBuilder: (context, error, s) {
                      return Image.network(
                        asset.remoteUrl,
                        height: height,
                        fit: imageFit,
                        width: width,
                      );
                    },
                  ),
                ),
              );
            } else if (asset.assetType == AssetType.video) {
              return ThreeSixtyVideo(
                localFile: snapshot.data!,
              );
            } else {
              throw Exception('Unsupported asset format ');
            }
          },
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  const FullScreenImageView({Key? key, required this.localFile})
      : super(key: key);

  final File localFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Transform.rotate(
            angle: -90 * pi / 180,
            child: Image.asset(
              arrowIconPath,
              width: 20,
              height: 24,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: Image.file(
            localFile,
          ),
        ),
      ),
    );
  }
}
