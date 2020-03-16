import 'package:flutter/material.dart';

class PlaceProfile extends StatefulWidget {
  final String video;
  PlaceProfile({Key key,this.video}) : super(key: key);

  PlaceProfileState createState() => PlaceProfileState();
}

class PlaceProfileState extends State<PlaceProfile> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hey',
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project_%28454045%29.jpg/810px-Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project_%28454045%29.jpg',
                scale: 200.0 ),
                fit: BoxFit.fitHeight)),
      ),
    );
  }
}
