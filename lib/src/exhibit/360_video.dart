import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:imageview360/imageview360.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThreeSixtyVideo extends StatefulWidget {
  const ThreeSixtyVideo(
      {Key? key,
      required this.localFile,
      required this.duration,
      required this.aspectRatio})
      : super(key: key);

  final File localFile;
  final Duration duration;
  final double aspectRatio;

  @override
  State<ThreeSixtyVideo> createState() => _ThreeSixtyVideoState();
}

class _ThreeSixtyVideoState extends State<ThreeSixtyVideo> {
  Image? thumbnail;

  Future<List<ImageProvider>> getFrames(BuildContext context) async {
    final List<ImageProvider> imageList = <ImageProvider>[];

    imageList.clear();

    try {
      for (var d = Duration.zero;
          d <= widget.duration;
          d += const Duration(seconds: 1)) {
        var destinationPath = p.join(widget.localFile.parent.path, "frames",
            "${p.basenameWithoutExtension(widget.localFile.path)}_${d.inMilliseconds}.jpeg");

        Uint8List? imageData;

        if (File(destinationPath).existsSync()) {
          imageData = File(destinationPath).readAsBytesSync();
        } else {
          imageData = await VideoThumbnail.thumbnailData(
              video: widget.localFile.path,
              timeMs: d.inMilliseconds,
              imageFormat: ImageFormat.JPEG,
              quality: 100);

          if (imageData == null) {
            throw Exception(
                "unable to extract frame in time: ${widget.duration} ms ");
          }
          File(destinationPath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(List<int>.from(imageData));
        }

        var image = Image.memory(imageData);

        if (d == Duration.zero) {
          setState(() {
            thumbnail = image;
          });
        }
        var imageProvider = image.image;
        imageList.add(imageProvider);

        await precacheImage(imageProvider, context);
      }

      return imageList;
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageProvider>>(
        future: getFrames(context),
        builder: (context, futureSnapshot) {
          if (thumbnail != null && !futureSnapshot.hasData ||
              futureSnapshot.connectionState == ConnectionState.waiting) {
            return AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: SizedBox(
                    width: screenWidth(context),
                    child: Stack(
                      children: [
                        Opacity(opacity: 0.5, child: thumbnail),
                        const Center(
                          child: CircularProgressIndicator(
                            color: deepOrange,
                          ),
                        )
                      ],
                    )));
          }
          if (!futureSnapshot.hasData) {
            return AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                height: screenHeight(context),
                color: Colors.red,
                width: screenWidth(context),
              ),
            );
          }
          return Opacity(
            opacity: futureSnapshot.hasData ? 1 : 0.5,
            child: ImageView360(
              key: UniqueKey(),
              swipeSensitivity: 2,
              imageList: futureSnapshot.data!,
              rotationDirection: RotationDirection.anticlockwise,
              frameChangeDuration: const Duration(milliseconds: 30),
            ),
          );
        });
  }
}
