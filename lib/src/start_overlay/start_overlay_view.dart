import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/assets.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:math' as math;

import 'package:provider/provider.dart';

import 'animated_slogan.dart';
import 'exhibition_data_download_indicator.dart';
import 'supported_locales_list.dart';

class StartOverlayView extends StatefulWidget {
  const StartOverlayView({Key? key}) : super(key: key);

  @override
  State<StartOverlayView> createState() => _StartOverlayViewState();
}

class _StartOverlayViewState extends State<StartOverlayView> {
  bool isExpanded = true;

  @override
  void initState() {
    context.read<ExhibitoinDataController>().addListener(() {
      final exhibitionDataController = context.read<ExhibitoinDataController>();
      var isLoaded =
          exhibitionDataController.exhibitionDataForCurrentLocale != null;

      logger.i("this is it ${exhibitionDataController.state}");
      if (exhibitionDataController.state ==
          ExhibitoinDataControllerState.downloadingExhibitionData) {
        setState(() {
          isExpanded = true;
        });
      } else if (exhibitionDataController.exhibitionDataList.isEmpty) {
        setState(() {
          isExpanded = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: standardAnimationDuration,
      bottom: isExpanded
          ? 0
          : MediaQuery.of(context).size.height -
              (80 + MediaQuery.of(context).padding.top),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(children: [
        buildBackgroundWithHole(context),
        buildHeadline2(context),
        buildHeadline1(context),
        buildLogo(),
        buildArrowIconButton(context),
        context.watch<ExhibitoinDataController>().state ==
                ExhibitoinDataControllerState.downloadingExhibitionData
            ? const ExhibitionDataDownloadIndicator()
            : Container()
      ]),
    );
  }

  Widget buildHeadline1(BuildContext context) {
    var exhibitionController = context.watch<ExhibitoinDataController>();
    var isReady =
        exhibitionController.state == ExhibitoinDataControllerState.ready;
    var exhibitionDataForCurrentLocaleLoaded =
        exhibitionController.exhibitionDataIsLoadedForLocale;

    if (!isReady) {
      return const Center(
          child: CircularProgressIndicator(
        color: deepOrange,
      ));
    }

    return AnimatedSwitcher(
      duration: standardAnimationDuration,
      child: exhibitionDataForCurrentLocaleLoaded || !isExpanded
          ? AnimatedSlogan(isExpanded: isExpanded)
          : SupportedLocalesList(),
    );
  }

  SizedBox buildBackgroundWithHole(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        painter: OverlayWithHolePainter(),
      ),
    );
  }

  Widget buildHeadline2(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 36),
          child: Transform.rotate(
            angle: 270 * math.pi / 180,
            child: Text(
              AppLocalizations.of(context)!.startPageH2,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildArrowIconButton(BuildContext context) {
    var exhibitionController = context.watch<ExhibitoinDataController>();

    if (!exhibitionController.localeSelected ||
        (exhibitionController.exhibitionDataList.isEmpty && isExpanded)) {
      return Container();
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedPadding(
        duration: standardAnimationDuration,
        padding: EdgeInsets.only(bottom: isExpanded ? 30 : 12),
        child: IconButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          icon: AnimatedRotation(
            turns: isExpanded ? 0 : (180 / 360),
            duration: standardAnimationDuration,
            child: Image.asset(
              arrowIconPath,
              width: 20,
              height: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo() {
    return AnimatedAlign(
      duration: standardAnimationDuration,
      alignment: isExpanded ? Alignment.centerLeft : Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 35, bottom: 10),
        width: 84,
        height: 53,
        child: Image.asset(
          logoPath,
          width: 84,
          height: 53,
        ),
      ),
    );
  }
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = deepOrange;
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addOval(Rect.fromCircle(
                center: Offset(size.width / 2, size.height / 2), radius: 38.5))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
