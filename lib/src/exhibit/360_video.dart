import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:imageview360/imageview360.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThreeSixtyVideo extends StatefulWidget {
  const ThreeSixtyVideo({Key? key, required this.localFile}) : super(key: key);

  final File localFile;

  @override
  _ThreeSixtyVideoState createState() => _ThreeSixtyVideoState();
}

class _ThreeSixtyVideoState extends State<ThreeSixtyVideo> {
  List<ImageProvider> imageList = <ImageProvider>[];
  bool imagePrecached = false;
  var imageListStreamController = StreamController<List<ImageProvider>>();
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    print('local file path');
    print(widget.localFile.parent.path);
    print(widget.localFile);
    _videoPlayerController = VideoPlayerController.file(widget.localFile);

    _videoPlayerController.initialize().then(((value) {
      getFrames();
    }));
  }

  Future<void> getFrames() async {
    var videoDuratoin = _videoPlayerController.value.duration;
    print(videoDuratoin);

    for (var duration = Duration.zero;
        duration <= videoDuratoin;
        duration += const Duration(milliseconds: 500)) {
      var destinationPath = p.join(widget.localFile.parent.path, "frames",
          "${p.basenameWithoutExtension(widget.localFile.path)}_${duration.inMilliseconds}.jpeg");

      print(destinationPath);

      Uint8List? imageData;

      if (File(destinationPath).existsSync()) {
        imageData = File(destinationPath).readAsBytesSync();
      } else {
        imageData = await VideoThumbnail.thumbnailData(
          video: widget.localFile.path,
          timeMs: duration.inMilliseconds,
          imageFormat: ImageFormat.JPEG,
        );

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

    setState(() {
      imagePrecached = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ImageProvider>>(
        stream: imageListStreamController.stream,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Pre-Caching images...");
          }
          return IgnorePointer(
            ignoring: !imagePrecached,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: imagePrecached ? 1 : 0.5,
                  child: ImageView360(
                    key: UniqueKey(),
                    imageList: snapshot.data!,
                    swipeSensitivity: 4,
                    rotationDirection: RotationDirection.anticlockwise,
                    frameChangeDuration: const Duration(milliseconds: 30),
                  ),
                ),
                if (!imagePrecached)
                  const Center(
                    child: CircularProgressIndicator(
                      color: deepOrange,
                    ),
                  )
              ],
            ),
          );
        }));
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
