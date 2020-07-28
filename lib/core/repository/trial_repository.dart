import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class TrialRepository extends Repository {
  Future<Trial> addTrial(Trial trial) async {
    DocumentReference trialRef =
        await dbAPI.addDocument(FirestoreAPI.trialsCollection, trial.toJson());
    DocumentSnapshot trialSnapshot = await trialRef.get();
    return Trial.fromJson(trialSnapshot.data);
  }

  Future<void> removeTrial(Trial trial) async {
    return await dbAPI.removeDocument(
        FirestoreAPI.trialsCollection, trial.name);
  }

  Future<Trial> updateTrial(Trial trial) async {
    await dbAPI.updateDocument(
        FirestoreAPI.trialsCollection, trial.toJson(), trial.name);
    return trial;
  }

  Future<Trial> getTrial(String id) async {
    DocumentSnapshot trialSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.trialsCollection, id);
    return Trial.fromJson(trialSnapshot.data);
  }
}
