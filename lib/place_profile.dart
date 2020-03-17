import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:video_player/video_player.dart';
import 'vedio.dart';

class PlaceProfile extends StatefulWidget {
  final String image;
  final String info;
  final String vid;

 const PlaceProfile({Key key, this.image, this.info,this.vid}) : super(key: key);

  PlaceProfileState createState() => PlaceProfileState();
}

class PlaceProfileState extends State<PlaceProfile> {
  final FlutterTts flutterTts = FlutterTts();
  final Firestore database = Firestore.instance;
  Stream Mapobjects;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    print(widget.vid);
    return Scaffold(
        body: Hero(
      tag: widget.image,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.image, scale: 200.0),
                fit: BoxFit.fitHeight)),
        child: Stack(children: [
          Center(
            child: Card(
              color: Colors.transparent,
              child: Text(
                widget.info,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.black
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomLeft,

            //hena haykhod el info mn el database
            child: RaisedButton(
              child: Icon(Icons.volume_down),
              onPressed: () => speak(),
            ),
          ),
          Container(
              alignment: Alignment.bottomRight,

              //hena haykhod el info mn el database
              child: RaisedButton(
                
                  child: Icon(Icons.video_library),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideoDemo(vid:widget.vid)),
                      ))),
                      
        ]),
      ),
    ));
  }

  speak() async {
    await flutterTts.speak(widget.info);
  }
}
