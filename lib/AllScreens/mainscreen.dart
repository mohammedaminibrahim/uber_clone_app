import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MainScreen extends StatefulWidget {

  //variabe for Screen Routing
  static const String idScreen = "mainScreen";


  @override
  _MainScreenState createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  //Getting user current locations
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

  //  get user lat and lang
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

  //  camera position
    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer header
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
                      SizedBox(width: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Mohammed Amin ", style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6.0,),
                          Text("Visit Profile"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: 12.0,),
              //Drawer Body

              ListTile(
                leading: Icon(Icons.history),
                title: Text("History", style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("View Profile", style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About", style: TextStyle(fontSize: 15.0),),
              ),

            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller){

            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 265.0;
              });
            //call the LocatePosition fun
              locatePosition();
            },
          ),

          //Hamburger button for drawer
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: (){
              scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu, color: Colors.black,),
                  radius: 20.0,
                ),
              ),
            ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 245.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0,),
                    Text("Hi there", style: TextStyle(fontSize: 12.0, ),),
                    Text("Home", style: TextStyle(fontSize: 12.0, fontFamily: "Brand-Bold"),),
                     SizedBox(height: 10.0,),
                    Container(
                      //height: 320,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.green,),
                            SizedBox(height: 10.0,),
                            Text("Search Drop off")
                            ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.0,),

                    Row(
                      children: [
                              Icon(Icons.home, color: Colors.grey,),
                              SizedBox(height: 4.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Add Home"),
                                  SizedBox(height: 4.0,),
                                  Text("Your living Home address", style: TextStyle(fontFamily: "Brand-Bold"),),
                                ],
                              )

                            ],
                          ),


                    SizedBox(height: 5.0,),

                    Divider(),

                    SizedBox(height: 5.0,),

                    Row(
                      children: [
                        Icon(Icons.work, color: Colors.grey,),
                        SizedBox(width: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Work"),
                            SizedBox(height: 4.0,),
                            Text("Your Working address", style: TextStyle(fontFamily: "Brand-Bold"),),
                          ],
                        )

                      ],
                    )
                        ],
                      ),
                    )


                ),
              ),
            ],
      ),
          );

  }
}
