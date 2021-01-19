import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:latlong/latlong.dart' as location;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:my_website_project/screenComponents/locations.dart';
import 'package:my_website_project/screenComponents/videoPlayer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cached_video_player/cached_video_player.dart';

MapController globalMapController = MapController();
location.LatLng istanbul2 = new location.LatLng(41.015137, 28.979530);

class CardView extends StatefulWidget {
  const CardView({Key key}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> with TickerProviderStateMixin {
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
                  "Misir Çarşısı",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                child: Icon(Icons.play_arrow),
              ),
              onTap: () {
                AwesomeDialog(
                  context: context,
                  width: 500,
                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                  headerAnimationLoop: false,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'INFO',
                  body: Container(
                    child: Text("videos will be show here"),
                  ),
                  showCloseIcon: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                )..show();
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
              child: Container(
                child: Icon(Icons.my_location),
              ),
            ),
            SizedBox(width: 20),
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 10.0,
              percent: 0.7,
              center: new Text("70%"),
              progressColor: Colors.green,
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
