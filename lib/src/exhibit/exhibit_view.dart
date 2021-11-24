import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:location/location.dart';

class ExhibitView extends StatelessWidget {
  const ExhibitView({Key? key, required this.exhibit}) : super(key: key);
  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 137,
        leading: Container(
          width: 121,
          height: 77,
          color: Colors.white,
        ),
      ),
    );
  }
}
