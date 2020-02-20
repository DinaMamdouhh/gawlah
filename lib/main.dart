import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';
//import 'place_detail.dart';
//import 'package:permission/permission.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart' as LocationManager;

import 'Tours_Pager.dart';
//import 'package:http/http.dart';


var apiKey = "<AIzaSyBPDbF9SG2qPGN_nS57lSYhXmdnR-ksx04>";
//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

void main() => runApp(Tours_List());

// class MyApp extends StatefulWidget {
//   _MyAppState createState() => _MyAppState();
// }


// class _MyAppState extends State<MyApp> {
//   List<PlacesSearchResult> places = [];
// bool isLoading = false;
// String errorMessage;
//   final Set<Polyline> polyline = {};
// //final Set<Polyline> polyline={};
// //List<LatLng>routecoords;
// //GoogleMapPolyline googleMapPolyline=new GoogleMapPolyline(apiKey: "AIzaSyBPDbF9SG2qPGN_nS57lSYhXmdnR-ksx04");

//   Position userlocation;
//   GoogleMapController _mapcontroller;
//   static const _intialPositionn = LatLng(29.9565261, 31.2703018);
//   LatLng _lastMapPosition = _intialPositionn;
//   final Set<Marker> _markers = {};

//   MapType _currentMapType = MapType.normal;

//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = _currentMapType == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }



 

//   void _onAddMarkerButtonPressed() {
//     setState(() {
//       _markers.add(Marker(
//         // This marker id can be anything that uniquely identifies each marker.
//         markerId: MarkerId(_lastMapPosition.toString()),
//         position: _lastMapPosition,
        
//         infoWindow: InfoWindow(
//           title: 'Really cool place',
//           snippet: '5 Star Rating',
//         ),
//           icon: BitmapDescriptor.fromAsset('assets/emoji.png')

//       ));
//     });
//   }

//   searchandNavigate() {
//     Geolocator().placemarkFromAddress(searchAddr).then((result) {
//       _mapcontroller.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(
//               target: LatLng(
//                   result[0].position.latitude, result[0].position.longitude),
//               zoom: 10.0)));
//     });
//   }

//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   void _onMapCreated(controller) async {
//     setState(() {
//       _mapcontroller = controller;
   

//     });
//   }
//   Future<LatLng> getUserLocation() async {
// var currentLocation = <String, double>{};
// final location = LocationManager.Location();
// try {
// currentLocation = (await location.getLocation()) as Map<String, double>;
// final lat = currentLocation["latitude"];
// final lng = currentLocation["longitude"];
// final center = LatLng(lat, lng);
// return center;
// } on Exception {
// currentLocation = null;
// return null;
// }
// }











//   String searchAddr;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             StreamBuilder<Object>(
//               stream: Firestore.instance.collection('tours').snapshots(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 return GoogleMap(
//                   myLocationEnabled: true,
//                   polylines: polyline,
//                   myLocationButtonEnabled: true,
//                   onMapCreated: _onMapCreated,
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(29.9565261, 31.2703018),
//                     zoom: 10.0,
//                   ),
//                   polygons: Set<Polygon>.of(
//                     <Polygon>[
//                       Polygon(
//                           polygonId: PolygonId('area'),
//                           points: snapshot.data.documents[0]['points'],
//                           geodesic: true,
//                           strokeColor: Colors.red.withOpacity(0.6),
//                           strokeWidth: 5,
//                           fillColor: Colors.transparent.withOpacity(0.1),
//                           visible: true),
//                     ],
//                   ),
//                   mapType: _currentMapType,
//                   markers: _markers,
//                   onCameraMove: _onCameraMove,
//                 );
//               }
//             ),
//             Positioned(
//                 top: 40.0,
//                 right: 15.0,
//                 left: 15.0,
//                 child: Container(
//                   height: 50.0,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color: Colors.white),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         hintText: 'Enter Adress',
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
//                         suffixIcon: IconButton(
//                             icon: Icon(Icons.search),
//                             onPressed: searchandNavigate,
//                             iconSize: 30.0)),
//                     onChanged: (val) {
//                       setState(() {
//                         searchAddr = val;
//                       });
//                     },
//                   ),
//                 )),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 100.0),
//               height: 50.0,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: <Widget>[
//                   FlatButton(
//                       shape: new RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(18.0),
//                           side: BorderSide(color: Colors.red)),
//                       color: Colors.white,
//                       textColor: Colors.red,
//                       padding: EdgeInsets.all(8.0),
//                       onPressed: () {},
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.restaurant),
//                           Text("Resturants")
//                         ],
//                       )),
//                   SizedBox(width: 10),
//                   FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(18.0),
//                         side: BorderSide(color: Colors.blue)),
//                     color: Colors.white,
//                     textColor: Colors.blue,
//                     padding: EdgeInsets.all(8.0),
//                     onPressed: () {},
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.local_pharmacy),
//                         Text("Pharmacy")
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(18.0),
//                         side: BorderSide(color: Colors.green)),
//                     color: Colors.white,
//                     textColor: Colors.green,
//                     padding: EdgeInsets.all(8.0),
//                     onPressed: () {},
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.local_gas_station),
//                         Text("Gas_Station")
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(18.0),
//                         side: BorderSide(color: Colors.purple)),
//                     color: Colors.white,
//                     textColor: Colors.purple,
//                     padding: EdgeInsets.all(8.0),
//                     onPressed: () {},
//                     child: Row(
//                       children: <Widget>[Icon(Icons.hotel), Text("Hotels")],
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(18.0),
//                         side: BorderSide(color: Colors.orange)),
//                     color: Colors.white,
//                     textColor: Colors.orange,
//                     padding: EdgeInsets.all(8.0),
//                     onPressed: () {},
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.shopping_cart),
//                         Text("Groceries")
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 110,
//               right: 1,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 30.0),
//                       FloatingActionButton(
//                         onPressed: _onMapTypeButtonPressed,
//                         materialTapTargetSize: MaterialTapTargetSize.padded,
//                         backgroundColor: Colors.green,
//                         child: const Icon(Icons.map, size: 30.0),
//                       ),
//                       SizedBox(height: 20.0),
//                       FloatingActionButton(
//                         onPressed: _onAddMarkerButtonPressed,
//                         materialTapTargetSize: MaterialTapTargetSize.padded,
//                         backgroundColor: Colors.green,
//                         child: const Icon(Icons.add_location, size: 30.0),
//                       ),
//                       SizedBox(height: 20.0),
                      
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   getPoints() {
//     return [
//       LatLng(29.9666496, 31.2544982),
//       LatLng(29.9869123, 31.4415236),
//       LatLng(29.9869555, 31.4415423),
//     ];
//   }




// }

