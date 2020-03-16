import 'package:flutter/material.dart';
import 'package:flutter_gawlah/Tours_Pager.dart';
import 'package:flutter_gawlah/sign_in.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';
import 'auth.dart';
import 'constants.dart';
import 'loading.dart';
class Register extends StatefulWidget {
  
final Function toggleView;
Register({this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

   final AuthService _auth= AuthService();
   final _formKey=GlobalKey<FormState>();
    bool loading=false;

  //text field State
  String email='';
  String password='';
  String error='';
  Country country = Country.fromJson(countryCodes[94]);
  @override
  Widget build(BuildContext context) {
      CountryPicker  c = CountryPicker(onCountrySelected: (Country country) {
      print(country);
      setState(() {
        this.country = country;
      });
    });
     return loading? Loading():Scaffold(
    backgroundColor: Color.fromRGBO(38 , 47 , 62, 1),
    appBar: AppBar(backgroundColor: Colors.indigo[900],
    elevation: 0.0,
    title: Text('Sign-Up to Gawlah'),
    actions: <Widget>[
      FlatButton.icon(
        icon: Icon(Icons.person),
        label:Text('Sign In'),
        onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignIn()));

        },
      )
    ],

    ),
    body: Container(
     padding:EdgeInsets.symmetric(vertical:20,horizontal:50),
     child: Form(
       key: _formKey,
        child:Column(
        children: <Widget>[
          SizedBox(height: 20),
          TextFormField(decoration:textInputDecoration.copyWith(hintText:'Email'),
            validator: (val)=> val.isEmpty?'Enter an email': null,
            onChanged: (val){
              setState(()=> email = val);
             
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText:'Password'),
            obscureText: true,
            validator: (val)=> val.length<6?'Enter a password 6+ chars long ': null,
            onChanged:(val){
              setState(()=> password = val);

            }
          ),

  SizedBox(height: 20),
           RaisedButton(
            color: Colors.indigo,
            child: Text('Select Your Country', style: TextStyle(color:Colors.white),
            
            ),onPressed: (){
              c.launch(context);

            },


           ),





          SizedBox(height: 20),
          RaisedButton(
            color: Colors.indigo[900],
            child: Text('Register', style: TextStyle(color:Colors.white),
            
            ),
            onPressed: ()async{
            if(_formKey.currentState.validate()){
               setState(() =>loading=true
              
              );
               dynamic result = await _auth.registerwithemailandpass(email, password);
              Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TourList2()));
             if(result==null){
                loading=false;
               setState(() =>'please supply a valid email');

             }
            }

            }
            
          
          
          
          ),
          SizedBox(height: 12),
          Text(error,style:TextStyle(color:Colors.red,fontSize: 14.0)),

        ],

        ) 
       
       
       )



    ),
    );
  }
  
}