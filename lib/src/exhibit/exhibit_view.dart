import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/exhibit/exhibit_entry_point_page.dart';
import 'package:gravenhorst_adults_app/src/exhibit/selectable_galary_exhibit_page.dart';
import 'package:gravenhorst_adults_app/src/exhibit/swipeable_galary_exhibit_page.dart';

import 'exhibit_app_bar.dart';
import 'regular_exhibit_page.dart';

class ExhibitView extends StatelessWidget {
  const ExhibitView({Key? key, required this.exhibit}) : super(key: key);
  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: exhibit.entries.length,
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: ExhibitAppBar(exhibit: exhibit),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              TabBarView(
                children: [
                  ...exhibit.entries.map((currentEntry) {
                    switch (currentEntry.type) {
                      case ExhibitEntryPointPage.type:
                        return ExhibitEntryPointPage(entry: currentEntry);

                      case RegularExhibitPage.type:
                        return RegularExhibitPage(entry: currentEntry);

                      case SelectableGalleryExhibitPage.type:
                        return SelectableGalleryExhibitPage(
                          entry: currentEntry,
                        );

                      case SwipeableGalleryExhibit.type:
                        return SwipeableGalleryExhibit(entry: currentEntry);

                      default:
                        return Center(
                            child: Text(
                                'Exhibit Entry Type not implemented : ${currentEntry.type}'));
                    }
                  }).toList(),
                ],
              ),
              Container(
                height: 7.5,
                color: Colors.white,
              ),
              SizedBox(
                height: 15,
                child: TabBar(
                    indicator: const BoxDecoration(color: deepOrange),
                    indicatorWeight: 15,
                    tabs: List.generate(
                        exhibit.entries.length, (index) => Container())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
