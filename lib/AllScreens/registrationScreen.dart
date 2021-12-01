import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/main.dart';

class RegistrationScreen extends StatelessWidget {



  //variabe for Screen Routing
  static const String idScreen = "register";

  //set editing controllers
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    //variabel for Screen Routing


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 55.0,),
              Image(image: AssetImage("images/logo.png"),
                width: 35.0,
                height: 150.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 15.0,),

              Text(
                "Register",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
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

                    SizedBox(height: 1.0,),
                    TextField(
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

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
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

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController ,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                    RaisedButton(onPressed: (){
                      //valiodate user input
                      if(nameTextEditingController.text.length < 4){
                        displayToastMessage("Name must be at least 3 characters!! ", context);
                      } else if(!emailTextEditingController.text.contains("@")){
                        displayToastMessage("Email Address is Invalid"'', context);
                      } else if(phoneTextEditingController.text.isEmpty){
                        displayToastMessage("Phone number can not be empty", context);

                      }else if(passwordTextEditingController.text.length < 7){
                        displayToastMessage("Password must be at least 6 characters", context);
                      } else {
                        //custom function to register new user
                        registerNewUser(context);

                      }



                    },
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Register",
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
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
              },
                  child: Text(
                    "Have an Account!", style: TextStyle(color: Colors.green)
                  ))

            ],
          ),
        ),
      ),
    );
  }

  //authentice user with firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  void registerNewUser(BuildContext context) async {
    final User = (await _firebaseAuth.
    createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMesg){
          displayToastMessage("Error: " + errMesg.toString(), context);
    })).user;

    //check if user created successfully....
    if(User != null){
      //save user into database
     // usersRef.child(User.uid);

      Map userDataMap = {
        "name" : nameTextEditingController.text.trim(),
        "email" : emailTextEditingController.text.trim(),
        "phone" : phoneTextEditingController.text.trim(),
      };

      usersRef.child(User.uid).set(userDataMap);
      displayToastMessage("New User Account Successfully...", context);

      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    } else {
      //error occured
      displayToastMessage("New User account has not been created...", context);
    }
  }


}

//custom toast function
displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message);
}


