import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:maverick_trials/core/models/base/data_model.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_trial_repository.dart';

class Trial extends DataModel<Trial> {
  String uID;
  DateTime createdTime;
  String creatorUserCareerID; //this is the same as user nickname
  String name;
  String description;
  String rules;
  String winCondition;
  String tieBreaker;
  String ratingID; //ratingID == this.name of trial
  int trialRunCount;
  String trialType;
  String requirements;
  int gameCount;

  Trial();

  factory Trial.newTrial() {
    return Trial()
      ..createdTime = DateTime.now()
      ..trialRunCount = 0
      ..gameCount = 0;
  }

  Trial._withProperties(
      {@required this.createdTime,
      @required this.creatorUserCareerID,
      @required this.name,
      @required this.description,
      @required this.rules,
      @required this.winCondition,
      @required this.trialType,
      this.tieBreaker,
      this.trialRunCount,
      this.requirements,
      this.gameCount,
      this.uID}) {
    this.ratingID = this.name;
    //this.lockedByCreator = true; //assign this value from user prefs setting
  }

  factory Trial.fromJson(Map<dynamic, dynamic> json) => _trialFromJson(json);

  Map<String, dynamic> toJson() => _trialToJson(this);

  static Map<TrialFields, String> friendlyFieldNames = <TrialFields, String>{
    TrialFields.createdTime: 'Created Time',
    TrialFields.creatorUserCareerID: 'Creator',
    TrialFields.name: 'Name',
    TrialFields.description: 'Description',
    TrialFields.rules: 'Rules',
    TrialFields.winCondition: 'Win Condition',
    TrialFields.tieBreaker: 'Tie Breaker',
    TrialFields.trialRunCount: 'Trial Runs',
    TrialFields.trialType: 'Trial Type',
    TrialFields.requirements: 'Requirements',
    TrialFields.gameCount: 'Games',
    TrialFields.uID: 'Creator ID',
  };

  @override
  String toString() => 'Trial { $name, $description, $createdTime }';

  @override
  Trial fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      Trial trial = Trial.fromJson(snapshot.data);
      if(trial == null){
        return Trial();
      }

      trial.reference = snapshot.reference;
      return trial;
    } else {
      return null;
    }
  }

  @override
  bool operator ==(obj) {
    if (obj is Trial) {
      return obj.name == name;
    }

    return false;
  }

  @override
  int get hashCode {
    return name.hashCode;
  }

  @override
  String get id => name;
}

Trial _trialFromJson(Map<dynamic, dynamic> json) {
  if (json != null) {
    return Trial._withProperties(
        createdTime:
            (json[FirebaseTrialRepository.dbFieldNames[TrialFields.createdTime]]
                    as Timestamp)
                .toDate(),
        creatorUserCareerID:
            json[FirebaseTrialRepository.dbFieldNames[TrialFields.creatorUserCareerID]]
                as String,
        name: json[FirebaseTrialRepository.dbFieldNames[TrialFields.name]]
            as String,
        description:
            json[FirebaseTrialRepository.dbFieldNames[TrialFields.description]]
                as String,
        rules: json[FirebaseTrialRepository.dbFieldNames[TrialFields.rules]]
            as String,
        winCondition:
            json[FirebaseTrialRepository.dbFieldNames[TrialFields.winCondition]]
                as String,
        trialType:
            json[FirebaseTrialRepository.dbFieldNames[TrialFields.trialType]]
                as String,
        tieBreaker:
            json[FirebaseTrialRepository.dbFieldNames[TrialFields.tieBreaker]] as String,
        trialRunCount: json[FirebaseTrialRepository.dbFieldNames[TrialFields.trialRunCount]] as int ?? 0,
        requirements: json[FirebaseTrialRepository.dbFieldNames[TrialFields.requirements]] as String,
        gameCount: json[FirebaseTrialRepository.dbFieldNames[TrialFields.gameCount]] as int ?? 0,
        uID: json[FirebaseTrialRepository.dbFieldNames[TrialFields.uID]] as String);
  } else {
    return null;
  }
}

Map<String, dynamic> _trialToJson(Trial instance) => <String, dynamic>{
      FirebaseTrialRepository.dbFieldNames[TrialFields.createdTime]:
          Timestamp.fromDate(instance.createdTime),
      FirebaseTrialRepository.dbFieldNames[TrialFields.creatorUserCareerID]:
          instance.creatorUserCareerID,
      FirebaseTrialRepository.dbFieldNames[TrialFields.name]: instance.name,
      FirebaseTrialRepository.dbFieldNames[TrialFields.description]:
          instance.description,
      FirebaseTrialRepository.dbFieldNames[TrialFields.rules]: instance.rules,
      FirebaseTrialRepository.dbFieldNames[TrialFields.winCondition]:
          instance.winCondition,
      FirebaseTrialRepository.dbFieldNames[TrialFields.tieBreaker]:
          instance.tieBreaker,
      FirebaseTrialRepository.dbFieldNames[TrialFields.trialRunCount]:
          instance.trialRunCount,
      FirebaseTrialRepository.dbFieldNames[TrialFields.trialType]:
          instance.trialType,
      FirebaseTrialRepository.dbFieldNames[TrialFields.requirements]:
          instance.requirements,
      FirebaseTrialRepository.dbFieldNames[TrialFields.gameCount]:
          instance.gameCount,
      FirebaseTrialRepository.dbFieldNames[TrialFields.uID]: instance.uID,
    };

enum TrialFields {
  createdTime,
  creatorUserCareerID,
  name,
  description,
  rules,
  winCondition,
  tieBreaker,
  trialRunCount,
  trialType,
  requirements,
  gameCount,
  uID,
}
