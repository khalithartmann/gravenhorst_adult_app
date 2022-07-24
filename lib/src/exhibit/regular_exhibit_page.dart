import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/exhibit/description_container.dart';

import 'media_view/media_view.dart';
import 'title_text.dart';

class RegularExhibitPage extends StatelessWidget {
  RegularExhibitPage({Key? key, required this.entry}) : super(key: key);

  static const type = 'Regular';

  final Entry entry;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    assert(entry.assets.length <= 1);

    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            if (entry.title != null)
              Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Headline3Text(text: entry.title!))),
            if (entry.assets.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: MediaView(
                  asset: entry.assets.first,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            if (entry.description != null)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child:
                        DescriptionContainer(description: entry.description!)),
              ),
          ],
        ),
      ),
    );
  }
}
