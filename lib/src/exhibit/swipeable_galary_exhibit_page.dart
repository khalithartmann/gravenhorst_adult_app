import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:gravenhorst_adults_app/src/exhibit/description_container.dart';
import 'package:gravenhorst_adults_app/src/exhibit/image_description.dart';
import 'package:gravenhorst_adults_app/src/exhibit/local_asset.dart';

class SwipeableGalleryExhibit extends StatefulWidget {
  SwipeableGalleryExhibit({Key? key, required this.entry}) : super(key: key);
  final Entry entry;

  static const type = 'SwipingGallery';

  @override
  State<SwipeableGalleryExhibit> createState() =>
      _SwipeableGalleryExhibitState();
}

class _SwipeableGalleryExhibitState extends State<SwipeableGalleryExhibit> {
  var stackIndex = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: screenHeight(context),
            child: IndexedStack(
              index: stackIndex.toInt(),
              children: [
                ...widget.entry.assets.map((asset) => Column(
                      children: [
                        LocalAsset(
                          asset: asset,
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 85.0),
                          child: ImageDescriptionText(text: asset.copyright!),
                        ),
                      ],
                    ))
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 130, left: 30, right: 30),
          child: SliderTheme(
            data: SliderThemeData(
                trackHeight: 3,
                thumbShape: CustomSliderThumbRect(
                    max: widget.entry.assets.length - 1,
                    min: 0,
                    thumbHeight: 20,
                    thumbRadius: 0)),
            child: Slider(
                thumbColor: Colors.white,
                activeColor: Colors.white,
                value: stackIndex.toDouble(),
                min: 0,
                divisions: widget.entry.assets.length - 1,
                max: widget.entry.assets.length.toDouble() - 1,
                onChanged: (val) {
                  setState(() {
                    stackIndex = val;
                  });
                }),
          ),
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

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final int min;
  final int max;

  const CustomSliderThumbRect({
    required this.thumbRadius,
    required this.thumbHeight,
    required this.min,
    required this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.9, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = sliderTheme.activeTrackColor! //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: sliderTheme.thumbColor,
            height: 1),
        text: '${getValue(value)}');
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
