import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/assets.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:gravenhorst_adults_app/src/exhibit/exhibit_view.dart';
import 'package:provider/provider.dart';

double get _speedDialButtonWidth => 66;
double get _speedDialButtonHeight => 56;

enum SpeedDialItemType {
  number,
  submit,
  display,
  clear,
  localeAdminPanel,
  home
}

class SpeedDialItem {
  SpeedDialItem({
    this.type = SpeedDialItemType.number,
    this.text,
    this.iconAssetPath,
    this.onPressed,
    this.backgroundColor = dullOrange,
    this.contentColor = Colors.white,
    this.borderColor = Colors.white,
  })  : assert(
            iconAssetPath == null ||
                text == null ||
                type == SpeedDialItemType.display,
            "one of the two arguments must be null"),
        assert(
            iconAssetPath != null ||
                text != null ||
                type == SpeedDialItemType.display,
            "one of the two arguments must not be null");
  final SpeedDialItemType type;
  final String? text;
  final String? iconAssetPath;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color contentColor;
  final Color borderColor;
}

List<SpeedDialItem> speedDialButtons = [
  SpeedDialItem(
    iconAssetPath: homeIconPath,
    backgroundColor: Colors.white,
    contentColor: dullOrange,
    borderColor: dullOrange,
    type: SpeedDialItemType.home,
  ),
  SpeedDialItem(
    type: SpeedDialItemType.display,
    backgroundColor: Colors.white,
    borderColor: dullOrange,
    contentColor: deepOrange,
  ),

  // PlaceHolderSpeedDialItem(),
  SpeedDialItem(
    iconAssetPath: dataIconPath,
    backgroundColor: Colors.white,
    contentColor: dullOrange,
    type: SpeedDialItemType.localeAdminPanel,
  ),
  ...List.generate(
      9,
      (index) => SpeedDialItem(
          text: (index + 1).toString(), type: SpeedDialItemType.number)),

  SpeedDialItem(
    type: SpeedDialItemType.submit,
    text: 'OK',
    contentColor: deepOrange,
  ),
  SpeedDialItem(
    text: '0',
  ),
  SpeedDialItem(
    iconAssetPath: deleteIconPath,
    contentColor: deepOrange,
    type: SpeedDialItemType.clear,
  ),
];

class SpeedDial extends StatefulWidget {
  const SpeedDial(
      {Key? key,
      required this.isOpen,
      required this.onShowAdminPanelButtonPressed,
      required this.onHomeButtonPressed})
      : super(key: key);
  final bool isOpen;
  final Function() onShowAdminPanelButtonPressed;
  final Function() onHomeButtonPressed;

  @override
  State<SpeedDial> createState() => _SpeedDialState();
}

class _SpeedDialState extends State<SpeedDial> {
  String inputValue = '';
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: standardAnimationDuration,
      left: widget.isOpen
          ? _speedDialButtonWidth
          : -((_speedDialButtonWidth * 4)),
      bottom: widget.isOpen ? 0 : -224,
      child: Container(
        width: getSpeedDialKeyboardWidth(context),
        height: 330,
        alignment: Alignment.bottomLeft,
        child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              mainAxisExtent: _speedDialButtonHeight,
            ),
            itemCount: speedDialButtons.length,
            itemBuilder: (BuildContext context, int index) {
              var currentButtonData = speedDialButtons[index];
              if (currentButtonData.type == SpeedDialItemType.display) {
                return InputDisplay(
                    currentButtonData: currentButtonData,
                    inputValue: inputValue);
              }

              return SpeedDialButton(
                speedDialItem: currentButtonData,
                onPressed: () {
                  if (currentButtonData.type == SpeedDialItemType.number &&
                      inputValue.length < 3) {
                    setState(() {
                      inputValue += currentButtonData.text!;
                    });
                  } else if (currentButtonData.type ==
                      SpeedDialItemType.submit) {
                    var exhibitionDataController =
                        context.read<ExhibitoinDataController>();
                    var match = exhibitionDataController
                        .exhibitionDataForCurrentLocale!.tours.first.exhibits
                        .firstWhereOrNull(
                            (element) => element.name == inputValue);

                    if (match == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('no match found')));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExhibitView(exhibit: match)));
                    }
                  } else if (currentButtonData.type ==
                      SpeedDialItemType.clear) {
                    setState(() {
                      inputValue = '';
                    });
                  } else if (currentButtonData.type ==
                      SpeedDialItemType.localeAdminPanel) {
                    widget.onShowAdminPanelButtonPressed();
                  } else if (currentButtonData.type == SpeedDialItemType.home) {
                    widget.onHomeButtonPressed();
                  }
                },
              );
            }),
      ),
    );
  }

  double getSpeedDialKeyboardWidth(BuildContext context) {
    return isMobilePlatform(context)
        ? MediaQuery.of(context).size.width - _speedDialButtonWidth
        : 309;
  }
}

class InputDisplay extends StatelessWidget {
  const InputDisplay({
    Key? key,
    required this.currentButtonData,
    required this.inputValue,
  }) : super(key: key);

  final SpeedDialItem currentButtonData;
  final String inputValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: currentButtonData.backgroundColor,
          border: Border.all(color: currentButtonData.borderColor, width: 0.5)),
      child: Center(
        child: Text(
          inputValue,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: currentButtonData.contentColor),
        ),
      ),
    );
  }
}

class SpeedDialButton extends StatelessWidget {
  const SpeedDialButton({
    Key? key,
    required this.speedDialItem,
    required this.onPressed,
  }) : super(key: key);
  final SpeedDialItem speedDialItem;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                        color: speedDialItem.borderColor, width: 0.5))),
            padding:
                MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
            fixedSize: MaterialStateProperty.resolveWith((states) =>
                Size(_speedDialButtonWidth, _speedDialButtonHeight)),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return speedDialItem.backgroundColor;
            })),
        child: speedDialItem.iconAssetPath != null
            ? Image.asset(
                speedDialItem.iconAssetPath!,
                color: speedDialItem.contentColor,
                width: 19,
              )
            : Text(
                speedDialItem.text!,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: speedDialItem.contentColor,
                    ),
              ));
  }
}
