import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  MapView({Key? key}) : super(key: key);
  static const _mapZoom = 18.0;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ExhibitoinDataController>(builder: (context, consumer, _) {
      var markers = consumer.exhibitionDataForCurrentLocale?.tours
          .map((tour) => tour.locations)
          .expand((element) => element)
          .map((location) => Marker(
              point: LatLng(double.parse(location.latitude),
                  double.parse(location.longitude)),
              builder: (context) =>
                  Container(width: 50, height: 50, color: Colors.red)))
          .toList();

      return AbsorbPointer(
        absorbing: false,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: LatLng(52.286920, 7.6245600), // Kloster Gravenhorst
            zoom: MapView._mapZoom,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/framegrabber/ckw0fy0za8roo14pljrdqjfrl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZnJhbWVncmFiYmVyIiwiYSI6ImNrdzBmbjB4OWRhczMybnM3ZTV3N2I3NnMifQ.h0kT3DdBKoMP6NFLvAsVEw',
              tileProvider: const CachedTileProvider(),
            ),
            MarkerLayerOptions(markers: markers ?? []),
          ],
        ),
      );
    });
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
