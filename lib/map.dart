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
  final List<dynamic> route;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<dynamic>('route', route));
    properties.add(IntProperty('id', id));
  }



}

class _MyAppState extends State<Myhi> {
  Polyline route;
  Completer<GoogleMapController> _mapcontroller = Completer();

  @override
  void initState() {
    route = GetRouteFromDb(widget.route, widget.id);
    super.initState();
    

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
                        route


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
   List<LatLng> latlngs = new List();
    points.forEach((point)
    {
      latlngs.add(new LatLng((point as GeoPoint).latitude, (point as GeoPoint).longitude));
    }
    );

    return
      new Polyline(
    consumeTapEvents: false,polylineId: PolylineId(id),    
    visible: true,
    points: latlngs,
    );
    
      }
    }
    

