import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/exhibit/exhibit_entry_point_page.dart';
import 'package:gravenhorst_adults_app/src/exhibit/selectable_galary_exhibit_page.dart';
import 'package:gravenhorst_adults_app/src/exhibit/swipeable_galary_exhibit_page.dart';

import 'exhibit_app_bar.dart';
import 'regular_exhibit_page.dart';

class ExhibitView extends StatefulWidget {
  const ExhibitView({Key? key, required this.exhibit}) : super(key: key);
  final Exhibit exhibit;

  @override
  State<ExhibitView> createState() => _ExhibitViewState();
}

class _ExhibitViewState extends State<ExhibitView>
    with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late TabController _tabController;
  @override
  void initState() {
    _tabController =
        TabController(length: widget.exhibit.entries.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index != 0 &&
          _audioPlayer.state == PlayerState.PLAYING) {
        _audioPlayer.pause();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ExhibitAppBar(exhibit: widget.exhibit),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                ...widget.exhibit.entries.map((currentEntry) {
                  switch (currentEntry.type) {
                    case ExhibitEntryPointPage.type:
                      return ExhibitEntryPointPage(
                        entry: currentEntry,
                        audioPlayer: _audioPlayer,
                      );

                    case RegularExhibitPage.type:
                      return RegularExhibitPage(entry: currentEntry);

                    case SelectableGalleryExhibitPage.type:
                      return SelectableGalleryExhibitPage(
                        entry: currentEntry,
                      );

                    case SwipeableGalleryExhibit.type:
                      return SwipeableGalleryExhibit(entry: currentEntry);

                    default:
                      throw UnimplementedError(
                          'Exhibit Entry Type not implemented : ${currentEntry.type}');
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
                  controller: _tabController,
                  indicator: const BoxDecoration(color: deepOrange),
                  indicatorWeight: 15,
                  tabs: List.generate(
                      widget.exhibit.entries.length, (index) => Container())),
            ),
          ],
        ),
      ),
    );
  }
}
