import 'package:flutter/material.dart';
import 'package:flutter_gawlah/Register.dart';
//import 'authenticate.dart';
import 'Tours_Pager.dart';
import 'auth.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';

import 'constants.dart';
import 'loading.dart';
class SignIn extends StatefulWidget {
final Function toggleView;
SignIn({this.toggleView});



  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 
  final AuthService _auth= AuthService();
   final _formKey=GlobalKey<FormState>();
   bool loading=false;
  //text field State
  String email='';
  String password='';
  String error='';
   

    @override
  Widget build(BuildContext context) {
   
 
    return loading? Loading():Scaffold(
    backgroundColor: Color.fromRGBO(38 , 47 , 62, 1),
    appBar: AppBar(backgroundColor: Colors.indigo[900],
    elevation: 0.0,
    title: Text('Sign-In to Gawlah'),
    actions: <Widget>[
      FlatButton.icon(
        icon: Icon(Icons.person),
        label:Text('Register'),
        onPressed: () {
          // widget.toggleView();
           //print(widget.toggleView);
           Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Register()));

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
          TextFormField( decoration: textInputDecoration.copyWith(hintText:'Email'),
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
          
        

          SizedBox(height: 40),
          RaisedButton(
            color: Colors.indigo[900],
            child: Text('Sign in', style: TextStyle(color:Colors.white),
            
            ),
            onPressed: ()async{
            if(_formKey.currentState.validate()){
              setState(() =>loading=true
              
              );

            dynamic result= await _auth.signInwithemailandpass(email, password);
             Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TourList2()));
             if(result==null){
               setState((){ 
                 error='Could not sign in with those credentials';
                loading=false;
               });
               
             }
            }


            },
            
          
          
          
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