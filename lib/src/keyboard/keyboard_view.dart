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
  bool isOpen = true;
  bool showLocaleAdminestrationPanel = false;
  @override
  Widget build(BuildContext context) {
    var exhibitionDataController = context.read<ExhibitoinDataController>();

    return Stack(
      children: [
        AnimatedPositioned(
          duration: standardAnimationDuration,
          left: isOpen ? 66 : -243,
          bottom: isOpen ? 0 : -224,
          child: SpeedDial(
            isOpen: isOpen,
            onShowAdminPanelButtonPressed: () {
              setState(() {
                showLocaleAdminestrationPanel = true;
              });
            },
          ),
        ),
        LocaleSelector(
          isOpen: isOpen,
          exhibitionDataController: exhibitionDataController,
        ),
        AnimatedPositioned(
          duration: standardAnimationDuration,
          left: showLocaleAdminestrationPanel ? 0 : -309,
          bottom: showLocaleAdminestrationPanel ? 0 : -224,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: dullOrange,
              width: 375,
              height: 279,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(color: dullOrange, width: 0.5),
                        left: BorderSide(color: dullOrange, width: 0.5),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      'Inhalte verwalten',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: deepOrange, fontWeight: FontWeight.w400),
                    )),
                  ),
                  ...exhibitionDataController.exhibitionDataList
                      .map((exhibition) => Padding(
                            padding: const EdgeInsets.all(25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(exhibition.localeName.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: deepOrange,
                                    )),
                                Text(
                                    "${(exhibition.contentSize ~/ 1024)} MB"
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: deepOrange,
                                    )),
                              ],
                            ),
                          ))
                      .toList(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        )),
                        padding: MaterialStateProperty.resolveWith(
                            (states) => EdgeInsets.zero),
                        fixedSize: MaterialStateProperty.resolveWith(
                            (states) => const Size(309, 56)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => deepOrange)),
                    child: const Center(
                      child: Text(
                        'Auf Aktualisierung prüfen',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
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
