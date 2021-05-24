import 'package:flutter/material.dart';
import 'package:my_website_project/SignInOut/LogIn.dart';
import 'package:my_website_project/SignInOut/SignIn.dart';

newAppBar(BuildContext context){
  return AppBar(
      iconTheme: IconThemeData(color: Colors.blue),
      title: Text("Pandemic Tracking",
        style: TextStyle(color: Colors.black
            , letterSpacing: 5,fontWeight: FontWeight.w900),),
      backgroundColor: Colors.white,
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()));
              },
              child:
              Text("Log in", style: TextStyle(color: Color(0xFF2C5788)))
              ,style: ButtonStyle(
              overlayColor:MaterialStateProperty.all(Color(0xFFB6DAF5)) ,
              backgroundColor:
              MaterialStateProperty.all(Color(0xFFE0EBF3)))

          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Text(
                "Sign up",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                overlayColor:MaterialStateProperty.all(Color(0xFF0077CB)) ,
                backgroundColor:
                MaterialStateProperty.all(Color(0xFF0094FE)),
              )
          ),
        ),
        SizedBox(
          width: 30,
        )
      ]);
}