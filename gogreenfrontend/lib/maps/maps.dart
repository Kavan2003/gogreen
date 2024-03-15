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
    return const Map();
  }
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State createState() => MapState();
}

class MapState extends State<Map> {
  late MaplibreMapController mapController;

  void _onMapCreated(MaplibreMapController controller) {
    mapController = controller;
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

    mapController.addListener(() {
      setState(() {
        // Access zoom level and adjust radius based on zoom (optional)
        print("Zoom level: ${mapController.cameraPosition!.zoom}");
        var zoom = mapController.cameraPosition!.zoom;
        var radiusMeters = 10000; // 10 km in meters

        // Consider additional factors like device pixel density
        var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

        // Minimum radius to prevent very small circles
        var minRadiusPixels = 50.0; // Adjust as needed

        var pixelRatio = 156543.03392 * math.pow(2, zoom);
        var adjustedPixelRatio = pixelRatio * devicePixelRatio;

        // Ensure radius is at least minRadiusPixels
        var circleRadiusPixels =
            math.max(radiusMeters / adjustedPixelRatio, minRadiusPixels);
      });
    });

    _addSymbol();
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GoGreen Maps'),
          backgroundColor: GoGreenColors.primaryColor,
          actions: [
            Row(
              children: [
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                ),
                SizedBox(height: 20),
                FloatingActionButton(
                  child: Icon(Icons.remove),
                  onPressed: () {
                    mapController.moveCamera(
                      CameraUpdate.zoomBy(3),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        body: MaplibreMap(
          onMapCreated: _onMapCreated,
          styleString: "$styleUrl?key=$apiKey",
          myLocationEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(18.992710, 73.110370),
            zoom: 15.0,
          ),
          trackCameraPosition: true,
          zoomGesturesEnabled: false,
        ),
      ),
    );
  }
}
