

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:email_auth/email_auth.dart';
import 'package:brew_crew/screens/verify.dart';
class Register extends StatefulWidget {
  final toggleView;
  Register({this.toggleView});




  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();

  bool _passvisible=false;
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _emailcontroller=TextEditingController();
  final TextEditingController _otpcontroller=TextEditingController();
  EmailAuth emailAuth =  new EmailAuth(sessionName: "Sample session");
  void sendOTP() async{
    var res=await emailAuth.sendOtp(recipientMail: _emailcontroller.text);
    if(res){
      print("OTP SENT");
    }
    else
      {
        print("OTP NOT SENT");
      }
  }
  var _isright=1;
  void verifyOTP() async{
    var response=emailAuth.validateOtp(recipientMail: _emailcontroller.text, userOtp: _otpcontroller.text);
    if(response){
      print("OTP VERIFIED");
      _isright=1;

    }
    else{
      print("INVALID OTP");
      _isright=0;

    }
  }
  //text field state
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        elevation:0.0,
        title:Text('Sign up to EasyBus'),
        actions: [
          TextButton.icon(
            icon:Icon(Icons.person,
                color: Colors.white),

            label:Text('Sign in',
                style: TextStyle(color: Colors.white)
            ),
            onPressed: (){
              widget.toggleView();

            },

          )
        ],
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
             Flexible(
              child:TextFormField(

                controller: _emailcontroller,
                decoration: textInputDecoration.copyWith(hintText: 'Email',
                  fillColor: Colors.grey[200],
                  /*suffixIcon: TextButton(

                      child: Text('SEND OTP',
                      style: TextStyle(color: Colors.blue[900]),),
                    //onPressed: ()=>sendOTP(),
                    onPressed: (){
                        sendOTP();

                    },
                  )*/
                ),
                  validator:(val){
                  if(!val!.contains("@")) return 'not an email';
                  var val1=val!.split('@');


                  if(val.isEmpty) return 'Enter an email';
                  else if(val1[1]!='gnits.in' ) return 'Enter only gnits email';
                  else
                    return null;

                  },//=>val!.isEmpty  ? 'Enter an email':null,


                  onChanged:(val){

                setState(() {
                  email=val;
                });


              }

              ),
             ),


              SizedBox(height: 20.0),
              Flexible(
              child:TextFormField(
                  obscureText: !_passvisible,
                  decoration:textInputDecoration.copyWith(hintText: 'Password',fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passvisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passvisible = !_passvisible;
                        });
                      },
                    ),
                  ),

                  validator:(val)=>(val?.length ?? 0) < 6 ? 'Enter a password 6+ chars':null,
                  onChanged: (val){
                    setState(() {
                      password=val;
                    });

                  }
              ),
              ),
              SizedBox(height: 5.0),
             /* Expanded(
              child:TextFormField(
                controller: _otpcontroller,



                  decoration:textInputDecoration.copyWith(
                      hintText: 'OTP',
                     suffixIcon: TextButton(
                        child: Text('VERIFY OTP',
                        style:TextStyle(color:Colors.blue[900])),
                       // onPressed: ()=>,
                       onPressed: (){
                         verifyOTP();

                       },
                      )),
               // validator: (val)=>val!.isEmpty  ? 'Must enter the otp':null,
                validator:(val){
                      verifyOTP();

                  if(val!.isEmpty) return 'Must enter the otp';
                  else if(_isright==0) return 'Invalid otp';
                  else
                    return null;

                },

              ),
              ),*/
         //     SizedBox(height: 10.0),

                ElevatedButton(

                  child: Text(
                    'Register',
                    style:TextStyle(color:Colors.white),
                  ),
                  onPressed: () async{
                   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VerifyScreen()));

                   if (_formKey.currentState!.validate()){


                     dynamic result=await _auth.registerwithEmailAndPassword(email,password);
                     String uid = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance.collection('mapsone').doc(email).set({

                        'email':email,

                        'feestatus':'paid'



                      });
                     if(result==null)
                       {
                         setState(() {
                           error='user is already registered';
                         });
                       }
                     else{
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VerifyScreen()));

                     }


                   }

                  },
                  style: ElevatedButton.styleFrom(

                    primary: Colors.purpleAccent[700],
                  ),


                ),

              SizedBox(height:10.0),
              Text(
                error,
                style:TextStyle(color:Colors.red[600],fontSize: 14.0),
              ),

            ],
          ),
        ),
      ),



    );

  }
  getemail(){
    return email;
  }
}
