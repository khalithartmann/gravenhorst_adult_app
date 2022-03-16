import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/exhibit/description_container.dart';

import 'image_description.dart';
import 'local_asset.dart';
import 'title_text.dart';

class RegularExhibitPage extends StatelessWidget {
  RegularExhibitPage({Key? key, required this.entry}) : super(key: key);

  static const type = 'Regular';

  final Entry entry;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    assert(entry.assets.length <= 1);
    print(entry.assets.first.description);
    return Scrollbar(
      controller: scrollController,
      child: ListView(
        controller: scrollController,
        children: [
          if (entry.title != null)
            Padding(
                padding: EdgeInsets.only(left: 40, top: 60),
                child: Headline3Text(text: entry.title!)),
          if (entry.assets.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: LocalAsset(
                asset: entry.assets.first,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          // if (entry.description != null)
          //   Align(
          //     alignment: Alignment.topCenter,
          //     child: Padding(
          //         padding: const EdgeInsets.only(top: 54),
          //         child: DescriptionContainer(description: entry.description!)),
          //   ),
          if (entry.assets.isNotEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                child: Column(
                  children: [
                    ImageDescriptionText(
                      text: entry.assets.first.description,
                    ),
                    if (entry.assets.first.copyright != null)
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: ImageDescriptionText(
                          text: entry.assets.first.copyright!,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          if (entry.description != null)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: DescriptionContainer(description: entry.description!)),
            ),
        ],
      ),
    );
  }
}
