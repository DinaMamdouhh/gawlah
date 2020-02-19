import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tours_List extends StatefulWidget {
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
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Container(
            height: 10,
          ),
          Row(
children: <Widget>[
  Container(width: 16,
  )
  ,   Text('FILTER', style: TextStyle(color: Colors.black26) ,textAlign: TextAlign.center,),
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
          margin: EdgeInsets.only(top: top, bottom: 100, right: 10, left: 10),
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
                alignment: Alignment.bottomLeft,
                child: Text(
                  snap.data.documents[index]['name'],
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ));
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

  void queryDatabase({String tag = 'favourites'}) {
    Query query =
        database.collection('tours').where('themes', arrayContains: tag);
    // Map the slides to the data payload
    tours =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    // Update the active tag
    setState(() {
      activeTag = tag;
    });
  }

  Widget _buildThemesButton(List themes) {
    CollectionReference ref = database.collection('tours');

    List<Widget> themes_list = new List<Widget>();
    for (var i = 0; i < themes.length; i++) {
      Color color = themes[i] == activeTag ? Colors.blue : Colors.transparent;
      themes_list.add( FlatButton(
          color: color,

          child: SizedBox(
              width: 60,
             child :Text(

           '#'+ themes[i],
            style: TextStyle(),
            textAlign: TextAlign.left,
          ),),
          onPressed: () {
            queryDatabase(tag: themes[i]);

            activeTag = themes[i];
          }));
    }
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
       children: themes_list);
  }





  Widget build(
    BuildContext context,
  ) {return
       MaterialApp(
                home: Scaffold(
                  body: Stack(children: [
      BuildBackground(),
      StreamBuilder<QuerySnapshot>(
              stream: database.collection('tours').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return PageView.builder(
                    controller: controller,
                    onPageChanged: _onPageViewChange,
                    itemCount: snapshot.data.documents.length+1,
                    itemBuilder: (context, int currentIndex) {
                      if (currentIndex == 0) {
                        return BuildThemesPage(context, themes_getter(snapshot));
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
    return Scaffold
      (
      body :
          Container
          (
      color: Back,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images_and_icons/gawlah.png',
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


  void _onPageViewChange(int page) {

  }
}
