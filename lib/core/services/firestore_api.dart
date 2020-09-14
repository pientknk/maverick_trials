import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maverick_trials/core/models/search_item.dart';

class FirestoreAPI {
  final Firestore _db = Firestore.instance;

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
    {SearchItem searchItem}) {
    return _db
        .collection(searchItem.collectionName)
        .limit(1)
        .where(searchItem.fieldName, isEqualTo: searchItem.value)
        .getDocuments();
  }

  Future<QuerySnapshot> getDataCollection(SearchItem searchItem, {int limit = 10}) {
    return _db.collection(searchItem.collectionName).limit(limit).getDocuments();
  }

  Stream<QuerySnapshot> getStreamDataCollection(SearchItem searchItem,
    {int limit = 10,}){
    return _db.collection(searchItem.collectionName).limit(limit).snapshots();
  }

  Stream<QuerySnapshot> getStreamDataCollectionByField(SearchItem searchItem, {int limit = 10}){
    return _db.collection(searchItem.collectionName)
      .limit(limit)
      .where(searchItem.collectionName, isEqualTo: searchItem.value).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String path, String id) {
    return _db.collection(path).document(id).get();

    /*if(id.isNotEmpty){
      return _db.collection(path).document(id).get();
    }
    else{
      return Future.error('Cannot get document by ID when no id is specified');
    }

     */
  }

  Future<void> removeDocument(String path, String id) {
    return _db.collection(path).document(id).delete();
  }

  Future<bool> addDocument(String path, Map data, {String docID}) async {
    bool success = true;
    if(docID == null) {
      await _db.collection(path).add(data).catchError((error) {
        success = false;
        print('Error in add document firestore api: $error');
      });
    }
    else{
      await _db.collection(path).document(docID).setData(data, merge: true);
    }

    return success;
  }

  Future<void> updateDocument(String path, Map data, String id) {
    return _db.collection(path).document(id).updateData(data);
  }

  static const String trialsCollection = "trials";
  static const int trialsSnapshotLimit = 2;
  static const String gamesCollection = "games";
  static const int gamesSnapshotLimit = 2;
  static const String usersCollection = "users";
  static const int usersSnapshotLimit = 2;
  static const String settingsCollection = 'settings';
}
