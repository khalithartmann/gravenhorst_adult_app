import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';

class ImageDescriptionText extends StatelessWidget {
  const ImageDescriptionText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w300, color: darkGrey),
      ),
    );
  }
}
