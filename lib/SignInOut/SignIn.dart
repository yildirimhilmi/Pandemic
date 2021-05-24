import 'package:flutter/material.dart';
import 'package:my_website_project/screenComponents/AppBar.dart';

import 'LogIn.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Widget entryField(String title, {bool isPassword = false,bool isUserName=false,bool isConfirm=false}) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon: isPassword? isConfirm? Icon(Icons.verified_user_rounded,color: Color(0xFF222E32),):Icon(Icons.shield,color: Color(0xFF222E32),)
                    : isUserName? Icon(Icons.supervised_user_circle,color: Color(0xFF222E32),):Icon(Icons.email,color: Color(0xFF222E32),),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget signInButton() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Sign in",
              style: TextStyle(
                  color: Color(0xFF2C5788),
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Color(0xFFB6DAF5)),
              backgroundColor: MaterialStateProperty.all(Color(0xFFE0EBF3)))),
    );
  }


  Widget haveAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Do you have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Log In',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: newAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding:
              EdgeInsets.symmetric(vertical: 0, horizontal: width * 0.3),
              child: Column(
                children: [
                  SizedBox(height: height * .1),
                  Text(
                    "Pandemic Tracking",
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 5,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 60),
                  Column(
                    children: <Widget>[
                      entryField("User Name",isUserName: true),
                      entryField("E-Mail"),
                      entryField("Password", isPassword: true),
                      entryField("Confirm Password", isPassword: true,isConfirm: true),
                    ],
                  ),
                  SizedBox(height: 20),
                  signInButton(),
                  SizedBox(height: height * .01),
                  haveAccountLabel(),
                ],
              ),
            ),
          ),
        ));
  }
}
