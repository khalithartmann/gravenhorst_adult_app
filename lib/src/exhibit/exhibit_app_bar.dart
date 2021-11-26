import 'package:flutter/material.dart';
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
      toolbarHeight: 80,
      centerTitle: true,
      leadingWidth: 145,
      leading: Container(
        color: Colors.white,
      ),
      title: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          )),
      actions: [
        Container(
            margin: const EdgeInsets.only(bottom: 12),
            width: 87,
            height: 77,
            child: Center(
                child: Text(exhibit.name,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.white)))),
      ],
    );
  }
}
