import 'package:flutter/material.dart';

double widthSize = 800;
double containerNumbers = 4;

class smallInfo extends StatelessWidget {
  smallInfo(
      {this.regionName = "misir",
      this.percentage = "80",
      this.timeInfo = "12.01.2021"});
  String regionName;
  String percentage;
  String timeInfo;

  @override
  Widget build(BuildContext context) {
    print("called");
    return Container(
      color: Colors.blue,
      width: widthSize,
      child: Row(
        children: [
          Container(
            width: widthSize / containerNumbers,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Text("Region"),
                Text(regionName),
              ],
            ),
          ),
          Container(
            width: widthSize / containerNumbers,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Text("Percantage"),
                Text(percentage),
              ],
            ),
          ),
          Container(
            width: widthSize / containerNumbers,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Last Updated"),
                Text(timeInfo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
