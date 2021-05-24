import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_website_project/chart/chart.dart';
import 'package:my_website_project/screenComponents/AppBar.dart';
import 'package:my_website_project/screenComponents/sideMenu.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:video_player/video_player.dart';
import 'chartAPIhandler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'chart.dart';


class Mask {
  final String day;
  final int count;

  Mask(this.day, this.count);
}

List<charts.Series<Mask, String>> _createSampleData(List<DateTime> time,
    List<int> incorrect_data, List<int> masked_data, List<int> nomasked_data) {

  final incorrect = [
    new Mask(time[0].day.toString(), incorrect_data[0]),
    new Mask(time[1].day.toString(), incorrect_data[1]),
    new Mask(time[2].day.toString(), incorrect_data[2]),
    new Mask(time[3].day.toString(), incorrect_data[3]),
    new Mask(time[4].day.toString(), incorrect_data[4]),
    new Mask(time[5].day.toString(), incorrect_data[5]),
    new Mask(time[6].day.toString(), incorrect_data[6]),
  ];

  final masked = [
    new Mask(time[0].day.toString(), masked_data[0]),
    new Mask(time[1].day.toString(), masked_data[1]),
    new Mask(time[2].day.toString(), masked_data[2]),
    new Mask(time[3].day.toString(), masked_data[3]),
    new Mask(time[4].day.toString(), masked_data[4]),
    new Mask(time[5].day.toString(), masked_data[5]),
    new Mask(time[6].day.toString(), masked_data[6]),
  ];

  final nomasked = [
    new Mask(time[0].day.toString(), nomasked_data[0]),
    new Mask(time[1].day.toString(), nomasked_data[1]),
    new Mask(time[2].day.toString(), nomasked_data[2]),
    new Mask(time[3].day.toString(), nomasked_data[3]),
    new Mask(time[4].day.toString(), nomasked_data[4]),
    new Mask(time[5].day.toString(), nomasked_data[5]),
    new Mask(time[6].day.toString(), nomasked_data[6]),
  ];

  return [
    new charts.Series<Mask, String>(
        id: 'Incorrect',
        domainFn: (Mask sales, _) => sales.day,
        measureFn: (Mask sales, _) => sales.count,
        data: incorrect,
        colorFn: (Mask mask, _) => charts.ColorUtil.fromDartColor(Colors.red)),
    new charts.Series<Mask, String>(
        id: 'Masked',
        domainFn: (Mask sales, _) => sales.day,
        measureFn: (Mask sales, _) => sales.count,
        data: masked,
        colorFn: (Mask mask, _) =>
            charts.ColorUtil.fromDartColor(Colors.green.shade400)),
    new charts.Series<Mask, String>(
        id: 'No masked',
        domainFn: (Mask sales, _) => sales.day,
        measureFn: (Mask sales, _) => sales.count,
        data: nomasked,
        colorFn: (Mask mask, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue.shade800)),
  ];
}

List<charts.Series<Mask, String>> _createSampleData2(
    List<int> incorrect_data, List<int> masked_data, List<int> nomasked_data) {
  final incorrect = [
    new Mask('07:00', incorrect_data[0]),
    new Mask('10:00', incorrect_data[1]),
    new Mask('13:00', incorrect_data[2]),
    new Mask('16:00', incorrect_data[3]),
    new Mask('19:00', incorrect_data[4]),
    new Mask('22:00', incorrect_data[5]),
  ];

  final masked = [
    new Mask('07:00', masked_data[0]),
    new Mask('10:00', masked_data[1]),
    new Mask('13:00', masked_data[2]),
    new Mask('16:00', masked_data[3]),
    new Mask('19:00', masked_data[4]),
    new Mask('22:00', masked_data[5]),
  ];

  final nomasked = [
    new Mask('07:00', nomasked_data[0]),
    new Mask('10:00', nomasked_data[1]),
    new Mask('13:00', nomasked_data[2]),
    new Mask('16:00', nomasked_data[3]),
    new Mask('19:00', nomasked_data[4]),
    new Mask('22:00', nomasked_data[5]),
  ];

  return [
    new charts.Series<Mask, String>(
        id: 'Incorrect',
        domainFn: (Mask sales, _) => sales.day,
        measureFn: (Mask sales, _) => sales.count,
        data: incorrect,
        colorFn: (Mask mask, _) => charts.ColorUtil.fromDartColor(Colors.red)),
    new charts.Series<Mask, String>(
        id: 'Masked',
        domainFn: (Mask sales, _) => sales.day,
        measureFn: (Mask sales, _) => sales.count,
        data: masked,
        colorFn: (Mask mask, _) =>
            charts.ColorUtil.fromDartColor(Colors.green.shade400)),
    new charts.Series<Mask, String>(
        id: 'Nomasked',
        domainFn: (Mask sales, _) => sales.day,
        measureFn: (Mask sales, _) => sales.count,
        data: nomasked,
        colorFn: (Mask mask, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue.shade800)),
  ];
}




Future<List<ChartApi>> apiCall() async {
  final response = await http.get(
      'http://localhost:59138/faces/26/2021-01-06%2000:32:10/2021-04-06%2000:32:10');
  if (response.statusCode == 200) {
    var jsonList= new List.filled(7,null);
    var jsonResponse=json.decode(response.body);
    for(int i=0;i<jsonList.length;i++)
      {
        print(jsonResponse[i]);
        print(ChartApi.fromJson(jsonResponse[i]));
      }
    return jsonList;

  } else {
    throw Exception('Failed to load');
  }
}


