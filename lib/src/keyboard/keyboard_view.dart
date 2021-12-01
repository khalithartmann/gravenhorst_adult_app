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
        SpeedDial(
          isOpen: isOpen,
          onShowAdminPanelButtonPressed: () {
            setState(() {
              showLocaleAdminestrationPanel = true;
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

class LocaleKeyboardControlPanel extends StatelessWidget {
  const LocaleKeyboardControlPanel({
    Key? key,
    required this.showLocaleAdminestrationPanel,
  }) : super(key: key);

  final bool showLocaleAdminestrationPanel;

  @override
  Widget build(BuildContext context) {
    final exhibitionDataController = context.read<ExhibitoinDataController>();
    return AnimatedPositioned(
      duration: standardAnimationDuration,
      left: showLocaleAdminestrationPanel ? 0 : -309,
      bottom: showLocaleAdminestrationPanel ? 0 : -224,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 375,
          height: 279,
          color: dullOrange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(width: 0.5, color: dullOrange))),
                        width: 66,
                        height: 56,
                        child: const Icon(
                          Icons.copy,
                          color: dullOrange,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text('Inhalte verwalten',
                          style: TextStyle(fontSize: 24, color: deepOrange)),
                    ),
                  ],
                ),
              ),
              ...exhibitionDataController.exhibitionDataList
                  .map((exhibition) => SizedBox(
                        height: 56,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 56,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 0, color: Colors.white))),
                                width: 66,
                                child:
                                    const Icon(Icons.delete, color: deepOrange),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(exhibition.localeName.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: deepOrange,
                                  )),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Text(
                                  "${(exhibition.contentSize ~/ 1024)} MB"
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: deepOrange,
                                  )),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      width: 66,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.white, width: 0.5)))),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
