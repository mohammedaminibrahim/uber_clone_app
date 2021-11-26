import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 65.0,),
          Image(image: AssetImage("images/logo.png"),
            width: 35.0,
            height: 350.0,
            alignment: Alignment.center,
          ),

          SizedBox(height: 15.0,),

          Text(
            "Login as a RIder",

          )
        ],
      ),
    );
  }
}
