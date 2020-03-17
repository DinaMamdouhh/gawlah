
import 'package:flutter/material.dart';

class VSpacer extends StatelessWidget {
  final double ratio;

  const VSpacer(this.ratio, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     height: MediaQuery.of(context).size.height*ratio,
    );
  }
}