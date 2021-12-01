import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:provider/provider.dart';

class LocaleSelector extends StatelessWidget {
  const LocaleSelector({
    Key? key,
    required this.isOpen,
    required this.exhibitionDataController,
  }) : super(key: key);

  final bool isOpen;
  final ExhibitoinDataController exhibitionDataController;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: standardAnimationDuration,
        left: 0,
        bottom: isOpen
            ? 56
            : -1 * (exhibitionDataController.supportedLocales.length * 56),
        child: Column(
          children: [
            ...exhibitionDataController.supportedLocales
                .map((locale) => Consumer<ExhibitoinDataController>(
                        builder: (context, consumer, _) {
                      var isSelected = consumer.currentLocale?.id == locale.id;
                      return ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                        color: Colors.white, width: 0.5))),
                            padding: MaterialStateProperty.resolveWith(
                                (states) => EdgeInsets.zero),
                            fixedSize: MaterialStateProperty.resolveWith(
                                (states) => const Size(66, 56)),
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (isSelected) {
                                return Colors.white;
                              }
                              return dullOrange;
                            })),
                        onPressed: () {},
                        child: Text(
                          locale.id.toUpperCase().split('_').last,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color:
                                      isSelected ? deepOrange : Colors.white),
                        ),
                      );
                    }))
                .toList()
          ],
        ));
  }
}