import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:provider/src/provider.dart';

class SupportedLocalesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final exhibitionController = context.read<ExhibitoinDataController>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 103.0, left: 40, right: 40),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            ...exhibitionController.supportedLocales.map((locale) => InkWell(
                onTap: () {
                  context
                      .read<ExhibitoinDataController>()
                      .onLanguageSelected(locale: locale);
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
    );
  }
}
