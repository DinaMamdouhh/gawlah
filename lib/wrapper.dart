import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate.dart';
import 'auth.dart';
import 'user.dart';
import 'Tours_Pager.dart';
class Wrapper  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   //return either Home or Authenticate widget
   final user = Provider.of<User>(context);
   print(user);
   
  if(user==null){
  return Authenticate();
  }
  else{ return TourList2();

  }
  }
}