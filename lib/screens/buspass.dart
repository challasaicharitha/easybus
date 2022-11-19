import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart' as signin;
import 'home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
class busspass extends StatefulWidget {
  const busspass({Key? key}) : super(key: key);

  @override
  State<busspass> createState() => _busspassState();
}

class _busspassState extends State<busspass> {



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('Bus-Pass'),
      ),
      body: Center(

          child:Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
            const ListTile(

            title: Text(
                'Fee-Status',
                style: TextStyle(fontSize: 30.0)
            ),
            subtitle: Text(
                'Student has no fee dues.',
                style: TextStyle(fontSize: 18.0)
            ),
          ),
  ]
      )

      )
      )

    );
  }
}
