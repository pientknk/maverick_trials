import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class FirebaseSettingsRepository extends Repository<Settings> {
  @override
  Future<Settings> add(Settings data) async {
    DocumentSnapshot settingsSnapshot = await dbAPI.addDocument(
      FirestoreAPI.settingsCollection, data.toJson(),
      docID: data.id);
    return Settings().fromSnapshot(settingsSnapshot);
  }

  @override
  Future<bool> delete(Settings data) {
    return dbAPI.removeDocument(FirestoreAPI.settingsCollection, data.id);
  }

  @override
  Future<Settings> get(String id) async {
    DocumentSnapshot documentSnapshot = await dbAPI.getDocumentById(FirestoreAPI.settingsCollection, id);
    return Settings().fromSnapshot(documentSnapshot);
  }

  @override
  Future<List<Settings>> getList({
    SearchItem searchItem = const SearchItem(collectionName: FirestoreAPI.settingsCollection)
  }) async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(searchItem);

    if(querySnapshot != null){
      return querySnapshot.documents.
      map((documentSnapshot) => Settings().fromSnapshot(documentSnapshot))
        .toList();
    }
    else{
      return List.empty();
    }
  }

  @override
  Future<bool> update(Settings data) {
    return dbAPI.updateDocument(data.toJson(),
      path: FirestoreAPI.settingsCollection,
      id: data.reference.documentID,
      isIDUpdatable: false,
      reference: data.reference,
    );
  }

  @override
  Stream<List<Settings>> getStreamList({
    SearchItem searchItem = const SearchItem(collectionName: FirestoreAPI.settingsCollection)
  }) {
    Stream<QuerySnapshot> querySnapshots = dbAPI.getStreamDataCollection(searchItem);

    if(querySnapshots != null){
      return querySnapshots.map((querySnapshot) => querySnapshot.documents
        .map((documentSnapshot) => Settings().fromSnapshot(documentSnapshot))
        .toList()
      );
    }
    else{
      return Stream.empty();
    }
  }

  Future<Settings> addNewUserSettings() async {
    Settings settings = Settings()
      ..isDarkMode = true;
    return add(settings);
  }

  static Map<SettingsFields, String> dbFieldNameBySettingsField =
  <SettingsFields, String>{
    SettingsFields.isDarkMode: 'dm',
    SettingsFields.avatarLink: 'a',
    SettingsFields.allowFriendsEditTrial: 'aet',
    SettingsFields.allowFriendsEditGame: 'aet',
  };
}