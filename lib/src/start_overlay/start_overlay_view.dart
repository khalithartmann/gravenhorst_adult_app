import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_locale.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Stack(
        children: [
          buildBackgroundWithHole(context),
          buildHeadline2(context),
          buildHeadline1(context),
          buildLogo(),
          buildArrowIconButton(context),
          // const ExhibitionDataDownloadIndicator(),
        ],
      ),
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
    return Consumer<ExhibitoinDataController>(builder: (context, consumer, _) {
      if (consumer.state != ExhibitoinDataControllerState.ready) {
        return Center(
            child: const CircularProgressIndicator(
          color: deepOrange,
        ));
      }
      return consumer.failureOrSupportedLocales.fold(
          (l) => Container(),
          (supportedLocales) => Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(bottom: 86.0, left: 40, right: 40),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      ...supportedLocales.map((locale) => InkWell(
                          onTap: () {
                            context
                                .read<ExhibitoinDataController>()
                                .getExhibitionDataForLocale(
                                    localeId: locale.id);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
                              child: Text(
                                locale.id.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: Colors.white),
                              ))))
                    ],
                  ),
                ),
              ));
    });
    return AnimatedAlign(
      duration: standardAnimationDuration,
      alignment: isExpanded ? Alignment.bottomCenter : Alignment.bottomRight,
      child: AnimatedPadding(
        duration: standardAnimationDuration,
        padding: isExpanded
            ? EdgeInsets.zero
            : const EdgeInsets.only(right: 32, bottom: 16),
        child: AnimatedBuilder(
          animation: _controller,
          child: AnimatedPadding(
            duration: standardAnimationDuration,
            padding: EdgeInsets.only(bottom: isExpanded ? 100 : 0),
            child: Text(
              AppLocalizations.of(context)!.startPageH1,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
          ),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                MediaQuery.of(context).size.width / 3.5 * _controller.value,
                30 * _controller.value,
              ),
              child: Transform.scale(
                  scale: 1 - (_controller.value * 0.8), child: child),
            );
            // scale: 1 - (_controller.value * 0.8), child: child);
          },
        ),
      ),
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
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildArrowIconButton(BuildContext context) {
    if (!context.watch<ExhibitoinDataController>().localeSelected) {
      return Container();
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: IconButton(
            onPressed: () {
              if (isExpanded) {
                _controller.animateTo(
                    (MediaQuery.of(context).size.height - 137) /
                        MediaQuery.of(context).size.height);
              } else {
                _controller.animateTo(0);
              }
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            icon: AnimatedBuilder(
              child: const Icon(Icons.arrow_upward, color: Colors.white),
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: ((180 * 1.2) * _controller.value) * math.pi / 180,
                  child: child,
                );
              },
            )),
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

class ExhibitionDataDownloadIndicator extends StatefulWidget {
  const ExhibitionDataDownloadIndicator({Key? key}) : super(key: key);

  @override
  State<ExhibitionDataDownloadIndicator> createState() =>
      _ExhibitionDataDownloadIndicatorState();
}

class _ExhibitionDataDownloadIndicatorState
    extends State<ExhibitionDataDownloadIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 180,
        decoration: BoxDecoration(color: deepOrange, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ]),
        // color: Colors.blue,
        child: Container(
          color: lightGrey,
          child: Stack(
            children: [
              Material(
                color: Colors.transparent,
                elevation: 5,
                child: Container(
                  height: 11,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  LinearProgressIndicator(
                    value: controller.value,
                    color: deepOrange,
                    backgroundColor: Colors.transparent,
                    minHeight: 22,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.downloading,
                          color: darkGrey,
                          size: 30,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              AppLocalizations.of(context)!.downloadingHint,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 32,
                                  color: darkGrey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
