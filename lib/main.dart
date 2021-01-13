import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' hide Icon;
import 'dart:html';
import 'dart:ui' as ui;

import 'package:my_website_project/Screens/mapview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pandemic Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapView(),
    );
  }
}

Widget getMap() {
  String htmlId = "7";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final myLatlng = new LatLng(41.015137, 28.979530);
    final myLatlng2 = new LatLng(41.015137, 28.779530);
    final mapOptions = new MapOptions()
      ..zoom = 8
      ..center = new LatLng(41.015137, 28.979530);

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = new GMap(elem, mapOptions);

    Marker(MarkerOptions()
      ..draggable = true
      ..clickable = true
      ..label = Text(
        "Mısır Çarşısı",
        style: TextStyle(color: Colors.black),
      )
      ..visible = true
      ..icon = Icon(Icons.access_time)
      ..position = myLatlng
      ..map = map
      ..title = 'Hello World!');
    Marker(MarkerOptions()
      ..clickable = true
      ..visible = true
      ..label = "Mısır Çarşısı"
      ..icon = Icon(Icons.access_alarms)
      ..position = myLatlng2
      ..map = map
      ..title = 'Hello World!');

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}
