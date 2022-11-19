import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/buses.dart';
class DatabaseService{

  final String bid;
  DatabaseService({ required this.bid});

  final CollectionReference LocationCollection = FirebaseFirestore.instance.collection('mapsone');



  Stream<QuerySnapshot> get bus{
    return LocationCollection.snapshots();
  }

}