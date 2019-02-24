import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text("Second page!"),),
      body: Center(
        child: RaisedButton(onPressed: () {
          Navigator.pop(context);
        },child: Text("Pop"),),
      ),
    );
  }

}