import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/caches/cache.dart';
import 'package:maverick_trials/core/caches/cache_manager.dart';
import 'package:maverick_trials/core/exceptions/firestore_exception_handler.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/core/admin/firestore_tracker.dart';

class FirestoreAPI {
  final Firestore _db = Firestore.instance;
  final FirestoreTracker firestoreTracker = FirestoreTracker();
  final CacheManager cacheManager = CacheManager();
  final Logging _logging = locator<Logging>();

  Future<FirebaseApp> getConfiguredFirebaseApp() async {
    return FirebaseApp.configure(
      name: 'Maverick Trials',
      options: const FirebaseOptions(
        googleAppID: '1:702290934781:ios:7471ff9b439db0e5d6b794',
        projectID: 'mavericktrials-43676',
      ),
    );
  }

  FirestoreAPI() {
    Firestore.instance.settings(persistenceEnabled: false);
  }

  Future<QuerySnapshot> getDocumentByField(
    {SearchItem searchItem}) async {
    try{
      QuerySnapshot querySnapshot = await _db
        .collection(searchItem.collectionName)
        .limit(1)
        .where(searchItem.fieldName, isEqualTo: searchItem.value)
        .getDocuments();

      firestoreTracker.updateTracker(
        collectionName: searchItem.collectionName,
        trackerType: TrackerType.read,
        amount: querySnapshot.documents.length,
      );

      return querySnapshot;
    }
    catch(error, st){
      FirestoreExceptionHandler.tryGetMessage(error, st);
      return null;
    }
  }

  Future<QuerySnapshot> getDataCollection(SearchItem searchItem, {int limit = 10}) async {
    try{
      QuerySnapshot querySnapshot = await _db.collection(searchItem.collectionName)
        .limit(limit).getDocuments();

      firestoreTracker.updateTracker(
        collectionName: searchItem.collectionName,
        trackerType: TrackerType.read,
        amount: querySnapshot.documents.length,
      );

      return querySnapshot;
    }
    catch(error, st){
      FirestoreExceptionHandler.tryGetMessage(error, st);
      return null;
    }
  }

  Stream<QuerySnapshot> getStreamDataCollection(SearchItem searchItem,
    {int limit = 10,}){
    try{
      Stream<QuerySnapshot> querySnapshots = _db.collection(searchItem.collectionName).limit(limit).snapshots();

      querySnapshots.length.then((length){
        firestoreTracker.updateTracker(
          collectionName: searchItem.collectionName,
          trackerType: TrackerType.read,
          amount: length,
        );
      });

      return querySnapshots;
    }
    catch(error, st){
      FirestoreExceptionHandler.tryGetMessage(error, st);
      return null;
    }
  }

  Stream<QuerySnapshot> getStreamDataCollectionByField(SearchItem searchItem, {int limit = 10}) {
    try{
      Stream<QuerySnapshot> querySnapshots = _db.collection(searchItem.collectionName)
        .where(searchItem.collectionName, isEqualTo: searchItem.value).limit(limit).snapshots();

      querySnapshots.length.then((length){
        firestoreTracker.updateTracker(
          collectionName: searchItem.collectionName,
          trackerType: TrackerType.read,
          amount: length,
        );
      });

      return querySnapshots;
    }
    catch(error, st){
      FirestoreExceptionHandler.tryGetMessage(error, st);
      return null;
    }
  }

  Future<DocumentSnapshot> getDocumentById(String path, String id) async {
    try{
      DocumentSnapshot docSnapshot = await _db.collection(path).document(id).get();
      if(docSnapshot != null){
        firestoreTracker.updateTracker(
          collectionName: path,
          trackerType: TrackerType.read,
          amount: 1,
        );
      }

      return docSnapshot;
    }
    catch(error, st) {
      FirestoreExceptionHandler.tryGetMessage(error, st);
      return null;
    }
  }

  Future<bool> removeDocument(String path, String id, {Cache cache, dynamic dataModel}) async {
    try{
      await _db.collection(path).document(id).delete();

      if(cache != null && dataModel != null){
          cache.removeData(dataModel);
      }
      else{
        String errorMsg = 'removeDocument: Cache or data was null so cache couldnt be updated for $path';
        _logging.log(LogType.pretty, LogLevel.info, errorMsg);
      }

      firestoreTracker.updateTracker(
        collectionName: path,
        trackerType: TrackerType.delete,
        amount: 1,
      );

      return true;
    }
    catch(error, st){
      FirestoreExceptionHandler.tryGetMessage(error, st);
      return false;
    }
  }

  Future<DocumentSnapshot> addDocument(String path, Map data, {String docID, Cache cache, dynamic dataModel}) async {
    try{
      DocumentReference docRef = _db.collection(path).document(docID);
      docRef.setData(data);

      DocumentSnapshot docSnapshot = await docRef.get();
      if(docSnapshot != null){
        if(cache != null && dataModel != null){
          cache.addData(dataModel);
        }
        else{
          String errorMsg = 'addDocument: Cache or data was null so cache couldnt be updated for $path';
          _logging.log(LogType.pretty, LogLevel.info, errorMsg);
        }

        firestoreTracker.updateTracker(
          collectionName: path,
          trackerType: TrackerType.create,
          amount: 1,
        );
      }

      return docSnapshot;
    }
    catch(error, st){
      FirestoreExceptionHandler.tryGetMessage(error, st);
      return null;
    }
  }

  Future<bool> updateDocument(Map data, {
    @required String path,
    @required String id,
    @required bool isIDUpdatable,
    @required DocumentReference reference,
    Cache cache,
    dynamic dataModel,
  }) async {
    bool didUpdate = false;

    if(isIDUpdatable && reference.documentID != id){
      DocumentSnapshot docSnapshot = await addDocument(path, data, docID: id);
      
      if(docSnapshot != null){
        bool deleted = await removeDocument(path, id);
        if(deleted == false){
          String message = 'Error deleting document within updateDocument() after adding new doc';
          _logging.log(LogType.pretty, LogLevel.warning, message);
        }

        didUpdate = deleted;
      }
    }
    else{
      try{
        _logging.log(LogType.pretty, LogLevel.info, 'Setting data to firestore: \n ${data.toString()}');
        await reference.setData(data, merge: true);
        didUpdate = true;
      }
      catch(error, st){
        FirestoreExceptionHandler.tryGetMessage(error, st);
      }
    }

    if(didUpdate){
      if(cache != null && dataModel != null){
        cache.addData(dataModel);
      }
      firestoreTracker.updateTracker(
        collectionName: path,
        trackerType: TrackerType.update,
        amount: 1,
      );
    }

    return didUpdate;
  }

  static const String trialsCollection = "trials";
  static const int trialsSnapshotLimit = 2;
  static const String gamesCollection = "games";
  static const int gamesSnapshotLimit = 2;
  static const String usersCollection = "users";
  static const int usersSnapshotLimit = 2;
  static const String settingsCollection = 'settings';
}
