import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';

import 'description_container.dart';
import 'local_asset.dart';

class SelectableGalleryExhibitPage extends StatefulWidget {
  const SelectableGalleryExhibitPage({Key? key, required this.entry})
      : super(key: key);

  final Entry entry;

  static const type = 'selectingGallery';

  @override
  State<SelectableGalleryExhibitPage> createState() =>
      _SelectableGalleryExhibitPageState();
}

class _SelectableGalleryExhibitPageState
    extends State<SelectableGalleryExhibitPage> {
  late List<Asset> assets;
  late Asset selectdAsset;

  @override
  void initState() {
    super.initState();
    assets = widget.entry.assets;
    selectdAsset = assets.first;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
              padding: const EdgeInsets.only(top: 54),
              child:
                  DescriptionContainer(description: widget.entry.description)),
        ),
        LocalAsset(
          asset: selectdAsset,
          margin: const EdgeInsets.only(top: 30),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 300,
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              selectdAsset.description,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w300),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 40),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ...assets.map((asset) => InkWell(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectdAsset = asset;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        color: asset == selectdAsset ? darkGrey : Colors.white,
                        width: 105,
                        height: 70,
                        child: Center(
                          child: Text(
                            asset.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: asset == selectdAsset
                                        ? Colors.white
                                        : darkGrey,
                                    height: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}