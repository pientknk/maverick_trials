import 'package:flutter/material.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class FirestoreTrackerView extends StatefulWidget {
  @override
  _FirestoreTrackerViewState createState() => _FirestoreTrackerViewState();
}

class _FirestoreTrackerViewState extends State<FirestoreTrackerView> {
  FirestoreAPI dbAPI = locator<FirestoreAPI>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Tracker'),
      ),
      body: ListView(
        children: _getFirestoreTrackerInfo(),
      ),
    );
  }

  List<Widget> _getFirestoreTrackerInfo(){
    List<Widget> listTiles = List<Widget>();
    dbAPI.firestoreTracker.collectionDataMap.forEach((key, value) {
      listTiles.add(ListTile(
        title: Text(key),
        subtitle: Text(value.toString()),
      ));
    });

    return listTiles;
  }
}
