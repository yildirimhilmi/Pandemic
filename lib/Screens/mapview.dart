import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

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
          options: new MapOptions(minZoom: 10.0),
          layers: [
            new TileLayerOptions(urlTemplate: "https."),
          ],
        ),
      ),
    );
  }
}
