import 'package:brew_crew/screens/authenticate/reset.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final toggleView;
  SignIn({this.toggleView});


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool _passvisible=false;
  //text field state
  String email='';
  String password='';
  String error='';
  void initState(){
    _passvisible=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        elevation:0.0,
        title:Text('Sign in to EasyBus'),
        actions: [
          TextButton.icon(
            icon:Icon(Icons.person,
              color: Colors.white),

            label:Text('Register',
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
                  decoration: textInputDecoration.copyWith(hintText: 'Email', fillColor: Colors.grey[200],),
                  validator:(val)=>val!.isEmpty ? 'Enter an email':null,
                  onChanged:(val){

                setState(() {
                  email=val;
                });

              }
                ),),
              SizedBox(height: 20.0),
              Flexible(
              child:TextFormField(



                obscureText: !_passvisible,
                  decoration: textInputDecoration.copyWith(hintText: 'Password',
                    fillColor: Colors.grey[200],
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
              SizedBox(height: 10.0),
              Flexible(
              child:TextButton(

                child: Text('Forgot Password',
                style: TextStyle(color: Colors.blue[900]),),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Reset()),
      );
    }
              ),),

              SizedBox(height: 10.0),
              Flexible(
              child:ElevatedButton(

                  child: Text(
                    'Sign in',
                    style:TextStyle(color:Colors.white),
                  ),
                onPressed: () async{
                  if (_formKey.currentState!.validate()){
                    dynamic result=await _auth.signInwithEmailAndPassword(email, password);

                   if(result==null)
                    {
                      setState(() {
                        error='could not sign in with those credentials';
                      });
                    }
                  }


                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent[700],
                ),


              ),),


              SizedBox(height:12.0),
              Flexible(
              child:Text(
                error,
                style:TextStyle(color:Colors.red[600],fontSize: 14.0),
              ),),

            ],

          ),

        ),
      ),


    );

  }

   String getemail(){
    return email;
  }
}
