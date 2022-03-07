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

class ThreeSixtyVideo extends StatelessWidget {
  ThreeSixtyVideo({Key? key, required this.localFile, required this.duration})
      : super(key: key);

  final File localFile;
  final Duration duration;

  final List<ImageProvider> imageList = <ImageProvider>[];

  final imageListStreamController = StreamController<List<ImageProvider>>();

  Future<bool> getFrames(BuildContext context) async {
    imageList.clear();

    try {
      for (var duration = Duration.zero;
          duration <= duration;
          duration += const Duration(milliseconds: 500)) {
        var destinationPath = p.join(localFile.parent.path, "frames",
            "${p.basenameWithoutExtension(localFile.path)}_${duration.inMilliseconds}.jpeg");

        Uint8List? imageData;

        if (File(destinationPath).existsSync()) {
          imageData = File(destinationPath).readAsBytesSync();
        } else {
          imageData = await VideoThumbnail.thumbnailData(
              video: localFile.path,
              timeMs: duration.inMilliseconds,
              imageFormat: ImageFormat.JPEG,
              quality: 100);

          if (imageData == null) {
            throw Exception("unable to extract frame in time: $duration ms ");
          }
          File(destinationPath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(List<int>.from(imageData));
        }

        var image = Image.memory(imageData).image;
        imageList.add(image);
        imageListStreamController.add(imageList);
        await precacheImage(image, context);
      }
      return true;
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getFrames(context),
        builder: (context, futureSnapshot) {
          return StreamBuilder<List<ImageProvider>>(
              stream: imageListStreamController.stream,
              builder: ((context, streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Container();
                }
                return IgnorePointer(
                  ignoring: !futureSnapshot.hasData,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: futureSnapshot.hasData ? 1 : 0.5,
                        child: ImageView360(
                          key: UniqueKey(),
                          swipeSensitivity: 2,
                          imageList: streamSnapshot.data!,
                          rotationDirection: RotationDirection.anticlockwise,
                          frameChangeDuration: const Duration(milliseconds: 30),
                        ),
                      ),
                      if (!futureSnapshot.hasData)
                        const Center(
                          child: CircularProgressIndicator(
                            color: deepOrange,
                          ),
                        )
                    ],
                  ),
                );
              }));
        });
  }

  void updateImageList(BuildContext context,
      {required List<File> imageFileList}) async {
    for (var file in imageFileList) {
      var image = Image.file(file).image;
      imageList.add(image);
      await precacheImage(image, context);
    }

    // setState(() {
    //   imagePrecached = true;
    // });
  }
}
