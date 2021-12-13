import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:provider/provider.dart';

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
          height: 280,
          color: dullOrange,
          child: Column(
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
              Consumer<ExhibitoinDataController>(
                builder: (context, controller, _) {
                  return SizedBox(
                    height: 168,
                    child: Stack(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          children: [
                            ...controller.exhibitionDataList
                                .map((exhibition) => Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 56,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                exhibitionDataController
                                                    .onDeleteExhibitionDataForLocale(
                                                        exhibitionData:
                                                            exhibition);
                                              },
                                              child: const SizedBox(
                                                height: 56,
                                                width: 66,
                                                child: Icon(Icons.delete,
                                                    color: deepOrange),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0),
                                              child: SizedBox(
                                                width: 150,
                                                child: Text(
                                                    exhibition.localeName
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: deepOrange,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 24.0),
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
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                        Positioned(
                            top: 0,
                            left: 66,
                            child: Container(
                                height: 168, width: 0.5, color: Colors.white))
                      ],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    width: 66,
                    decoration: const BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(color: Colors.white, width: 0.5)))),
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
