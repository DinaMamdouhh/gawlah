import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'Tours_Pager.dart';
import 'dart:async';

class Myhi extends StatefulWidget {
  const Myhi({Key key, this.id, this.center, this.tour}) : super(key: key);

  _MyAppState createState() => _MyAppState();
  final int id;
  final LatLng center;
  final Map tour;
}

class _MyAppState extends State<Myhi> {
  Stream MapObject;
  Set<Polygon> polygons;
  Set<Polyline> polylines;
  Set<Marker> markers;
  final Firestore database = Firestore.instance;

  Polyline route;
  Completer<GoogleMapController> _mapcontroller = Completer();

  void initState() {
  
    _queryDatabase();

    polygons = new Set();
    polylines = new Set();
    markers = new Set();
    super.initState();
  }

  void _queryDatabase({String tag = 'all'}) {
    if (tag == 'all') {
      Query query = database.collection('mapobjects');
      MapObject = query
          .where("tours", arrayContains: widget.id)
          .snapshots()
          .map((list) => list.documents.map((doc) => doc.data));
    } else {
      Query query =
          database.collection('mapobjects').where('type', isEqualTo: tag);
      MapObject = query
          .snapshots()
          .map((list) => list.documents.map((doc) => doc.data));
    }
  }

  _MyAppState({this.passedValue});
  final String passedValue;

  bool isLoading = false;
  String errorMessage;

  static const _intialPositionn = LatLng(29.9565261, 31.2703018);
  LatLng _lastMapPosition = _intialPositionn;
  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.satellite;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(controller) async {
    setState(() {
      _mapcontroller.complete(controller);
    });
  }

  String searchAddr;

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              StreamBuilder<Object>(
                stream: MapObject,
                builder: (context, AsyncSnapshot snapshot) {
                  List mab_object_list = snapshot.data.toList();
                  return GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: widget.center,
                      zoom: 40.0,
                      
                      
                    ),
                    markers: DrawTheMarkers(mab_object_list,markers),
                    polygons: DrawThePolygons(mab_object_list,polygons),
                    polylines: DrawThePolylines(mab_object_list, polylines),
                  );
                },
              ),
              //_buildContainer(),
            ],
          ),
        ));
  }

  Polyline GetPolylineFromDb(Map mabobject) {
    List<dynamic> points = mabobject['point'].tolist();
    List<LatLng> latlngs = new List();

    points.forEach((point) {
      latlngs.add(new LatLng(point, point));
    });

    return new Polyline(
      consumeTapEvents: false,
      polylineId: PolylineId(mabobject['name']),
      visible: true,
      points: latlngs,
    );
  }

  Polygon GetPolygonFromDb(Map mabobject) {
    List<dynamic> points = mabobject['points'].tolist();
    List<LatLng> latlngs = new List();

    points.forEach((point) {
      latlngs.add(new LatLng(point, point));
    });

    return new Polygon(
      consumeTapEvents: false,
      polygonId: PolygonId(mabobject['name']),
      visible: true,
      points: latlngs,
    );
  }

  Marker GetMarkerFromDb(Map mabobject) {
    return new Marker(
      consumeTapEvents: false,
      markerId: MarkerId(mabobject['name']),
      visible: true,
      position: LatLng((mabobject['point'] as GeoPoint).latitude,
          (mabobject['point'] as GeoPoint).longitude),
    );
  }

   Set <Polygon> DrawThePolygons(List polygonns, Set <Polygon> Polygons )
  {
    Polygons.clear();

    polygonns.forEach((MapObj)
    {
      switch (MapObj['type']) {
        case 'polygon':
          Polygons.add(GetPolygonFromDb(MapObj));
          break;

        default:
          break;
      }
    });
return Polygons;


  }


   Set <Polyline> DrawThePolylines (List polylines, Set <Polyline> Polylines )
  {
    Polylines.clear();

    polylines.forEach((MapObj)
    {
      switch (MapObj['type']) {
        case 'polyline':
          Polylines.add(GetPolylineFromDb(MapObj));
          break;

        default:
          break;
      }
    });
return Polylines;

  }



     Set <Marker> DrawTheMarkers (List markers, Set <Marker> Markers )
  {
    Markers.clear();

    markers.forEach((MapObj)
    {
      switch (MapObj['type']) {
        case 'marker':
          Markers.add(GetMarkerFromDb(MapObj));
          break;

        default:
          break;
      }
    });
return Markers;

  }





}
