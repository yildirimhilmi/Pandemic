import 'package:flutter/material.dart';
import 'package:my_website_project/navigation_bar/navigation_bar.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Hilmi Cihan Yıldırım '),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          for (var item in barValues)
            ListTile(
              title: Text(item.text),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
        ],
      ),
    );
  }
}
