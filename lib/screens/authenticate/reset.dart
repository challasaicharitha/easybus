import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Reset extends StatefulWidget {
  final toggleView;
  Reset({this.toggleView});
 // const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
 final AuthService _auth=AuthService();
 //final auth=FirebaseAuth.instance;







  final _formKey=GlobalKey<FormState>();
  //text field state
  String email='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        elevation:0.0,
        title:Text('Reset Password'),

      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/211.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child :Form(
          key:_formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email', fillColor: Colors.grey[200]),
                  validator:(val)=>val!.isEmpty ? 'Enter an email':null,
                  onChanged:(val){

                    setState(() {
                      email=val;
                    });

                  }
              ),



              SizedBox(height: 20.0),
              ElevatedButton(

                child: Text(
                  'Send Request',
                  style:TextStyle(color:Colors.white),
                ),
                onPressed: () {

                 // auth.sendPasswordResetEmail(email: email);
                  _auth.sendPasswordResetEmail(email);
                  Navigator.of(context).pop();



                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent[700],
                ),


              ),



            ],

          ),

        ),
      ),

    );
  }
}
