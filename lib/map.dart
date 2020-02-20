import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Tours_Pager.dart';

class Myhi extends StatefulWidget {
  const Myhi({Key key, this.id, this.center, this.route}) : super(key: key);

  _MyAppState createState() => _MyAppState();
  final int id;
  final LatLng center;
  final List<LatLng>route;

  int getid(){
    return id;
  }
 
  LatLng getcenter(){
    return center;
  }

  List<LatLng> getroute(){

    return route;
  }


}
class _MyAppState extends State<Myhi> {
  _MyAppState({this.passedValue});
  final String passedValue;
 
bool isLoading = false;
String errorMessage;
//final Set<Polyline> polyline={};
//List<LatLng>routecoords;
//GoogleMapPolyline googleMapPolyline=new GoogleMapPolyline(apiKey: "AIzaSyBPDbF9SG2qPGN_nS57lSYhXmdnR-ksx04");


  GoogleMapController _mapcontroller;
  static const _intialPositionn = LatLng(29.9565261, 31.2703018);
  LatLng _lastMapPosition = _intialPositionn;
  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }



 

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
          icon: BitmapDescriptor.fromAsset('assets/emoji.png')

      ));
    });
  }

  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      _mapcontroller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  result[0].position.latitude, result[0].position.longitude),
              zoom: 10.0)));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(controller) async {
    setState(() {
      _mapcontroller = controller;
   

    });
  }

  String searchAddr;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            StreamBuilder<Object>(
              stream: Firestore.instance.collection('tours').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                
                                return GoogleMap(
                                  myLocationEnabled: true,
                                  myLocationButtonEnabled: true,
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                    target:widget.center,
                    zoom: 10.0,
                  ),);},),
                
          ],
                ),
            )
        );
  }
}