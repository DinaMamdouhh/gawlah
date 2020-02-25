import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'Tours_Pager.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Myhi extends StatefulWidget {
  const Myhi(
      {Key key,
      this.id,
      this.center,
      this.route,
      this.route1,
      this.route2,
      this.route3,
      this.route4})
      : super(key: key);

  _MyAppState createState() => _MyAppState();
  final int id;
  final LatLng center;
  final LatLng route;
  final LatLng route1;
  final LatLng route2;
  final LatLng route3;
  final LatLng route4;

  int getid() {
    return id;
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

  // searchandNavigate() {
  //   Geolocator().placemarkFromAddress(searchAddr).then((result) {
  //     _mapcontroller.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //             target: LatLng(
  //                 result[0].position.latitude, result[0].position.longitude),
  //             zoom: 10.0)));
  //   });
  // }

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
   Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://upload.wikimedia.org/wikipedia/commons/c/ce/Al-Azhar_%28inside%29_2006.jpg",
                  30.0457,
                  31.2627,
                  "Al-Azhar Mosque"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://upload.wikimedia.org/wikipedia/commons/4/46/Cairo%2C_madrasa_del_sultano_qalaun%2C_04.JPG",
                  30.0500072,
                  31.2607793,
                  "Qalawun complex"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://upload.wikimedia.org/wikipedia/commons/2/24/GD-EG-Caire-Suhaymi033.JPG",
                  30.052222,
                  31.2625,
                  "Bayt Al-Suhaymi"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    if(restaurantName=="Al-Azhar Mosque"){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.8",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(972)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Mosque",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Opened",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }
 else if(restaurantName=="Qalawun complex"){
return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.8",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(972)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Mosque of Complex",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Opened",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  
 }
 else if(restaurantName=="Bayt Al-Suhaymi"){
return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.2",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(972)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Bayt Al-Suhaymi Islamic House",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Opened",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );



 }


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
                            points: getPoints(),
                            geodesic: true,
                            strokeColor: Colors.red.withOpacity(0.6),
                            strokeWidth: 2,
                            fillColor: Colors.transparent.withOpacity(0.1),
                            visible: true),
                      ],
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('place1'),
                        position: widget.route,
                        infoWindow: InfoWindow(title: 'place1'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet,
                        ),
                      ),
                      Marker(
                        markerId: MarkerId('place2'),
                        position: widget.route2,
                        infoWindow: InfoWindow(title: 'Place2'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet,
                        ),
                      ),
                      Marker(
                        markerId: MarkerId('place3'),
                        position: widget.route3,
                        infoWindow: InfoWindow(title: 'Place3'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet,
                        ),
                      ),
                      Marker(
                        markerId: MarkerId('place4'),
                        position: widget.route4,
                        infoWindow: InfoWindow(title: 'Place4'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet,
                        ),
                      ),
                    },
                  );
                },
              ),
              _buildContainer(),
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
}