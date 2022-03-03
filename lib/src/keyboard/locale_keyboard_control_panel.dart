import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:provider/provider.dart';

double get _standardButtonWidth => 66;
double get _standardButtonHeight => 56;

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
      left: _getLeftPositionOfControlPanel(context),
      bottom: showLocaleAdminestrationPanel ? 0 : -224,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: getWidthOfControlPanel(context),
          height: 280,
          color: dullOrange,
          child: Column(
            children: [
              Container(
                height: _standardButtonHeight,
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
                        width: _standardButtonWidth,
                        height: _standardButtonHeight,
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
                                        height: _standardButtonHeight,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                exhibitionDataController
                                                    .onDeleteExhibitionDataForLocale(
                                                        exhibitionData:
                                                            exhibition);
                                              },
                                              child: SizedBox(
                                                height: _standardButtonHeight,
                                                width: _standardButtonWidth,
                                                child: const Icon(Icons.delete,
                                                    color: deepOrange),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0),
                                              child: SizedBox(
                                                width: 150,
                                                child: Text(
                                                    exhibition.id.toUpperCase(),
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
                            left: _standardButtonWidth,
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
                    width: _standardButtonWidth,
                    decoration: const BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(color: Colors.white, width: 0.5)))),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.zero),
                      fixedSize: MaterialStateProperty.resolveWith((states) =>
                          Size(getUpdateButtonWidth(context),
                              _standardButtonHeight)),
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

  double getUpdateButtonWidth(BuildContext context) =>
      getWidthOfControlPanel(context) - _standardButtonWidth;

  double getWidthOfControlPanel(BuildContext context) {
    return isMobilePlatform(context) ? MediaQuery.of(context).size.width : 375;
  }

  double _getLeftPositionOfControlPanel(BuildContext context) {
    return showLocaleAdminestrationPanel
        ? 0
        : isMobilePlatform(context)
            ? (-MediaQuery.of(context).size.width + _standardButtonWidth)
            : -309;
  }
}
