import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/registrationScreen.dart';
import 'package:rider_app/main.dart';

import 'mainscreen.dart';

class LoginScreen extends StatelessWidget {


  //variabe for Screen Routing

  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 85.0,),
              Image(image: AssetImage("images/logo.png"),
                width: 35.0,
                height: 150.0,

                alignment: Alignment.center,
              ),

              SizedBox(height: 10.0,),

              Text(
                "Login",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 1.0,),
                  TextFormField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),

                  SizedBox(height: 40.0,),
                  TextFormField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.yellow,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),

                  SizedBox(height: 40.0,),
                  RaisedButton(onPressed: (){
                    if(!emailTextEditingController.text.contains("@")){
                      displayToastMessage("Email Address is Invalid"'', context);
                    } else if(passwordTextEditingController.text.isEmpty){
                      displayToastMessage("Please Provide your Password", context);
                    } else {
                      loginAndAuthenticateUser(context);
                    }

                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                      ),
                    ),
                  ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                  ),
                ],
              ),
              ),

              TextButton(onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
              },
                  child: Text(
                    "Create New Account!", style: TextStyle(color: Colors.green),
                  ))

            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    final User = (await _firebaseAuth.
    signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMesg){
      displayToastMessage("Error: " + errMesg.toString(), context);
    })).user;

    //check if user signed in successfully....
    if(User != null){
      //check if user exist
      usersRef.child(User.uid).once().then((DataSnapshot snap){
        if(snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("Logged In Successfully...", context);
        } else {
          _firebaseAuth.signOut();
          displayToastMessage("No Account with these credentials! Please create account...", context);
        }
      });

    } else {
      //error occured
      displayToastMessage("Can not be Signed In", context);
    }

  }
}
