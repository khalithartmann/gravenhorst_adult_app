import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:provider/provider.dart';

import 'keyboard_menu_button.dart';
import 'locale_keyboard_control_panel.dart';
import 'locale_selector.dart';
import 'speed_dial.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  bool isOpen = true;
  bool showLocaleAdminestrationPanel = false;
  @override
  Widget build(BuildContext context) {
    var exhibitionDataController = context.read<ExhibitoinDataController>();

    return Stack(
      children: [
        SpeedDial(
          isOpen: isOpen,
          onShowAdminPanelButtonPressed: () {
            setState(() {
              showLocaleAdminestrationPanel = true;
            });
          },
          onHomeButtonPressed: () {
            setState(() {
              isOpen = false;
            });
          },
        ),
        LocaleSelector(
          isOpen: isOpen,
          exhibitionDataController: exhibitionDataController,
        ),
        LocaleKeyboardControlPanel(
          showLocaleAdminestrationPanel: showLocaleAdminestrationPanel,
        ),
        KeyboardMenuButton(
          onPressed: () {
            if (showLocaleAdminestrationPanel) {
              setState(() {
                showLocaleAdminestrationPanel = false;
              });
            } else {
              setState(() {
                isOpen = !isOpen;
              });
            }
          },
        ),
      ],
    );
  }
}
