import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/exhibit/description_container.dart';

import 'image_description.dart';
import 'local_asset.dart';

class RegularExhibitPage extends StatelessWidget {
  const RegularExhibitPage({Key? key, required this.entry}) : super(key: key);

  static const type = 'Regular';

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    assert(entry.assets.length == 1);
    return ListView(
      children: [
        if (entry.description != null)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: const EdgeInsets.only(top: 54),
                child: DescriptionContainer(description: entry.description!)),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: LocalAsset(
            asset: entry.assets.first,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ImageDescriptionText(
              text: entry.assets.first.description,
            ),
          ),
        )
      ],
    );
  }
}
