import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' hide Icon;
import 'dart:html';
import 'package:my_website_project/Screens/mapview.dart';
import 'package:my_website_project/screenComponents/cardView.dart';
import 'package:my_website_project/serviceRequests/apiCommunicator.dart';

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
        home: Scaffold(
          body: Stack(
            children: [
              MapView(),
              Positioned(
                left: 50,
                top: 50,
                child: CardView(),
              ),
            ],
          ),
        ));
  }
}
