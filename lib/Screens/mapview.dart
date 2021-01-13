import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as location;
import 'package:my_website_project/utils/table.dart';

location.LatLng istanbul = new location.LatLng(41.015137, 28.979530);
location.LatLng istanbul2 = new location.LatLng(41.015137, 28.979530);

location.LatLng istanbul3 = new location.LatLng(41.025137, 28.979530);
location.LatLng istanbul4 = new location.LatLng(41.015137, 28.979530);
String url =
    "https://api.mapbox.com/styles/v1/hcy043/ckjvsqnfk05r717p9o4dp4stq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGN5MDQzIiwiYSI6ImNranZvdWJ0dDBhZmQybmxzMG11ZWQ3bnQifQ.XUx00U-uMD-CA50qU5aN9w";

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  var points = <location.LatLng>[istanbul, istanbul2, istanbul3, istanbul4];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pandemic Tracking Web Application'),
        ),
        body: FlutterMap(
          options: new MapOptions(
            center: new location.LatLng(41.015137, 28.979530),
            minZoom: 10,
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
                        AwesomeDialog(
                          context: context,
                          width: 1000,
                          dialogType: DialogType.INFO,
                          buttonsBorderRadius:
                              BorderRadius.all(Radius.circular(2)),
                          headerAnimationLoop: false,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Misir Carsisi Info',
                          btnOkText: "More Information",
                          body: new smallInfo(
                            percentage: "50",
                          ),
                          showCloseIcon: true,
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        )..show();
                      },
                      child: new FlutterLogo(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
