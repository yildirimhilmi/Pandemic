import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, size) {
        if (size.isMobile) return MobileView(height: height, width: width);
        return DesktopView(width: width, height: height);
      },
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.9,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(height: 20),
          FirstInfo(
            width: width,
            height: height,
          ),
        ],
      ),
    );
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        height: (height * 0.8),
        width: width * 0.8,
        child: Row(
          children: [
            Expanded(
              child: FirstInfo(
                width: width,
                height: height,
              ),
            ),
            Image.asset(
              "images/edited.png",
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}

class FirstInfo extends StatelessWidget {
  const FirstInfo({this.width, this.height});
  final width;
  final height;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: Text(
                    "Contact Me",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
