import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:provider/provider.dart';

import 'keyboard_menu_button.dart';
import 'locale_selector.dart';
import 'speed_dial.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    var exhibitionDataController = context.read<ExhibitoinDataController>();

    return Stack(
      children: [
        SpeedDial(isOpen: isOpen),
        LocaleSelector(
          isOpen: isOpen,
          exhibitionDataController: exhibitionDataController,
        ),
        KeyboardMenuButton(
          onPressed: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
        ),
      ],
    );
  }
}
