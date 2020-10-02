import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/filter_item.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'package:maverick_trials/core/models/sort_item.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class FirebaseTrialRepository extends Repository {
  Future<void> addTrial(Trial trial) async {
    await dbAPI.addDocument(FirestoreAPI.trialsCollection, trial.toJson(), docID: trial.name);
  }

  Future<void> removeTrial(Trial trial) async {
    return await dbAPI.removeDocument(
        FirestoreAPI.trialsCollection, trial.name);
  }

  Future<void> updateTrial(Trial trial) async {
    await dbAPI.updateDocument(
        FirestoreAPI.trialsCollection, trial.toJson(), trial.name);
    return trial;
  }

  Future<Trial> getTrial(String id) async {
    DocumentSnapshot trialSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.trialsCollection, id);
    return Trial.fromJson(trialSnapshot.data);
  }

  Future<List<Trial>> getTrials() async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(
      SearchItem(collectionName: FirestoreAPI.trialsCollection));

    print('Firestore: ${querySnapshot.documents.length} reads for Trials');
    return querySnapshot.documents
        .map((documentSnapshot) => Trial.fromJson(documentSnapshot.data))
        .toList();
  }

  Future<List<Trial>> getTrialsByFilterAndSort(
      {List<FilterItem> filterItems, List<SortItem> sortItems}) async {
    //TODO: make this filter and sorting work to get trials
    return List<Trial>();
  }

  Stream<List<Trial>> getTrialStream() {
    return dbAPI
        .getStreamDataCollection(SearchItem(
      collectionName: FirestoreAPI.trialsCollection,
    ))
        .map((querySnapshot) {
      return querySnapshot.documents
          .map((docSnapshot) => Trial.fromJson(docSnapshot.data));
    });
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
