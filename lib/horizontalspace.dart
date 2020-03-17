import 'package:flutter/material.dart';

class HSpacer extends StatelessWidget {
  final double ratio;

  const HSpacer(this.ratio, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     width: MediaQuery.of(context).size.width*ratio,
    );
  }
}