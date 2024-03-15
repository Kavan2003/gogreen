import 'package:flutter/material.dart';
import 'package:gogreenfrontend/util/constants.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'dart:math' as math; // Use 'as math' for clarity

const apiKey = "m0gQktXfnhkX3o3a3CCr";
const styleUrl = "https://api.maptiler.com/maps/streets-v2/style.json";
void main() {
  runApp(const MapPage());
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapComponent();
  }
}

class MapComponent extends StatefulWidget {
  const MapComponent({super.key});

  @override
  State createState() => MapComponentState();
}

class MapComponentState extends State<MapComponent> {
  late MaplibreMapController mapController;

  void _onMapCreated(MaplibreMapController controller) {
    mapController = controller;

    mapController.addListener(() {
      setState(() {
        print("Zoom level: ${mapController.cameraPosition!.zoom}");
        var zoom = mapController.cameraPosition!.zoom;
        var radiusMeters = 10000; // 10 km in meters

        var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

        var minRadiusPixels = 50.0; // Adjust as needed

        var pixelRatio = 156543.03392 * math.pow(2, zoom);
        var adjustedPixelRatio = pixelRatio * devicePixelRatio;

        var circleRadiusPixels =
            math.max(radiusMeters / adjustedPixelRatio, minRadiusPixels);
      });
    });

    _addSymbol();
  }

  void _onStyleLoaded() {
    _addCircles();
    _addSymbol();
  }

  void _addCircles() {
    var zoom = mapController.cameraPosition!.zoom;
    var radiusMeters = 10000; // 10 km in meters
    var pixelRatio = 156543.03392 * math.pow(2, zoom); // Adjust as needed
    var circleRadiusPixels = (radiusMeters / pixelRatio) + 70;
    print("Circle radius in pixels: $circleRadiusPixels");
    print(
        "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");

    mapController.addCircles([
      CircleOptions(
        geometry: LatLng(18.992711, 73.110371),
        circleRadius: circleRadiusPixels,
        draggable: false,
        circleOpacity: 0.7,
        circleColor: "#FFFFFF",
      ),
      CircleOptions(
        geometry: LatLng(18.997711, 73.110971),
        circleRadius: circleRadiusPixels,
        draggable: false,
        circleOpacity: 0.3,
        circleColor: "#00FF00", // Green
      ),
      CircleOptions(
        geometry: LatLng(18.992711, 73.114371),
        circleRadius: circleRadiusPixels,
        draggable: false,
        circleOpacity: 0.3,
        circleColor: "#0000FF", // Blue
      ),
    ]);
  }

  void _addSymbol() {
    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(18.992910, 73.110370),
        iconImage: "assets/locationpin.png", // replace with your icon
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaplibreMap(
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoaded,
      styleString: "$styleUrl?key=$apiKey",
      myLocationEnabled: true,
      initialCameraPosition: const CameraPosition(
        target: LatLng(18.992710, 73.110370),
        zoom: 15.0,
      ),
      trackCameraPosition: true,
      zoomGesturesEnabled: false,
    );
  }
}
