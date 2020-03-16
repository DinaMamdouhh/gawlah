import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TourView extends StatefulWidget {
  final String image;
  final String info;
  final int tour_id;

  TourView({Key key, this.image, this.info, this.tour_id}) : super(key: key);

  TourViewState createState() => TourViewState();
}

class TourViewState extends State<TourView> {
  final FlutterTts flutterTts = FlutterTts();
  bool loading = false;
  final Firestore database = Firestore.instance;
  Stream Mapobjects;
  //  Future getinfo() async{
  //    var firestore = Firestore.instance;
  //   QuerySnapshot qn = await firestore.collection("tours").getDocuments();
  //   return qn.documents;
  //  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Hero(tag: widget.image, child: Image.network(widget.image)),
          Center(
            child: Text(
              widget.info,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.transparent
                  ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomLeft,

            //hena haykhod el info mn el database
            child: RaisedButton(
              child: Icon(Icons.hearing),
              onPressed: () => speak(),
            ),
          )
        ],
      ),
    ));
  }

  speak() async {
    await flutterTts.speak(widget.info);
  }
}
