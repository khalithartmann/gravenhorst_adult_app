import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';

class DescriptionContainer extends StatelessWidget {
  const DescriptionContainer({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        description,
        style: Theme.of(context).textTheme.headline5!.copyWith(
            color: darkGrey, fontWeight: FontWeight.w300, height: 1.2),
      ),
    );
  }
} 
