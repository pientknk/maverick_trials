import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/base/filter_item.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/models/base/sort_item.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class FirebaseTrialRepository extends Repository<Trial> {
  @override
  Future<Trial> add(Trial data) async {
    DocumentSnapshot trialSnapshot = await dbAPI.addDocument(FirestoreAPI.trialsCollection, data.toJson(), docID: data.name);
    return Trial().fromSnapshot(trialSnapshot);
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

  static Map<TrialFields, String> dbFieldNames =
  <TrialFields, String>{
    TrialFields.createdTime: 'ct',
    TrialFields.creatorUserCareerID: 'cr',
    TrialFields.name: 'n',
    TrialFields.description: 'd',
    TrialFields.rules: 'rls',
    TrialFields.winCondition: 'wc',
    TrialFields.tieBreaker: 'tb',
    TrialFields.trialRunCount: 'trc',
    TrialFields.trialType: 'tt',
    TrialFields.requirements: 'rq',
    TrialFields.gameCount: 'gc',
    TrialFields.uID: 'uid'
  };
}
