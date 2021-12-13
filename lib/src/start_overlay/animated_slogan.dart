import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedSlogan extends StatelessWidget {
  const AnimatedSlogan({
    Key? key,
    required this.isExpanded,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final bool isExpanded;
  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedAlign(
          duration: standardAnimationDuration,
          alignment:
              isExpanded ? Alignment.bottomCenter : Alignment.bottomRight,
          child: AnimatedPadding(
            duration: standardAnimationDuration,
            padding: isExpanded
                ? EdgeInsets.zero
                : const EdgeInsets.only(right: 0, bottom: 16),
            child: Transform.scale(
              scale: 0.5,
              child: AnimatedPadding(
                duration: standardAnimationDuration,
                padding: EdgeInsets.only(bottom: isExpanded ? 100 : 0),
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Text(
                        AppLocalizations.of(context)!.startPageH1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.white,
                            fontSize:
                                Theme.of(context).textTheme.button!.fontSize! *
                                        (1 - _controller.value) +
                                    MediaQuery.of(context).size.height * 0.02),
                      );
                    }),
              ),
            ),
          ),
        ));
  }
}
