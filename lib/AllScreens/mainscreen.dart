import 'package:flutter/material.dart';



class MainScreen extends StatefulWidget {

  //variabe for Screen Routing
  static const String idScreen = "mainScreen";


  @override
  _MainScreenState createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uber Clone App"),
      ),
    );
  }
}
