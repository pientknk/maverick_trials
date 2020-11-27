import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/models/base/filter_item.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/models/base/sort_item.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class FirebaseTrialRepository extends Repository<Trial> {
  @override
  Future<Trial> add(Trial data) async {
    if(data?.id != null){
      DocumentSnapshot trialSnapshot = await dbAPI.addDocument(FirestoreAPI.trialsCollection,
        data.toJson(), docID: data.id);
      return Trial().fromSnapshot(trialSnapshot);
    }
    else{
      throw Exception('Error Adding new Trial');
    }
  }

  @override
  Future<bool> delete(Trial data) {
    return dbAPI.removeDocument(FirestoreAPI.trialsCollection, data.id);
  }

  @override
  Future<Trial> get(String id) async {
    DocumentSnapshot trialSnapshot =
      await dbAPI.getDocumentById(FirestoreAPI.trialsCollection, id);
    return Trial().fromSnapshot(trialSnapshot);
  }

  @override
  Future<List<Trial>> getList({
    SearchItem searchItem = const SearchItem(collectionName: FirestoreAPI.trialsCollection)
  }) async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(searchItem);

    if(querySnapshot != null){
      return querySnapshot.documents
        .map((documentSnapshot) => Trial().fromSnapshot(documentSnapshot))
        .toList();
    }
    else{
      return List.empty();
    }
  }

  @override
  Future<bool> update(Trial data) {
    return dbAPI.updateDocument(data.toJson(),
      path: FirestoreAPI.trialsCollection,
      id: data.name,
      isIDUpdatable: true,
      reference: data.reference,
    );
  }

  @override
  Stream<List<Trial>> getStreamList({
    SearchItem searchItem = const SearchItem(collectionName: FirestoreAPI.trialsCollection)
  }) {
    Stream<QuerySnapshot> querySnapshots = dbAPI.getStreamDataCollection(searchItem);

    if(querySnapshots != null){
      return querySnapshots.map((querySnapshot) => querySnapshot.documents
        .map((documentSnapshot) => Trial().fromSnapshot(documentSnapshot))
        .toList()
      );
    }
    else{
      return Stream.empty();
    }
    //usage - await for(List<Trial> trials in getStreamList())
  }

  Future<List<Trial>> getTrialsByFilterAndSort(
    {List<FilterItem> filterItems, List<SortItem> sortItems}) async {
    //TODO: make this filter and sorting work to get trials
    return List<Trial>();
  }

  static Map<TrialFields, String> dbFieldNames = Map.fromIterable(
    TrialFields.values,
    key: (trialField) => trialField,
    value: (trialField) => _getDbFieldNames(trialField),
  );

  static String _getDbFieldNames(TrialFields trialField){
    switch(trialField){
      case TrialFields.createdTime:
        return 'ct';
      case TrialFields.creatorUserCareerID:
        return 'cr';
      case TrialFields.name:
        return 'n';
      case TrialFields.description:
        return 'd';
      case TrialFields.rules:
        return 'rls';
      case TrialFields.winCondition:
        return 'wc';
      case TrialFields.tieBreaker:
        return 'tb';
      case TrialFields.trialRunCount:
        return 'trc';
      case TrialFields.trialType:
        return 'tt';
      case TrialFields.requirements:
        return 'rq';
      case TrialFields.gameCount:
        return 'gc';
      case TrialFields.uID:
        return 'uid';
      default:
        locator<Logging>().log(LogType.pretty, LogLevel.error, 'No TrialField mapping found in dbFieldNames for $trialField');
        return null;
    }
  }
}
