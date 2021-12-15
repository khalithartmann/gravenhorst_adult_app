import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:gravenhorst_adults_app/src/exhibit/description_container.dart';
import 'package:gravenhorst_adults_app/src/exhibit/image_description.dart';
import 'package:gravenhorst_adults_app/src/exhibit/local_asset.dart';

class SwipeableGalleryExhibit extends StatelessWidget {
  SwipeableGalleryExhibit({Key? key, required this.entry}) : super(key: key);
  final Entry entry;

  static const type = 'SwipingGallery';

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entry.assets.length,
              itemBuilder: (context, index) {
                var currentAsset = entry.assets[index];
                return Column(
                  children: [
                    LocalAsset(
                      asset: currentAsset,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 85.0),
                      child:
                          ImageDescriptionText(text: currentAsset.description),
                    ),
                  ],
                );
              }),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          left: 5,
          child: buildNavigationButton(
              iconData: Icons.arrow_back,
              onTap: () {
                pageController.previousPage(
                    duration: standardAnimationDuration, curve: standardEasing);
              }),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          right: 5,
          child: buildNavigationButton(
              iconData: Icons.arrow_forward,
              onTap: () {
                pageController.nextPage(
                    duration: standardAnimationDuration, curve: standardEasing);
              }),
        )
      ],
    );
  }

  Widget buildNavigationButton({
    required IconData iconData,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            color: deepOrange,
            boxShadow: [BoxShadow(color: darkGrey, blurRadius: 10)]),
        width: 75,
        height: 60,
        child: Icon(
          iconData,
          size: 37,
          color: Colors.white,
        ),
      ),
    );
  }
}
