import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

/// Displays a list of SampleItems.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapController mapController = MapController();
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onLongPress: addPin,
          center: LatLng(52.286920, 7.6245600), // Kloster Gravenhorst
          zoom: 17,
        ),
        layers: [
          TileLayerOptions(
            maxZoom: 22,
            urlTemplate:
                'https://api.mapbox.com/styles/v1/khalithartmann/ckvs8razh0tfn14o2jutpj34j/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2hhbGl0aGFydG1hbm4iLCJhIjoiY2t2cnpvODhjMnlxZzJ2dGt0cWE4d3BweSJ9.naUoolwn23SAgadMXFKDnA',
            tileProvider: const CachedTileProvider(),
          ),
          MarkerLayerOptions(markers: markers),
        ],
      ),
    );
  }

  void addPin(TapPosition tapPosition, LatLng coordinates) {
    setState(() {
      markers.add(Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(52.319080, 12.744740),
        builder: (ctx) => const Icon(Icons.location_city),
      ));
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
