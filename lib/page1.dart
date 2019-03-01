import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  Page({this.color, this.icon, this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Card(
          elevation: 12.0,
          child: Container(
            color: color,
            width: 250,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  icon,
                  size: 200,
                  color: Colors.black,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 40),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
