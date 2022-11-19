/*import 'package:brew_crew/screens/authenticate/dummy.dart';
import 'package:brew_crew/screens/buspass.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';



class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);
  final AuthService _auth=AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title:Text('Easy Bus'),
        backgroundColor: Colors.green,
        elevation: 0.0,
        actions: [
          TextButton.icon(
              icon:Icon(Icons.person,
                color: Colors.black,
              ),
              label:Text('logout',
              style: TextStyle(color: Colors.black)
              ),
              onPressed: () async{
                await _auth.signOut();
              },


          )
        ],
      ),
      body:Center(

          child: Container(

            child: Padding(
              padding: const EdgeInsets.all(120),
              child: Column(
                  children: [

                  TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => dummy()),
                    );
                  },

              icon: Icon(
              Icons.edit_location,
              color:Colors.brown,


            ),
            label:Text(
                'Track your bus',
                style: TextStyle(
                  color:Colors.brown,
                )
            ),
          ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => busspass()),
                        );
                      },

                      icon: Icon(
                        Icons.edit_location,
                        color:Colors.brown,


                      ),
                      label:Text(
                          'Bus Pass',
                          style: TextStyle(
                            color:Colors.brown,
                          )
                      ),
                    ),


          ],
        ),
      ),
    ),

    ),
    );
  }
}

*/
import 'package:brew_crew/screens/authenticate/dummy.dart';
import 'package:brew_crew/screens/buspass.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  List<String> items =['1D', '2D', '3D', '4D', '5D', '6D', '20K', '21K', '22K', '23K', '11E', '12E', '13E', '14E', '15E'];
  String? selectedItem = '1D';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService(bid: 'track').bus,
      initialData: null,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/211.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('easyBus'),
            backgroundColor: Colors.purpleAccent,
            elevation: 0.0,
            actions : <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person, color: Colors.white),
                label: Text('logout',
                  style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(120),
              child: Column(
                children: [
                  Text(
                    'Select your bus',
                    style:TextStyle(fontSize:20, fontWeight: FontWeight.bold, color:Colors.black),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 100,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 3, color: Colors.purple),
                          )
                      ),
                      value: selectedItem,
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 24)),
                      )).toList(),
                      onChanged: (item) => setState(() => selectedItem = item),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  FlatButton.icon(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => dummy()),
                    );
                  }, icon: Icon(Icons.directions_bus_rounded), label: Text('Track your Bus'), color: Colors.grey[200]),

                  SizedBox(height: 25.0),
                  FlatButton.icon(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => busspass()),
                    );
                  }, icon: Icon(Icons.credit_card), label: Text('View bus pass'), color: Colors.grey[200])
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}