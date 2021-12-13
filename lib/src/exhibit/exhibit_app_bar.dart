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
      toolbarHeight: double.infinity,
      centerTitle: true,
      leadingWidth: 145,
      leading: Center(
        child: Text("logo"),
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
        Padding(
          padding: EdgeInsets.only(right: 30),
          child: Text(
            exhibit.name,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
