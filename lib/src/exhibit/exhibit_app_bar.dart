import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/assets.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';

class ExhibitAppBar extends StatelessWidget {
  const ExhibitAppBar({
    Key? key,
    required this.exhibit,
  }) : super(key: key);

  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: double.infinity,
      centerTitle: true,
      leadingWidth: 145,
      leading: Center(
        child: Image.asset(
          logoPath,
          width: 84,
          height: 53,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: RotationTransition(
                turns: const AlwaysStoppedAnimation(270 / 360),
                child: Image.asset(
                  arrowIconPath,
                  width: 20,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                exhibit.name,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontSize: 75,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
              ),
            ),
          ),
        ],
      ),
      actions: [],
    );
  }
}
