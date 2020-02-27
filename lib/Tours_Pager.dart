import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_googlemaps/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map.dart';
import 'dart:developer';

class Tours_List extends StatefulWidget {
  final GeoPoint route;
  const Tours_List({Key key, this.route}) : super(key: key);

  createState() => TourListState();
}

class TourListState extends State<Tours_List> {
  // This will give them 80% width which will allow other slides to appear on the side
  final PageController controller = PageController(viewportFraction: .8);
  final Firestore database = Firestore.instance;
  Stream tours;
  Color Back;
  String activeTag = 'all';
  int currentPage = 0;
  TourListState();

  Container BuildThemesPage(BuildContext context, List themes) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Themes',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Container(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 16,
              ),
              Text(
                'FILTER',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          _buildThemesButton(themes),
        ],
      ),
    );
  }

  GestureDetector BuildTourPage(
      bool active, int index, BuildContext context, AsyncSnapshot snap) {
    // Animated properties
    final double blur = active ? 50 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 200 : 240;

    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: 150, bottom: 50, right: 10, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(snap.data.documents[index]['image']),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: blur,
              offset: Offset(offset, offset),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 100,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                snap.data.documents[index]['name'],
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Myhi(
                      id: snap.data.documents[index]['id'],
                      center: LatLng(
                          (snap.data.documents[index]['center'] as GeoPoint)
                              .latitude,
                          (snap.data.documents[index]['center'] as GeoPoint)
                              .longitude),
                      tour: snap.data.documents[index],
                    )));
      },
    );
  }

  @override
  void initState() {
    Back = Color.fromRGBO(225, 186, 107, 1);
    queryDatabase();
    controller.addListener(() {
      int next = controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  void queryDatabase({String themes = 'favourites'}) {
    Query query =
        database.collection('tours').where('themes', arrayContains: themes);
    // Map the slides to the data payload
    tours =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    
    setState(() {
      activeTag = themes;
    });
  }

  Widget _buildThemesButton(List themes) {
    CollectionReference ref = database.collection('tours');

    List<Widget> themes_list = new List<Widget>();
    for (var i = 0; i < themes.length; i++) {
      Color color = themes[i] == activeTag ? Colors.blue : Colors.transparent;
      themes_list.add(FlatButton(
          color: color,
          child: SizedBox(
            width: 200,
            child: Text(
              '#' + themes[i],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.left,
            ),
          ),
          onPressed: () {
            queryDatabase(themes: themes[i]);
            activeTag = themes[i];
          }));
    }
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: themes_list);
  }

  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          BuildBackground(),
          StreamBuilder<QuerySnapshot>(
              stream: tours,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return PageView.builder(
                    controller: controller,
                    onPageChanged: _onPageViewChange,
                    itemCount: snapshot.data.documents.length + 1,
                    itemBuilder: (context, int currentIndex) {
                      if (currentIndex == 0) {
                        return BuildThemesPage(
                            context, themes_getter(snapshot));
                      } else if ((snapshot.data.documents.length + 1) >=
                          currentIndex) {
                        bool active = currentIndex == currentPage;
                        return BuildTourPage(
                            active, currentIndex - 1, context, snapshot);
                      }
                    });
              })
        ]),
      ),
    );
  }

  Widget BuildBackground() {
    return Scaffold(
        body: Container(
      color: Back,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(
            'assets/gawlah.png',
            height: 100,
          ),
          Container(
            height: 575,
          )
        ],
      ),
    ));
  }

  List themes_getter(AsyncSnapshot snapshot) {
    List themes = new List();

    for (int i = 0; i < snapshot.data.documents.length; i++) {
      List tags = snapshot.data.documents[i]['themes'];

      tags.forEach((element) {
        if (!(themes.contains(element))) {
          themes.add(element);
        }
      });
    }
    return themes;
  }

  void _onPageViewChange(int page) {}
}
