import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'Tours_Pager.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'map.dart';
//import 'place_info.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({Key key, this.image, this.place_name}) : super(key: key);
  final String image;
  final String place_name;

 @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.end,
          //height: 200,
          // child: Stack(
            children: <Widget>[
              Container(
                  height: 100,
                  //width: 200,
                  child: 
                      Image(fit: BoxFit.fill, image: NetworkImage(image)),
                      ),
                      Text(place_name,style: TextStyle(fontSize: 20,color: Colors.pink),),
            ],
          ),
        //),
      )
    ;
  }

  
}