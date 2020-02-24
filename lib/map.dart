import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'Tours_Pager.dart';
import 'dart:async';

class Myhi extends StatefulWidget {
  const Myhi(
      {Key key,
      this.id,
      this.center, this.route,
      })
      : super(key: key);

  _MyAppState createState() => _MyAppState();
  final int id;
  final LatLng center;
  final List<LatLng> route;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<LatLng>('route', route));
    properties.add(IntProperty('id', id));
  }

  // List<LatLng> getroute(){

  //   return route;
  // }

}

class _MyAppState extends State<Myhi> {
  Completer<GoogleMapController> _mapcontroller = Completer();

  @override
  void initState() {
    super.initState();
  }

  _MyAppState({this.passedValue});
  final String passedValue;

  bool isLoading = false;
  String errorMessage;
//final Set<Polyline> polyline={};
//List<LatLng>routecoords;
//GoogleMapPolyline googleMapPolyline=new GoogleMapPolyline(apiKey: "AIzaSyBPDbF9SG2qPGN_nS57lSYhXmdnR-ksx04");

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
          icon: BitmapDescriptor.fromAsset('assets/emoji.png')));
    });
  }


  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(controller) async {
    setState(() {
      _mapcontroller.complete(controller);

      // _markers.add(Marker(
      //   // This marker id can be anything that uniquely identifies each marker.
      //   markerId: MarkerId(_lastMapPosition.toString()),
      //   position: widget.center,
      //   infoWindow: InfoWindow(
      //     title: 'Kahert_El_Mouaz',
      //     snippet: 'Here Starts Your Tour',
      //   ),
      //   icon: BitmapDescriptor.defaultMarker,
      // ));
    });
  }

  //

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
                      target: widget.center,
                      zoom: 40.0,
                    ),
                    polygons: Set<Polygon>.of(
                      <Polygon>[
                        Polygon(
                            polygonId: PolygonId('area'),
                            
                            geodesic: true,
                            strokeColor: Colors.red.withOpacity(0.6),
                            strokeWidth: 2,
                            fillColor: Colors.transparent.withOpacity(0.1),
                            visible: true),
                      ],
                    ),
                    polylines: Set<Polyline>.of(
                      <Polyline>[
                        GetRouteFromDb(widget.route, widget.id)


                      ]



                    ),
                   
                  );
                },
              ),
              //_buildContainer(),
            ],
          ),
        ));
  }




  Polyline GetRouteFromDb(List<dynamic> points, id )
  {
    List<GeoPoint> points_list = points.map((point) => point as GeoPoint).toList();  
    List<LatLng> points_list_Latlng;
   
    points_list.forEach((point) => 
    {
      points_list_Latlng.add(LatLng( (point as GeoPoint ).latitude, (point as GeoPoint ).longitude))
    }
    );
     Polyline(polylineId:PolylineId(id.toString()) ,points: points_list_Latlng);

        
    
      }
    }
    

