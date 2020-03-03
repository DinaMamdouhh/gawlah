import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'Tours_Pager.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'place_info.dart';
import 'map.dart';

//import 'place_info.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({Key key, this.image, this.place_name}) : super(key: key);
  final String image;
  final String place_name;
 

  @override
  Widget build(BuildContext context) {
    Myhi myloc=new Myhi();
    
    return GestureDetector(
        onLongPress: () {
        Navigator.of(context).push(_createRoute());
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            //height: 200,
            // child: Stack(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: Image(fit: BoxFit.fill, image: NetworkImage(image)),
              ),
              Text(
                place_name,
                style: TextStyle(fontSize: 20, color: Colors.pink),
              ),
            ],
          ),
          //),
        ));
  }









Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Myinfo(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 2.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}







}
