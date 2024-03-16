import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gogreenfrontend/util/constants.dart';
import 'package:gogreenfrontend/util/govapi.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'dart:math' as math; // Use 'as math' for clarity

const apiKey = "m0gQktXfnhkX3o3a3CCr";
const styleUrl = "https://api.maptiler.com/maps/streets-v2/style.json";

class MapComponent extends StatefulWidget {
  List<ApiQualityarea> qualityarea;
  MapComponent(this.qualityarea, {super.key});

  @override
  State createState() => MapComponentState();
}

class MapComponentState extends State<MapComponent> {
  late MaplibreMapController mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('initState');
    log('Station: ${widget.qualityarea[0].station}');
    // for (var area in widget.qualityarea) {
    //   print('Station: ${area.station}');
    // }
  }

  void _onMapCreated(MaplibreMapController controller) {
    mapController = controller;

    mapController.addListener(() {
      setState(() {});
    });

    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    _addCircles();
    _addSymbol();
  }

  void _addCircles() {
    var circleRadiusPixels = 10.00;

    for (var area in widget.qualityarea) {
      var airQuality = AirQuality(
        co: area.pollutant_co ?? '',
        nh3: area.pollutant_nh3 ?? '',
        ozone: area.pollutant_ozone ?? '',
        pm10: area.pollutant_pm10 ?? '',
        pm2_5: area.pollutant_pm2_5 ?? '',
        so2: area.pollutant_so2 ?? '',
      );

      var color = airQuality.airQuality;

      mapController.addCircle(
        CircleOptions(
          geometry:
              LatLng(double.parse(area.latitude), double.parse(area.longitude)),
          circleRadius: circleRadiusPixels,
          draggable: false,
          circleOpacity: 0.5,
          circleColor: color,
        ),
      );
    }
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
        zoom: 0.0,
      ),
      trackCameraPosition: true,
      zoomGesturesEnabled: true,
    );
  }
}
