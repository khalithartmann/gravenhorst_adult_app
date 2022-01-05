import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gravenhorst_adults_app/src/core/assets.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:gravenhorst_adults_app/src/exhibit/exhibit_view.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController mapController = MapController();
  static const mapZoom = 19.0;
  @override
  Widget build(BuildContext context) {
    return Selector<ExhibitoinDataController, ExhibitionData?>(
        selector: (context, controller) =>
            controller.exhibitionDataForCurrentLocale,
        builder: (context, exhibitionData, _) {
          var markers = generateMarkersList(exhibitionData);

          return AbsorbPointer(
            absorbing: false,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                interactiveFlags: InteractiveFlag.pinchZoom,

                bounds: LatLngBounds(
                    LatLng(52.288301, 7.622590), LatLng(52.286005, 7.626735)),
                boundsOptions: const FitBoundsOptions(
                    padding: EdgeInsets.zero, inside: true),
                minZoom: 17,
                maxZoom: 19,

                // center: LatLng(52.286920, 7.6245600), // Kloster Gravenhorst
                zoom: 17,
              ),
              layers: [
                TileLayerOptions(
                  maxNativeZoom: 19,
                  minNativeZoom: 17,
                  maxZoom: 19,
                  minZoom: 17,

                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/framegrabber/ckw0fy0za8roo14pljrdqjfrl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZnJhbWVncmFiYmVyIiwiYSI6ImNrdzBmbjB4OWRhczMybnM3ZTV3N2I3NnMifQ.h0kT3DdBKoMP6NFLvAsVEw',
                  // tileProvider: const CachedTileProvider(),
                ),
                MarkerLayerOptions(
                  markers: markers ?? [],
                ),
              ],
            ),
          );
        });
  }

  List<Marker>? generateMarkersList(ExhibitionData? exhibitionData) {
    if (exhibitionData == null) {
      return [];
    }
    var markers = exhibitionData.tours
        .map((tour) => tour.exhibits)
        .expand((element) => element)
        .map(
          (exhibit) => Marker(
              height: 72,
              width: 54,
              point: LatLng(double.parse(exhibit.latitude),
                  double.parse(exhibit.longitude)),
              builder: (context) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExhibitView(
                                exhibit: exhibit,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: hexToColor(exhibit.markerColor),
                          boxShadow: const [
                            BoxShadow(blurRadius: 10, color: Colors.black)
                          ]),
                      height: 72,
                      width: 54,
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6, bottom: 3),
                        child: Text(
                          exhibit.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )),
        )
        .toList();

    markers
      ..insert(
          0,
          Marker(
              point: LatLng(52.286438, 7.623414),
              builder: (context) => Image.asset(danceFloor)))
      ..insert(
          0,
          Marker(
              point: LatLng(52.286405, 7.624301),
              builder: (context) => Image.asset(himmelsTisch)));

    return markers;
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
