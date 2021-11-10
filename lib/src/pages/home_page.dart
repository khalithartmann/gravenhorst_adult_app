import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:latlong2/latlong.dart' as ltlng;
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'dart:math' as math;

/// Displays a list of SampleItems.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  MapController mapController = MapController();
  List<Marker> markers = [];
  bool isExpanded = true;
  static const _mapZoom = 18.0;

  late final AnimationController _controller = AnimationController(
    duration: standardAnimationDuration,
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: true,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onLongPress: addPin,
                center:
                    ltlng.LatLng(52.286920, 7.6245600), // Kloster Gravenhorst
                zoom: _mapZoom,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/khalithartmann/ckvs8razh0tfn14o2jutpj34j/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2hhbGl0aGFydG1hbm4iLCJhIjoiY2t2cnpvODhjMnlxZzJ2dGt0cWE4d3BweSJ9.naUoolwn23SAgadMXFKDnA',
                  tileProvider: const CachedTileProvider(),
                ),
                MarkerLayerOptions(markers: markers),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CustomPaint(
                    painter: OverlayWithHolePainter(),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 54),
                            child: Transform.rotate(
                              angle: 270 * math.pi / 180,
                              child: Text(
                                'Kunsthaus\nKloster\nGravenhorst',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          Column(
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedAlign(
                  duration: standardAnimationDuration,
                  alignment: isExpanded
                      ? Alignment.bottomCenter
                      : Alignment.bottomRight,
                  child: AnimatedBuilder(
                    animation: _controller,
                    child: AnimatedPadding(
                      duration: standardAnimationDuration,
                      padding: EdgeInsets.only(bottom: isExpanded ? 100 : 0),
                      child: Container(
                        child: Text(
                          'Reisen durch\nRaum und Zeit',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          MediaQuery.of(context).size.width /
                              3.5 *
                              _controller.value,
                          30 * _controller.value,
                        ),
                        child: Transform.scale(
                            scale: 1 - (_controller.value * 0.8), child: child),
                      );
                      // scale: 1 - (_controller.value * 0.8), child: child);
                    },
                  ),
                ),
                logo(),
                arrowIconButton(context),
              ],
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: Offset(0,
                    -(MediaQuery.of(context).size.height * _controller.value)),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget arrowIconButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IconButton(
          onPressed: () {
            if (isExpanded) {
              print((MediaQuery.of(context).size.height - 137) /
                  MediaQuery.of(context).size.height);
              _controller.animateTo((MediaQuery.of(context).size.height - 137) /
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
    );
  }

  AnimatedAlign logo() {
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

  void addPin(TapPosition tapPosition, ltlng.LatLng coordinates) {
    setState(() {
      markers.add(Marker(
        width: 30.0,
        height: 30.0,
        point: ltlng.LatLng(52.319080, 12.744740),
        builder: (ctx) => const Icon(Icons.location_city),
      ));
    });
  }

  double appBarHeight(BuildContext context) {
    if (isExpanded) {
      return MediaQuery.of(context).size.height;
    } else {
      return 137;
    }
  }
}

class CachedTileProvider extends TileProvider {
  const CachedTileProvider();
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(
      getTileUrl(coords, options),
      //Now you can set options that determine how the image gets cached via whichever plugin you use.
    );
  }
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addOval(Rect.fromCircle(
                center: Offset(size.width / 2, size.height / 2 - 10),
                radius: 38.5))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
