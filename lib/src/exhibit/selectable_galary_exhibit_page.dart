import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:gravenhorst_adults_app/src/exhibit/image_description.dart';
import 'package:gravenhorst_adults_app/src/exhibit/title_text.dart';

import 'description_container.dart';
import 'local_asset.dart';

class SelectableGalleryExhibitPage extends StatefulWidget {
  const SelectableGalleryExhibitPage({Key? key, required this.entry})
      : super(key: key);

  final Entry entry;

  static const type = 'SelectingGallery';

  @override
  State<SelectableGalleryExhibitPage> createState() =>
      _SelectableGalleryExhibitPageState();
}

class _SelectableGalleryExhibitPageState
    extends State<SelectableGalleryExhibitPage> {
  late List<Asset> assets;
  late Asset selectdAsset;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    assets = widget.entry.assets;
    selectdAsset = assets.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            if (widget.entry.title != null)
              SizedBox(
                width: screenWidth(context) * 0.8,
                child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Headline3Text(text: widget.entry.title!)),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: LocalAsset(
                asset: selectdAsset,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 40),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 2,
                spacing: 2,
                children: [
                  ...assets
                      .where((element) => element.title != null)
                      .map((asset) {
                    final isFirst = asset == assets.first;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectdAsset = asset;
                          print(
                              "selected asset is ${selectdAsset.assetUrlLocalPath}");
                        });
                      },
                      child: Container(
                        color: asset == selectdAsset ? darkGrey : Colors.white,
                        height: 70,
                        padding: const EdgeInsets.all(4),
                        width: isFirst && (assets.length % 2 == 1)
                            ? screenWidth(context) * 0.9
                            : screenWidth(context) * 0.45,
                        child: Center(
                          child: Text(
                            asset.title!,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: asset == selectdAsset
                                        ? Colors.white
                                        : darkGrey,
                                    height: 1.5),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            if (widget.entry.description != null)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: const EdgeInsets.only(top: 54),
                    child: DescriptionContainer(
                        description: widget.entry.description!)),
              ),
            const Padding(padding: EdgeInsets.only(bottom: 50))
          ],
        ),
      ),
    );
  }
}
