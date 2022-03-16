import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';

class Headline2Text extends StatelessWidget {
  const Headline2Text({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline2!
          .copyWith(color: darkGrey, fontWeight: FontWeight.normal, height: 1),
    );
  }
}

class Headline3Text extends StatelessWidget {
  const Headline3Text({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(color: darkGrey, fontWeight: FontWeight.normal, height: 1),
    );
  }
}

class Headline4Text extends StatelessWidget {
  const Headline4Text({
    Key? key,
    required this.text,
    this.color = darkGrey,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: color, fontWeight: FontWeight.normal, height: 1),
    );
  }
}
