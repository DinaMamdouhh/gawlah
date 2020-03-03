import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:location/location.dart';
//import 'place_detail.dart';
//import 'package:permission/permission.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart' as LocationManager;

class Myinfo extends StatefulWidget {
  final String image;
  final String info;
  const Myinfo({Key key, this.image, this.info}) : super(key: key);

  createState() => InfoListState();
}

class InfoListState extends State<Myinfo> {
 final FlutterTts flutterTts= FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Taj_Mahal_%28Edited%29.jpeg/800px-Taj_Mahal_%28Edited%29.jpeg")),
                ),
                Container(
                  alignment: Alignment.center,
                  //hena haykhod el info mn el database 
                  child: RaisedButton(child: Text("press this button to say hello"),

                  onPressed:()=>speak() ,
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    ),
                  
                  
                  
                  
                  
                  
                  
                  
                  
                                    )
                                ],
                              ),
                            ),
                            Center(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 100,
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Finish'),
                                    ),
                                  ),
                                ])),
                          ],
                        ),
                      );
                    }
                  
                    speak() async {
                          
await flutterTts.speak("Hello");



                    }
 
}