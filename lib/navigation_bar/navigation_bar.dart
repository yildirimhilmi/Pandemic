import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationItem {
  final String text;
  NavigationItem(this.text);
}

final barValues = [
  NavigationItem("Projects"),
  NavigationItem("Skills"),
  NavigationItem("About Me"),
  NavigationItem("Blog")
];

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key, this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        if (size.isMobile)
          return Container(
            height: 60,
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(width: 20),
                FlutterLogo(
                  size: 40,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ],
            ),
          );
        return Container(
          width: width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey,
          ),
          child: Row(
            children: [
              FlutterLogo(),
              Spacer(),
              for (var item in barValues)
                BarItem(
                  text: item.text,
                  onpressed: () {},
                ),
            ],
          ),
        );
      },
    );
  }
}

class BarItem extends StatelessWidget {
  final text;
  final onpressed;

  const BarItem({this.text, this.onpressed});

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: Text(
            this.text,
            style: TextStyle(fontSize: isSmall ? 15 : 20, color: Colors.white),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
