import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as location;
import 'package:my_website_project/screenComponents/cardView.dart';

location.LatLng istanbul = new location.LatLng(41.015137, 28.979530);
location.LatLng istanbul2 = new location.LatLng(41.015137, 28.979530);
double zoomLevel = 7;
location.LatLng istanbul3 = new location.LatLng(41.025137, 28.979530);
location.LatLng istanbul4 = new location.LatLng(41.015137, 28.979530);
String url =
    "https://api.mapbox.com/styles/v1/hcy043/ckjvsqnfk05r717p9o4dp4stq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGN5MDQzIiwiYSI6ImNranZvdWJ0dDBhZmQybmxzMG11ZWQ3bnQifQ.XUx00U-uMD-CA50qU5aN9w";

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  var points = <location.LatLng>[istanbul, istanbul2, istanbul3, istanbul4];
  MapController mapController;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    mapController = globalMapController;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: new MapOptions(
        center: new location.LatLng(41.015137, 28.979530),
        minZoom: zoomLevel,
      ),
      layers: [
        new TileLayerOptions(urlTemplate: url),
        new PolygonLayerOptions(polygons: [
          new Polygon(
            points: points,
            borderStrokeWidth: 20,
            color: Colors.red,
            borderColor: Colors.red,
          )
        ]),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 20.0,
              height: 20.0,
              point: istanbul,
              builder: (ctx) => new Container(
                child: new GestureDetector(
                  onTap: () {
                    animatedMapMove(istanbul2, 15, mapController, this);
                  },
                  child: new FlutterLogo(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Cupertino Dialog"),
              content: new Text("Hey! I'm Coflutter!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
