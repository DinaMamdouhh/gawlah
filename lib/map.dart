import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'place_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacePolylinePage extends StatelessWidget {
  const PlacePolylinePage(
      {Key key, this.height, this.width1, this.tour_id, this.centre})
      : super(key: key);

  final double height;
  final double width1;
  final int tour_id;
  final GeoPoint centre;

  @override
  Widget build(BuildContext context) {
    return PlacePolylineBody(
      centre: centre,
      tour_id: tour_id,
    );
  }
}

class PlacePolylineBody extends StatefulWidget {
  const PlacePolylineBody({
    Key key,
    this.tour_id,
    this.centre,
  }) : super(key: key);

  final int tour_id;
  final GeoPoint centre;

  @override
  State<StatefulWidget> createState() => PlacePolylineBodyState();
}

class PlacePolylineBodyState extends State<PlacePolylineBody>
    with TickerProviderStateMixin {
  String mapstyle;
  PlacePolylineBodyState();

  String activepolygon = 'a';
  String activeTag = 'all';
  GoogleMapController controller;
  final Firestore database = Firestore.instance;

  Stream Mapobjects;
  Set<Polygon> polygons;
  Set<Polyline> polylines;

  final Set<Marker> _markers = {};
  static const _intialPositionn1 = LatLng(30.041833166, 31.257332304);
  static const _intialPositionn2 = LatLng(30.0554905, 31.2634282);
  Completer<GoogleMapController> _controller = Completer();

  void initState() {
    Query query = database.collection('polylines');
    Mapobjects = query
        .where("tours", arrayContains: widget.tour_id)
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));

    polygons = new Set();
    polylines = new Set();
    rootBundle.loadString('images_and_icons/mapstyle.txt').then((string) {
      mapstyle = string;
    });

    _boxes(30.041833166, 31.257332304);
    _boxes(30.0554905, 31.2634282);
    _boxes(30.052212451747547, 31.26263737678528);
    _boxes(30.050559431652957, 31.262369155883786);
    _boxes(30.053196821392653, 31.260963678359985);
    _boxes(30.048163432201022, 31.263012886047363);
    _boxes(30.051255932247386, 31.26746535301208);
    _boxes(
      30.049797918730953,
      31.26807689666748,
    );
    _boxes(
      30.05332683174633,
      31.266725063323975,
    );
    _boxes(
      30.06790548129843,
      31.234130859374996,
    );
    _boxes(30.089295993825527, 31.246147155761722);
    _boxes(
      30.05691133569448,
      31.262283325195312,
    );
    _boxes(
      30.060300708403293,
      31.26504063606262,
    );
    _boxes(
      30.05422761307999,
      31.261768341064457,
    );
    _boxes(
      30.086325365908422,
      31.328887939453125,
    );
    _boxes(30.05483122485245, 31.3330078125);
    _boxes(30.013219833932094, 31.278076171875);
    _boxes(29.950175057288813, 31.293869018554688);
    _boxes(
      29.957314210401563,
      31.167526245117184,
    );
    _boxes(29.906734168105377, 31.21353149414062);
    _boxes(30.0643399462443, 31.133880615234375);

   

    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    controller.setMapStyle(mapstyle);
  }

  void dispose() {
    super.dispose();
  }

  Future<void> gotoLocation(double lat, double long, double zoom) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: zoom,
    )));
  }

  void _queryDatabase({String tag = 'all'}) {
    if (tag == 'all') {
      Query query = database.collection('polylines');
      Mapobjects = query
          .where("tours", arrayContains: widget.tour_id)
          .snapshots()
          .map((list) => list.documents.map((doc) => doc.data));
    } else {
      Query query =
          database.collection('polylines').where('building', isEqualTo: tag);
      Mapobjects = query
          .snapshots()
          .map((list) => list.documents.map((doc) => doc.data));
    }

    setState(() {
      activeTag = tag;
    });
  }

  LatLng _createcentre(GeoPoint centre) {
    return new LatLng(centre.latitude, centre.longitude);
  }

  Set<Polygon> polygons_set(List polys, Set<Polygon> Polygons) {
    Polygons.clear();

    polys.forEach((PolyObj) {
      switch (PolyObj['type']) {
        case 'place':
          Polygons.add(Place(PolyObj['points'], PolyObj['name']));
          break;

        default:
          break;
      }
    });

    return Polygons;
  }

  Set<Polyline> polylines_set(List polyys, Set<Polyline> Polylines) {
    Polylines.clear();

    polyys.forEach((PolyObj) {
      switch (PolyObj['type']) {
        case 'route':
          Polylines.add(Route(PolyObj['points'], PolyObj['name']));
          break;

        default:
          break;
      }
    });

    return Polylines;
  }

  Polygon Place(List<dynamic> polylinePoints, String idd) {
    List<LatLng> latlngs = new List();
    polylinePoints.forEach((point) {
      latlngs.add(new LatLng(
          (point as GeoPoint).latitude, (point as GeoPoint).longitude));
    });

    return new Polygon(
      consumeTapEvents: false,
      polygonId: PolygonId(idd),
      fillColor: activepolygon == idd ? Colors.red : Colors.transparent,
      strokeColor: Colors.black,
      strokeWidth: 5,
      visible: true,
      points: latlngs,
    );
  }

  Polyline Route(List<dynamic> polylinePoints, String idd) {
    List<LatLng> latlngs = new List();
    polylinePoints.forEach((point) {
      latlngs.add(new LatLng(
          (point as GeoPoint).latitude, (point as GeoPoint).longitude));
    });

    return new Polyline(
      consumeTapEvents: false,
      polylineId: PolylineId(idd),
      color: Colors.greenAccent,
      width: 3,
      visible: true,
      points: latlngs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: Mapobjects,
          builder: (context, AsyncSnapshot snapshot) {
            List slideList = snapshot.data.toList();
            return Stack(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GoogleMap(
                      minMaxZoomPreference: MinMaxZoomPreference(14, 18),
                      mapType: MapType.normal,
                      initialCameraPosition: new CameraPosition(
                          target: _createcentre(widget.centre), zoom: 15.5),
                      polygons: polygons_set(slideList, polygons),
                      polylines: polylines_set(slideList, polylines),
                      onMapCreated: _onMapCreated,
                      markers: _markers,
                    ),
                  ),
                ),
                Positioned(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    bottom: 0,
                    child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: PageController(
                            viewportFraction: 0.59, initialPage: 0),
                        onPageChanged: (int index) {
                          setState(() {
                            activepolygon = slideList[index]['name'];
                            gotoLocation(
                                ((slideList[index]['center']) as GeoPoint)
                                    .latitude,
                                ((slideList[index]['center']) as GeoPoint)
                                    .longitude,
                                18.0);
                          });
                        },
                        itemCount: slideList.length,
                        itemBuilder: (context, index) {
                          {
                            if (slideList[index]['type'] == 'place') {
                              return PlaceCard(
                                image: slideList[index]['image'],
                                name: slideList[index]['name'],
                                placetype: slideList[index]['placetype'],
                                info: slideList[index]['info'],
                                vid: slideList[index]['vid'],
                              );
                            }
                          }
                        })),
              ],
            );
          }),
    );
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget _boxes(double lat, double long) {
    LatLng newpoint = LatLng(lat, long);
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("NearByPlaces"),
        position: newpoint,
        infoWindow: InfoWindow(
          title: 'NearByPlace',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ));
    });


     double totalDistance = calculateDistance(
        _intialPositionn1.latitude,
        _intialPositionn1.longitude,
        lat,
        long);

    print(totalDistance);
  }
}
