import 'dart:io';
import 'dart:ui';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'exhibition_data/exhibition_locale.dart';

const standardAnimationDuration = Duration(milliseconds: 300);

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16)}';
}

Future<String> get documentDirectoryPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

bool isMobilePlatform(BuildContext context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide < 600;
}

bool isTablet(BuildContext context) => !isMobilePlatform(context);

Future<void> showTopSnackBar(BuildContext context, {required String text}) {
  return showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (context, controller) {
      return Flash(
        constraints: const BoxConstraints(
          minHeight: 60,
          minWidth: 250,
          maxWidth: 600,
          maxHeight: 60,
        ),
        borderRadius: BorderRadius.circular(10),
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.top,
        backgroundColor: darkGrey,
        margin: const EdgeInsets.only(top: 110),
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          color: darkGrey,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    },
  );
}

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

Orientation getOrientation({required Size size}) {
  if (size.width > size.height) {
    return Orientation.landscape;
  } else {
    return Orientation.portrait;
  }
}
