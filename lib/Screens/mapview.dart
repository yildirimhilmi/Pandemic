import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as location;

String url =
    "https://api.mapbox.com/styles/v1/hcy043/ckjvq77lw01ub17pupqcjzgtr/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGN5MDQzIiwiYSI6ImNranZvdWJ0dDBhZmQybmxzMG11ZWQ3bnQifQ.XUx00U-uMD-CA50qU5aN9w";

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Maps example app'),
        ),
        body: FlutterMap(
          options: new MapOptions(
            center: new location.LatLng(41.015137, 28.979530),
            minZoom: 10,
          ),
          layers: [
            new TileLayerOptions(urlTemplate: url),
          ],
        ),
      ),
    );
  }
}
