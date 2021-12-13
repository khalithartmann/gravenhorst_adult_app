import 'package:flutter/material.dart';
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

class _StartOverlayViewState extends State<StartOverlayView>
    with TickerProviderStateMixin {
  bool isExpanded = true;
  late final AnimationController _controller = AnimationController(
    duration: standardAnimationDuration,
    vsync: this,
  );

  @override
  void initState() {
    context.read<ExhibitoinDataController>().addListener(() {
      final exhibitionDataController = context.read<ExhibitoinDataController>();
      var isLoaded =
          exhibitionDataController.exhibitionDataForCurrentLocale != null;

      logger.i("this is it ${exhibitionDataController.state}");
      if (exhibitionDataController.state ==
          ExhibitoinDataControllerState.downloadingExhibitionData) {
        print('closing overlay');
        setState(() {
          isExpanded = true;
        });
      } else if (exhibitionDataController.exhibitionDataList.isEmpty) {
        setState(() {
          isExpanded = true;
        });
      }

      print('isExpanded $isExpanded');
      if (!isExpanded) {
        _controller.animateTo((MediaQuery.of(context).size.height - 130) /
            MediaQuery.of(context).size.height);
      } else {
        _controller.animateTo(0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
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
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(
              0, -(MediaQuery.of(context).size.height * _controller.value)),
          child: child,
        );
      },
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
          ? AnimatedSlogan(isExpanded: isExpanded, controller: _controller)
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
          padding: const EdgeInsets.only(top: 30),
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: IconButton(
          onPressed: () {
            if (isExpanded) {
              _controller.animateTo((MediaQuery.of(context).size.height - 130) /
                  MediaQuery.of(context).size.height);
            } else {
              _controller.animateTo(0);
            }
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          icon: AnimatedRotation(
            turns: isExpanded ? 0 : (180 / 360),
            duration: standardAnimationDuration,
            child: Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
        // icon: AnimatedBuilder(
        //   child: const Icon(Icons.arrow_upward, color: Colors.white),
        //   animation: _controller,
        //   builder: (context, child) {
        //     return Transform.rotate(
        //       angle: ((180 * 1.2) * _controller.value) * math.pi / 180,
        //       child: child,
        //     );
        //   },
        // )),
      ),
    );
  }

  AnimatedAlign buildLogo() {
    return AnimatedAlign(
      duration: standardAnimationDuration,
      alignment: isExpanded ? Alignment.centerLeft : Alignment.bottomLeft,
      child: const SizedBox(
          height: 77,
          width: 121,
          child: Icon(
            Icons.circle,
            color: Colors.white,
            size: 40,
          )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
