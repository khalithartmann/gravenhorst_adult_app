import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedSlogan extends StatelessWidget {
  const AnimatedSlogan({
    Key? key,
    required this.isExpanded,
  }) : super(key: key);

  final bool isExpanded;

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
            padding: EdgeInsets.only(
                bottom: isExpanded ? 90 : 20, right: isExpanded ? 0 : 20),
            child: AnimatedDefaultTextStyle(
              style: isExpanded
                  ? Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white, height: 1.1)
                  : Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
              duration: standardAnimationDuration,
              child: Text(
                AppLocalizations.of(context)!.startPageH1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
