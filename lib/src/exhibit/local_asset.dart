import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/assets.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:gravenhorst_adults_app/src/exhibit/360_video.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

import 'image_description.dart';
import 'local_video_player.dart';

class LocalAsset extends StatefulWidget {
  const LocalAsset({
    Key? key,
    required this.asset,
    this.height,
    this.width,
    this.imageFit = BoxFit.contain,
    this.assetChild,
  }) : super(key: key);

  final Asset asset;
  final double? height;
  final double? width;
  final BoxFit imageFit;
  final Widget? assetChild;

  @override
  State<LocalAsset> createState() => _LocalAssetState();
}

class _LocalAssetState extends State<LocalAsset> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Stack(
            children: [
              SizedBox(
                width: widget.width,
                height: widget.height,
                child: FutureBuilder<File>(
                  future: widget.asset.localFile(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (widget.asset.assetType == AssetType.image) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: screenHeight(context) - 100),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
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
                                errorBuilder: (context, error, s) {
                                  return Image.network(
                                    widget.asset.remoteUrl,
                                    fit: widget.imageFit,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (widget.asset.assetType == AssetType.video) {
                      if (widget.asset.interactive!) {
                        return ThreeSixtyVideo(
                          localFile: snapshot.data!,
                          duration:
                              Duration(seconds: widget.asset.duration!.toInt()),
                          aspectRatio:
                              widget.asset.width! / widget.asset.height!,
                        );
                      } else {
                        return LocalVideoPlayer(
                          localFile: snapshot.data!,
                          autoplay: widget.asset.autoplay!,
                          isLooping: widget.asset.loop!,
                        );
                      }
                    } else {
                      throw Exception('Unsupported asset format ');
                    }
                  },
                ),
              ),
              if (widget.assetChild != null) widget.assetChild!
            ],
          ),
        ),
        Column(
          children: [
            if (widget.asset.description != null)
              ImageDescriptionText(text: widget.asset.description!),
            if (widget.asset.copyright != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ImageDescriptionText(text: widget.asset.copyright!),
              ),
          ],
        ),
      ],
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
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Image.file(
              localFile,
            ),
          ),
        ),
      ),
    );
  }
}
