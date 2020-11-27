import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/caches/setings_cache.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class FirebaseSettingsRepository extends Repository<Settings> {
  SettingsCache _settingsCache = SettingsCache();

  @override
  Future<Settings> add(Settings data) async {
    if(data?.id != null){
      print("adding settings: ${data.toString()}");
      DocumentSnapshot settingsSnapshot = await dbAPI.addDocument(
        FirestoreAPI.settingsCollection, data.toJson(),
        docID: data.id);
      Settings settings = Settings().fromSnapshot(settingsSnapshot);
      _settingsCache.addData(settings);

      return settings;
    }
    else{
      throw Exception('Error Adding new Settings');
    }
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

  Future<Settings> addNewUserSettings(User user) async {
    Settings settings = Settings()
      ..isDarkMode = true
      ..docID = user.firebaseUser.uid;
    return add(settings);
  }

  static String _getDbFieldName(SettingsFields settingsField){
    switch (settingsField) {
      case SettingsFields.isDarkMode:
        return 'dm';
      case SettingsFields.allowFriendsEditTrial:
        return 'aet';
      case SettingsFields.allowFriendsEditGame:
        return 'aeg';
      default:
        locator<Logging>().log(LogType.pretty, LogLevel.error,
          'No SettingsField mapping found in dbFieldNames for $settingsField');
        return null;
    }
  }

  static Map<SettingsFields, String> dbFieldNames = Map.fromIterable(
    SettingsFields.values,
    key: (settingsField) => settingsField,
    value: (settingsField) => _getDbFieldName(settingsField),
  );
}