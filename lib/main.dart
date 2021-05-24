import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' hide Icon;
import 'dart:html';
import 'package:my_website_project/Screens/mapview.dart';
import 'package:my_website_project/chart/chartPage.dart';
import 'package:my_website_project/screenComponents/AppBar.dart';
import 'package:my_website_project/screenComponents/cardView.dart';
import 'package:my_website_project/screenComponents/sideMenu.dart';

import 'SignInOut/LogIn.dart';
import 'SignInOut/SignIn.dart';


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pandemic Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:MyApp()
      //home:ChartPage(),
    //home:SignIn(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
            Scaffold(

          drawer: NavDrawer(),
          appBar: newAppBar(context),
          body: Container(
            padding: EdgeInsets.all(0),
            child: Stack(
              children: [
                MapView(),
                Container(
                  padding: EdgeInsets.all(10),
                  child: CardView(),
                ),
                //
              ],
            ),
          ),
        );
  }
}
