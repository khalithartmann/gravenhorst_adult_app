import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';

class SpeedDialItem {
  SpeedDialItem({
    this.text,
    this.iconData,
    this.onPressed,
    this.backgroundColor = dullOrange,
    this.contentColor = Colors.white,
    this.borderColor = Colors.white,
  })  : assert(iconData == null || text == null,
            "one of the two arguments must be null"),
        assert(iconData != null || text != null,
            "one of the two arguments must not be null");
  final String? text;
  final IconData? iconData;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color contentColor;
  final Color borderColor;
}

class PlaceHolderSpeedDialItem extends SpeedDialItem {
  PlaceHolderSpeedDialItem();
}

List<SpeedDialItem> speedDialButtons = [
  SpeedDialItem(
    iconData: Icons.ac_unit,
    backgroundColor: Colors.white,
    contentColor: dullOrange,
    borderColor: dullOrange,
  ),

  // PlaceHolderSpeedDialItem(),
  SpeedDialItem(
    iconData: Icons.copy,
    backgroundColor: Colors.white,
    contentColor: dullOrange,
  ),
  ...List.generate(
      9,
      (index) => SpeedDialItem(
            text: (index + 1).toString(),
          )),

  SpeedDialItem(
    text: 'OK',
    contentColor: deepOrange,
  ),
  SpeedDialItem(
    text: '0',
  ),
  SpeedDialItem(
    iconData: Icons.cancel,
    contentColor: deepOrange,
  ),
];

class SpeedDial extends StatelessWidget {
  const SpeedDial({Key? key, required this.isOpen}) : super(key: key);
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: standardAnimationDuration,
      left: !isOpen ? 66 : -243,
      bottom: !isOpen ? 0 : -224,
      child: Container(
        width: 309,
        height: 330,
        alignment: Alignment.bottomLeft,
        child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              mainAxisExtent: 56,
            ),
            itemCount: speedDialButtons.length,
            itemBuilder: (BuildContext context, int index) {
              var currentButtonData = speedDialButtons[index];
              if (currentButtonData is PlaceHolderSpeedDialItem) {
                return Container(
                  color: Colors.green,
                );
              }
              return SpeedDialButton(
                speedDialItem: currentButtonData,
              );
            }),
      ),
    );
  }
}

class SpeedDialButton extends StatelessWidget {
  const SpeedDialButton({Key? key, required this.speedDialItem})
      : super(key: key);
  final SpeedDialItem speedDialItem;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: speedDialItem.onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                        color: speedDialItem.borderColor, width: 0.5))),
            padding:
                MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
            fixedSize: MaterialStateProperty.resolveWith(
                (states) => const Size(66, 56)),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return speedDialItem.backgroundColor;
            })),
        child: speedDialItem.iconData != null
            ? Icon(
                speedDialItem.iconData,
                color: speedDialItem.contentColor,
              )
            : Text(
                speedDialItem.text!,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: speedDialItem.contentColor),
              ));
  }
}
