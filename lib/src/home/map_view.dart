import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:gravenhorst_adults_app/src/exhibit/exhibit_view.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController mapController = MapController();
  static const mapZoom = 19.0;

  @override
  void initState() {
    _requestLocationPermission();

    super.initState();
  }

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
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                nePanBoundary: LatLng(52.288423, 7.627318),
                swPanBoundary: LatLng(52.286176599309876, 7.622755794605564),
                plugins: [
                  MarkerClusterPlugin(),
                ],

                center: LatLng(52.286542, 7.623975),
                // bounds: LatLngBounds(
                //     LatLng(postionSnapshot.data!.latitude,
                //         postionSnapshot.data!.longitude),
                //     LatLng(postionSnapshot.data!.latitude,
                //         postionSnapshot.data!.longitude)),
                boundsOptions: const FitBoundsOptions(
                    padding: EdgeInsets.zero, inside: true),
                minZoom: 17,
                maxZoom: 19.5,

                zoom: 18.5,
              ),
              children: [
                TileLayerWidget(
                    options: TileLayerOptions(
                  maxNativeZoom: 19.5,
                  minNativeZoom: 17,
                  maxZoom: 19.5,
                  minZoom: 17,
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/framegrabber/ckw0fy0za8roo14pljrdqjfrl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZnJhbWVncmFiYmVyIiwiYSI6ImNrdzBmbjB4OWRhczMybnM3ZTV3N2I3NnMifQ.h0kT3DdBKoMP6NFLvAsVEw',
                  // tileProvider: const CachedTileProvider(),
                )),

                LocationMarkerLayerWidget(
                  options: LocationMarkerLayerOptions(
                    showHeadingSector: true,
                  ),
                ), // <-- add layer widget here
                MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                  maxClusterRadius: 60,
                  disableClusteringAtZoom: 23,
                  size: const Size(54, 72),
                  zoomToBoundsOnClick: false,
                  markers: markers ?? [],
                  spiderfyCircleRadius: 50,
                  builder: (context, markers) {
                    return StandardMarker(
                      color: deepOrange,
                      text: '${markers.length.toString()}+',
                      textAlignment: Alignment.topLeft,
                    );
                  },
                )),
              ],
            ),
          );
        });
  }

  /// Request location permission for device
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Geolocator.getPositionStream(
    //         locationSettings:
    //             const LocationSettings(accuracy: LocationAccuracy.lowest))
    //     .listen((event) {
    //   print(event);
    //   mapController.move(
    //       LatLng(event.latitude, event.longitude), mapController.zoom);
    // });
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
                    child: StandardMarker(
                      color: hexToColor(exhibit.markerColor),
                      text: exhibit.name,
                    ),
                  )),
        )
        .toList();

    // insert dance floor icon as marker

    return markers;
  }
}

class StandardMarker extends StatelessWidget {
  const StandardMarker({
    Key? key,
    required this.color,
    required this.text,
    this.textAlignment = Alignment.bottomRight,
  }) : super(key: key);
  final Color color;
  final String text;
  final Alignment textAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black)]),
      height: 72,
      width: 54,
      alignment: textAlignment,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Colors.white, fontWeight: FontWeight.w400, height: 0.8),
        ),
      ),
    );
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
