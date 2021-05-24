import 'dart:convert';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:latlong/latlong.dart' as location;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:my_website_project/chart/chartPage.dart';
import 'package:my_website_project/screenComponents/RiskAPI.dart';
import 'package:my_website_project/screenComponents/locations.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;


MapController globalMapController = MapController();
location.LatLng istanbul2 = new location.LatLng(41.015137, 28.979530);

class CardView extends StatefulWidget {
  const CardView({Key key}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> with TickerProviderStateMixin {

  double riskPercentage=0.2;
  void initState() {
    super.initState();
    updateRisk();
  }

  Future<List<RiskApi>> getRisk(int locID,DateTime startDate, DateTime endDate) async {
    final response = await http.get("http://localhost:59138/risk/$locID/$startDate/$endDate");
    if (response.statusCode == 200) {

      List<RiskApi> jsonList;
      jsonList=(json.decode(response.body) as List).map((i) =>
          RiskApi.fromJson(i)).toList();
      print(jsonList);
      return jsonList;

    } else {
      throw Exception('Failed to load');
    }
  }
  void updateRisk() async
  {
    //DateTime endDate=DateTime.now();
    DateTime endDate=DateTime.parse("2021-05-06");
    DateTime startDate=DateTime.parse("2021-03-06");
    //DateTime startDate= endDate.subtract(new Duration(hours: 23,minutes: 59));
    print(startDate);
    print(endDate);
    List<RiskApi> riskList= await getRisk(27,startDate,endDate);

    setState(() {
      riskPercentage=riskList[0].percentage;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 390,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(30),
            color: Colors.blueAccent.withOpacity(0.4)),
        child: Row(
          children: [
            Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Mısır Çarşısı",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            GestureDetector(
              child: Tooltip(
                message: "Shows video of the location",
                child: Container(
                  child: Icon(Icons.play_arrow),
                ),
              ),
              onTap: () {
                AwesomeDialog(
                  dialogBackgroundColor: Colors.blueAccent,
                  dialogType: DialogType.NO_HEADER,
                  context: context,
                  width: 720,
                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                  headerAnimationLoop: false,
                  animType: AnimType.BOTTOMSLIDE,
                  body: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Image.asset("images/ed.png"),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                overlayColor:MaterialStateProperty.all(Colors.greenAccent) ,
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChartPage()));
                            },
                            child: Text(
                              "Risk Analysis of the Location",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                            ))
                      ],
                    ),
                  ),
                  showCloseIcon: true,
                ).show();
              },
            ),
            SizedBox(width: 20),
            GestureDetector(
              onDoubleTap: () {
                animatedMapMove(
                  misir[0],
                  9,
                  globalMapController,
                  this,
                );
              },
              onTap: () {
                animatedMapMove(
                  misir[0],
                  15,
                  globalMapController,
                  this,
                );
              },
              child: Tooltip(
                message: "Click to zoom into the location\n Double click to zoom out",
                child: Container(
                  child: Icon(Icons.my_location),
                ),
              ),
            ),
            SizedBox(width: 20),
            Tooltip(
              message: "Percentage of Wearing Mask Properly",
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 10.0,
                percent: 1-riskPercentage,
                center: new Text((100-riskPercentage*100).toInt().toString()+"%"),
                progressColor: riskPercentage<30? Colors.green:Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void animatedMapMove(location.LatLng destLocation, double destZoom,
    MapController localMapController, TickerProvider vsyncValue) {
  // Create some tweens. These serve to split up the transition from one location to another.
  // In our case, we want to split the transition be<tween> our current map center and the destination.
  final _latTween = Tween<double>(
      begin: localMapController.center.latitude, end: destLocation.latitude);
  final _lngTween = Tween<double>(
      begin: localMapController.center.longitude, end: destLocation.longitude);
  final _zoomTween =
  Tween<double>(begin: localMapController.zoom, end: destZoom);

  // Create a animation controller that has a duration and a TickerProvider.
  var controller = AnimationController(
      duration: const Duration(milliseconds: 500), vsync: vsyncValue);
  // The animation determines what path the animation will take. You can try different Curves values, although I found
  // fastOutSlowIn to be my favorite.
  Animation<double> animation =
  CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

  controller.addListener(() {
    localMapController.move(
        location.LatLng(
            _latTween.evaluate(animation), _lngTween.evaluate(animation)),
        _zoomTween.evaluate(animation));
  });

  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      controller.dispose();
    } else if (status == AnimationStatus.dismissed) {
      controller.dispose();
    }
  });

  controller.forward();
}
