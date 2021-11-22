import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/keyboard/keyboard_view.dart';
import 'package:gravenhorst_adults_app/src/home/map_view.dart';
import 'package:gravenhorst_adults_app/src/start_overlay/start_overlay_view.dart';

/// Displays a list of SampleItems.
class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerScrimColor: deepOrange,
      backgroundColor: deepOrange,
      body: Stack(
        children: [MapView(), const Keyboard(), const StartOverlayView()],
      ),
    );
  }
}
