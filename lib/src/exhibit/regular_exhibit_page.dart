import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/exhibit/description_container.dart';

import 'local_asset.dart';

class RegularExhibitPage extends StatelessWidget {
  const RegularExhibitPage({Key? key, required this.entry}) : super(key: key);

  static const type = 'regular';

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    assert(entry.assets.length == 1);
    return ListView(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
              padding: const EdgeInsets.only(top: 54),
              child: DescriptionContainer(description: entry.description)),
        ),
        LocalAsset(
          asset: entry.assets.first,
          margin: const EdgeInsets.only(top: 30),
        ),
      ],
    );
  }
}
