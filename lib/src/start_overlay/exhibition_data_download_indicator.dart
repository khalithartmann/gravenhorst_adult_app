import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ExhibitionDataDownloadIndicator extends StatelessWidget {
  const ExhibitionDataDownloadIndicator({Key? key}) : super(key: key);

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
            offset: const Offset(0, -5),
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
                  StreamBuilder(
                      stream: context
                          .read<ExhibitoinDataController>()
                          .downloadProgressStream,
                      builder: (context, AsyncSnapshot<int> snapshot) {
                        var percent = 0.0;
                        if (snapshot.data != null && snapshot.hasData) {
                          percent = snapshot.data! / 100;
                        }
                        return LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width,
                          lineHeight: 11,
                          percent: percent,
                          linearStrokeCap: LinearStrokeCap.butt,
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          progressColor: deepOrange,
                        );
                      }),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
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
                              style: const TextStyle(
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