Future<List<ChartApi>> getDays(int camID,DateTime startDate, DateTime endDate) async {
  final response = await http.get("http://localhost:59138/faces/$camID/$startDate/$endDate");
  if (response.statusCode == 200) {

    List<ChartApi> jsonList;
    jsonList=(json.decode(response.body) as List).map((i) =>
        ChartApi.fromJson(i)).toList();
    return jsonList;

  } else {
    throw Exception('Failed to load');
  }
}

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {


  @override
  void initState() {

    super.initState();
    buttonData();

  }

  var time = new List<DateTime>.filled(7,DateTime.now());

  void setTime(DateTime firstDate)
  {
    DateTime temp=firstDate;
    for(int i=0;i<7;i++)
      {
        time[i]=temp.add(new Duration(days:i));
      }
  }


  var data1_incorrect = new List<int>.filled(7, 25);
  var data1_masked = new List<int>.filled(7, 25);
  var data1_nomasked = new List<int>.filled(7, 25);
  var data2_incorrect = new List<int>.filled(7, 25);
  var data2_masked = new List<int>.filled(7, 25);
  var data2_nomasked = new List<int>.filled(7, 25);
  var rng = new Random();
  var col = Colors.red;

  void buttonData() async {
    col = Colors.blue;
    DateTime startt_date,endd_date;
    //startt_date= time[0];
    startt_date=DateTime.parse("2021-01-06 00:32:10");
    endd_date= startt_date.add(new Duration(days:6,hours: 23,minutes: 59));
    //DateTime.parse('2021-04-06');
    print(startt_date);
    print(endd_date);
    print("in");
    List<ChartApi> dayList= await getDays(26, startt_date, endd_date);
    print("out");
    print(dayList[0].timestamp);
    int date=0;
    /*********************
     * timestamp formati degismeli
     * ***************************/
    int counter=DateTime.tryParse(dayList[0].timestamp).day;
    for(int i=0;i<dayList.length;i++)
      {
        print("for");
        if(DateTime.parse(dayList[i].timestamp).day>counter)
          {
            counter=DateTime.parse(dayList[i].timestamp).day;
            date++;
          }
        switch(dayList[i].mask)
        {
          case 0: //masked
          data1_masked[date]+=1;
            break;
          case 1: //nomasked
            data1_nomasked[date]+=1;
            break;
          case 2: //incorrect
            data1_incorrect[date]+=1;
            break;
        }
      }
/*
    for (int i = 0; i < 7; i++) {
      data1_incorrect[i] = rng.nextInt(100);
      data1_masked[i] = rng.nextInt(100);
      data1_nomasked[i] = rng.nextInt(100);
      data2_incorrect[i] = rng.nextInt(100);
      data2_masked[i] = rng.nextInt(100);
      data2_nomasked[i] = rng.nextInt(100);
      //time[i].add(new Duration(days: 1));
    }*/
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: NavDrawer(),
        appBar: newAppBar(context),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                        padding: EdgeInsets.all(50),
                        width: 900,
                        height: 900,
                        child: GroupedBarChart(
                          _createSampleData(time,
                              data1_incorrect, data1_masked, data1_nomasked),
                          animate: true,
                        )),
                  ),
                  Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              width: 60,
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text("    No mask: ",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  color: Colors.red,
                                  child: Text("     "),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "    Mask: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  color: Colors.green.shade400,
                                  child: Text("     "),
                                ),
                              ),
                              SizedBox(
                                width: 170,
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                    color: Colors.blueAccent,)
                                    ,
                                    MaterialButton(
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        color: Colors.blueAccent,
                                        onPressed: () async {
                                          final List<DateTime> picked = await DateRangePicker.showDatePicker(
                                              context: context,
                                              initialFirstDate: new DateTime.now(),
                                              initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                                              firstDate: new DateTime(2015),
                                              lastDate: new DateTime(DateTime.now().year+1)
                                          );
                                          if (picked != null && picked.length == 2) {
                                            setState(() {
                                              setTime(picked[0]);
                                              buttonData();
                                            });
                                          }
                                        },
                                        child: new Text("Pick date range",style: TextStyle(color: Colors.white),)
                                    ),
                                  ],
                                ),

                              )
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text("    Incorrect Mask: ",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  color: Colors.blue.shade800,
                                  child: Text("     "),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Flexible(
                    flex: 3,
                    child: Container(
                        padding: EdgeInsets.all(50),
                        width: 900,
                        height: 900,
                        child: GroupedBarChart(
                          _createSampleData2(
                              data2_incorrect, data2_masked, data2_nomasked),
                          animate: true,
                        )),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(50, 350, 50, 200),
                //child: SizedBox(width: 30,),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      buttonData();
                    });
                  },
                  /*child: Text(
                    "button",
                    style: TextStyle(color: col),
                  ),*/
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      //height: 720,
                      padding: EdgeInsets.fromLTRB(50, 150, 30, 50),
                      //child: VideoPlayer(playerController) ,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2174EA),
                        image: const DecorationImage(
                          image: AssetImage("images/ed.png"),
                          fit: BoxFit.cover,
                        ),
                        border: Border. all(
                          color: Colors.blueAccent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),

                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 40,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 290,
                        ),
                        Flexible(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Reload Video!'),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Go back!'),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 240,
                          ),
                        ),
                      ],
                    ),
                  )
                  /*TextButton(onPressed: (){},
                      child: Text("Reload"))*/
                ],
              ),
            ),
      SizedBox(
        width: 30,
      ),
          ],
        ));
  }
}



