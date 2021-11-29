import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:provider/provider.dart';

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
        AnimatedPositioned(
            duration: standardAnimationDuration,
            left: !isOpen ? 66 : -243,
            // left: 66,
            bottom: !isOpen ? 0 : -380,
            child: SpeedDial()),
        LocaleSelector(
            isOpen: isOpen, exhibitionDataController: exhibitionDataController),
        _MenuButton(
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
  const SpeedDial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 309,
      height: 330,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
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
            fixedSize:
                MaterialStateProperty.resolveWith((states) => Size(66, 56)),
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
            ? -1 * (exhibitionDataController.supportedLocales.length * 56)
            : 56,
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
                                (states) => Size(66, 56)),
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

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )),
            padding:
                MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
            fixedSize:
                MaterialStateProperty.resolveWith((states) => Size(66, 56)),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => deepOrange)),
        onPressed: onPressed,
        child: Icon(Icons.menu),
      ),
    );
  }
}
