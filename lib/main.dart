import 'package:flutter/material.dart';
import 'package:flutter_gawlah/Register.dart';
import 'package:flutter_gawlah/auth.dart';
import 'package:flutter_gawlah/sign_in.dart';
import 'vedio.dart';
import 'package:provider/provider.dart';
import 'Tours_Pager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'auth.dart';
import 'wrapper.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(title: 'Flutter Gawlah', home: TourList2()));
  }
}
// import 'package:flutter/material.dart';
// import 'package:ola_like_country_picker/ola_like_country_picker.dart';
// import 'package:ola_like_country_picker/src/country_picker.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   CountryPicker c;
//   Country country = Country.fromJson(countryCodes[94]);

//   @override
//   void initState() {
//     super.initState();
//     c = CountryPicker(onCountrySelected: (Country country) {
//       print(country);
//       setState(() {
//         this.country = country;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image:
//                 AssetImage(country.flagUri, package: 'ola_like_country_picker'),
//           ),
//         ),
//       ),
//       onTap: () {
//         c.launch(context);
//       },
//     );
//   }
// }