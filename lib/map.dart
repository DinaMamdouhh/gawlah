import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'Tours_Pager.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'places_card.dart';

class Myhi extends StatefulWidget {
  const Myhi(
      {Key key,
      this.id,
      this.center,
      this.route,
      this.route1,
      this.route2,
      this.route3,
      this.route4,
      this.themes, tour})
      : super(key: key);

  _MyAppState createState() => _MyAppState();
   void location(){
        _MyAppState().location();
    }
  final int id;
  final LatLng center;
  final LatLng route;
  final LatLng route1;
  final LatLng route2;
  final LatLng route3;
  final LatLng route4;
  final List<int> themes;

  int getid() {
    return id;
  }




  // List<LatLng> getroute(){

  //   return route;
  // }

}

class _MyAppState extends State<Myhi> {
  double B;
  double A;


void location(){
_boxes( 30.052222, 31.2625);
print("dinaaa");
}
  final Firestore database = Firestore.instance;
  Stream tours;

  Completer<GoogleMapController> _mapcontroller = Completer();
  List<String> names = ['ali', 'ahmad', 'menna', 'mo3tasem', 'dina'];
  List<String> images = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Taj_Mahal_%28Edited%29.jpeg/800px-Taj_Mahal_%28Edited%29.jpeg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Taj_Mahal_%28Edited%29.jpeg/800px-Taj_Mahal_%28Edited%29.jpeg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Taj_Mahal_%28Edited%29.jpeg/800px-Taj_Mahal_%28Edited%29.jpeg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Taj_Mahal_%28Edited%29.jpeg/800px-Taj_Mahal_%28Edited%29.jpeg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Taj_Mahal_%28Edited%29.jpeg/800px-Taj_Mahal_%28Edited%29.jpeg'
  ];

  void queryDatabase({String themes = 'favourites'}) {
    Query query =
        database.collection('tours').where('themes', arrayContains: themes);
    // Map the slides to the data payload
    tours =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
   
    
  }
//  dina(bool active, int index, BuildContext context, AsyncSnapshot snap) {
//    A=(snap.data.documents[index]['route00']);
//     B=(snap.data.documents[index]['route01']);
//     return _boxes(A, B);

//   }
  @override
  void initState() {
     queryDatabase();
    super.initState();
    //hena hankhaleeh yekhod el lat w el long mn el db bet3 el places 3ashan yersmohom 3al map
        
    _boxes(30.0500072,
                  31.2607793);
    _boxes(30.0457,31.2627);
    _boxes(30.1457,31.2627);
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
                    return Stack(children: <Widget>[
                      GoogleMap(
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
                                  points: getPoints(),
                                  geodesic: true,
                                  strokeColor: Colors.red.withOpacity(0.6),
                                  strokeWidth: 2,
                                  fillColor:
                                      Colors.transparent.withOpacity(0.1),
                                  visible: true),
                            ],
                          ),
                          markers: _markers),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              
                                height: 131,
                                child: ListView.builder(
                            
                                    //shrinkWrap: true,
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, int currentindex) {
                                      return  PlaceCard(
                                          place_name: names[currentindex],
                                          image: images[currentindex]);
                                    }))
                          ])
                    ]);
                  }),
              // _buildContainer(),
            ],
          ),
        ));
  }

  getPoints() {
    return [
      //widget.center,
      widget.route,
      widget.route1,
      widget.route2,
      widget.route3,
      widget.route4,
    ];
  }



 Widget _boxes(double lat, double long) {
  // final Set<Marker> _markers = {};
  
        _gotoLocation(lat, long);
        LatLng newpoint=LatLng(lat,long);
     setState((){
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("place5"),
          position: newpoint,
          infoWindow: InfoWindow(
            title: 'Really cool place',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet),
          
          
          )
          );
   
      });

      }

   Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _mapcontroller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }





}
