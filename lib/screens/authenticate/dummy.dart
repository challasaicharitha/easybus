
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';








class dummy extends StatefulWidget {
  const dummy({Key? key}) : super(key: key);
  @override
  State<dummy> createState() => _dummyState();
}

class _dummyState extends State<dummy> {
  late GoogleMapController mapController;










  late Position currentPosition;
  var geoLocator = Geolocator();

  @override
  void dispose(){
    mapController.dispose();
    super.dispose();
  }
  Map<MarkerId,Marker> markers=<MarkerId,Marker>{};
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late BitmapDescriptor icon;
  CollectionReference users = FirebaseFirestore.instance.collection('mapsone');
  var _latitude=17.4116;
  var _longitude=	78.3987;
  var _time='';
  var _t=[];
  var _date='';
  var _finalt='';
  var _min=0;
  var _min2="";
  var _min1=[];


  getMarkerData() {



      FirebaseFirestore.instance.collection("mapsone").snapshots().listen((
          doc) {
        doc.docs.forEach((doc) {
          _latitude = doc.data()['geo'].latitude;
          _longitude = doc.data()['geo'].longitude;
          _date=doc.data()['Date'].toString();




           print(_latitude);
           print(_longitude);


          _time = DateFormat.yMMMd().add_jm().format(
              DateTime.parse(doc.data()['Time'].toDate().toString()));
          _t=_time.split(" ");

          print(_t[3]+_t[4]);

          _finalt=_date+' '+_t[3]+_t[4];

          print(_finalt);



        });
      });


  }

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2),
        "assets/bus1.png");
    setState(() {
      this.icon = icon;
    });
  }

  @override
  void initState(){
    //getMarkerData()
   getMarkerData();
   getIcons();

    super.initState();
    locatePosition();
  }

  locatePosition() async {
    Position position = await _determinePosition();

    CameraPosition cameraPosition = new CameraPosition(
      target:
      LatLng(position.latitude,position.longitude),


      zoom: 14,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }


  @override
  Widget build(BuildContext context) {






    Set<Marker> getMarker(){


      getMarkerData();


      //locatePosition();
      return <Marker>[


        Marker(
          markerId: MarkerId('Bus loc'),

          position: LatLng(17.4193, 78.4485),

          icon: BitmapDescriptor.defaultMarkerWithHue(300),
          infoWindow: InfoWindow(title:'Bus initial'),
        ),
        Marker(
          markerId: MarkerId('Bus loc'),

          position: LatLng(17.4116, 78.3987),

          icon: BitmapDescriptor.defaultMarkerWithHue(270),
          infoWindow: InfoWindow(title:'G.Narayanamma Institute of Technology and Science'),
        ),
        Marker(
          markerId: MarkerId('Bus loc'),
          position: LatLng(_latitude,_longitude),
          icon:icon,
          infoWindow: InfoWindow(title:'BUS',snippet:_finalt),
        )
      ].toSet();
    }
    return Scaffold(
      appBar: AppBar(
        title:Text('Bus Tracking'),
        backgroundColor: Colors.purpleAccent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers:getMarker(),
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(_latitude,_longitude),
                zoom: 15.0,
              ),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              onCameraMove: _updateCameraPosition,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.local_activity_sharp),
        onPressed: () async{
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target:LatLng(_latitude,_longitude),
                zoom:15,
              )
          ));

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }

  void _updateCameraPosition(CameraPosition position)
  {
    setState(() {
      
    });
  }

  void _onMapCreated(GoogleMapController controller)
  {
    setState(() {
      mapController=controller;
      //locatePosition();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, forceAndroidLocationManager: true);
  }

}





