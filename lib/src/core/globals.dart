import 'dart:ui';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

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

Future<String> get documentDirectoryPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
