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

class LocalAsset extends StatefulWidget {
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
  State<LocalAsset> createState() => _LocalAssetState();
}

class _LocalAssetState extends State<LocalAsset> {
  @override
  Widget build(BuildContext context) {
    print("selected asset ");
    print(widget.asset.assetUrlLocalPath);

    return Center(
      child: SizedBox(
        child: FutureBuilder<File>(
          future: widget.asset.localFile(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (widget.asset.assetType == AssetType.image) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullScreenImageView(
                      localFile: snapshot.data!,
                    );
                  }));
                },
                child: Hero(
                  tag: 'imageHero_${snapshot.data!.path}',
                  child: Image.file(
                    snapshot.data!,
                    fit: widget.imageFit,
                    height: widget.height,
                    width: widget.width,
                    errorBuilder: (context, error, s) {
                      return Image.network(
                        widget.asset.remoteUrl,
                        height: widget.height,
                        fit: widget.imageFit,
                        width: widget.width,
                      );
                    },
                  ),
                ),
              );
            } else if (widget.asset.assetType == AssetType.video) {
              return ThreeSixtyVideo(
                localFile: snapshot.data!,
                duration: Duration(seconds: widget.asset.duration!.toInt()),
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
          tag: 'imageHero_${localFile.path}',
          child: Image.file(
            localFile,
          ),
        ),
      ),
    );
  }
}
