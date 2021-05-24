import 'package:flutter/material.dart';
import 'package:my_website_project/screenComponents/AppBar.dart';
import 'SignIn.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Widget entryField(String title, {bool isPassword = false}) {
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
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget loginButton() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Log in",
              style: TextStyle(
                  color: Color(0xFF2C5788),
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Color(0xFFB6DAF5)),
              backgroundColor: MaterialStateProperty.all(Color(0xFFE0EBF3)))),
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget facebookButton() {
    return Container(
      height:40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {},
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff1959a9)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.zero,bottomRight: Radius.zero,topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                )),
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: TextButton(
                  onPressed: () {},
                  child: Text('Log in with Facebook',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff2872ba)),
                    overlayColor: MaterialStateProperty.all(Color(0xFF3E5168)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.zero,bottomLeft: Radius.zero,topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
                    )),
                  )))
        ],
      ),
    );
  }

  Widget createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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
                      entryField("User Name"),
                      entryField("Password", isPassword: true),
                    ],
                  ),
                  SizedBox(height: 20),
                  loginButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  divider(),
                  facebookButton(),
                  SizedBox(height: height * .01),
                  createAccountLabel(),
                ],
              ),
            ),
          ),
        ));
  }
}
