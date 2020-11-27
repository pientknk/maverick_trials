import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

///
/// The intent is to use this to create an object that keeps track of CRUD operations done
/// to firestore for personal tracking/logging - especially since firestore only updates every 2 hours
///
class FirestoreTracker {
  Map<String, CollectionData> collectionDataMap;

  FirestoreTracker(){
    _setCollectionDataMap();
  }

  void _setCollectionDataMap(){
    collectionDataMap = <String, CollectionData>{
      FirestoreAPI.usersCollection : CollectionData(FirestoreAPI.usersCollection),
      FirestoreAPI.trialsCollection : CollectionData(FirestoreAPI.trialsCollection),
      FirestoreAPI.gamesCollection : CollectionData(FirestoreAPI.gamesCollection),
      FirestoreAPI.settingsCollection : CollectionData(FirestoreAPI.settingsCollection),
    };
  }

  void updateTracker({String collectionName, TrackerType trackerType, int amount}){
    if(collectionDataMap.containsKey(collectionName)){
      CollectionData collectionData = collectionDataMap[collectionName];
      switch(trackerType){
        case TrackerType.create:
          collectionData.creates += amount;
          break;
        case TrackerType.read:
          collectionData.reads += amount;
          break;
        case TrackerType.update:
          collectionData.updates += amount;
          break;
        case TrackerType.delete:
          collectionData.deletes += amount;
          break;
        case TrackerType.error:
          print('not implemented yet');
          break;
      }
    }
    else{
      String errorMsg = 'key: $collectionName not found in FirestoreTracker';
      locator<Logging>().log(LogType.pretty, LogLevel.debug, errorMsg);
    }
  }

  void resetTracker(){
    collectionDataMap.values.forEach((collectionData) => collectionData.reset());
  }

  @override
  String toString() {
    String collectionData = '';
    collectionDataMap.forEach((key, value) {
      collectionData += value.toString();
      collectionData += '\t';
    });

    return 'FirestoreTracker { '
      ' $collectionData '
      ' }';
  }
}

enum TrackerType { create, read, update, delete, error }

class CollectionData {
  String collectionName;
  int creates;
  int reads;
  int updates;
  int deletes;

  CollectionData(this.collectionName){
    creates = 0;
    reads = 0;
    updates = 0;
    deletes = 0;
  }

  @override
  String toString() {
    return 'Creates: $creates | Reads: $reads |'
      ' Updates: $updates | Deletes: $deletes';
  }

  void reset(){
    creates = 0;
    reads = 0;
    updates = 0;
    deletes = 0;
  }
}