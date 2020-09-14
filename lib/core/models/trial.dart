import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:maverick_trials/core/repository/trial_repository.dart';

//FS
//Read only except for the creator
class Trial {
  //A reference to a Firestore document representing this trial
  DocumentReference reference; //reference.documentID == TrialID
  DateTime createdTime;
  String creatorUserCareerID; //this is the same as user nickname
  String name;
  String description;
  bool lockedByCreator;
  String rules;
  String winCondition;
  String tieBreaker;
  String ratingID; //ratingID == this.name
  int trialRunCount;
  String trialType;
  String requirements;
  int gameCount;

  Trial.newTrial();

  Trial(
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
      this.reference}) {
    this.ratingID = this.name;
    //this.lockedByCreator = true; //assign this value from user prefs setting
  }

  factory Trial.fromJson(Map<dynamic, dynamic> json) => _trialFromJson(json);

  Map<String, dynamic> toJson() => _trialToJson(this);

  static Map<TrialFields, String> friendlyFieldNames =
      <TrialFields, String>{
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
  };

  @override
  String toString() => "Trial<$name>";
}

Trial _trialFromJson(Map<dynamic, dynamic> json) {
  return Trial(
      createdTime: (json[TrialRepository.dbFieldNames[TrialFields.createdTime]]
              as Timestamp)
          .toDate(),
      creatorUserCareerID: json[TrialRepository.dbFieldNames[TrialFields.creatorUserCareerID]] as String,
      name: json[TrialRepository.dbFieldNames[TrialFields.name]] as String,
      description: json[TrialRepository.dbFieldNames[TrialFields.description]] as String,
      rules: json[TrialRepository.dbFieldNames[TrialFields.rules]] as String,
      winCondition: json[TrialRepository.dbFieldNames[TrialFields.winCondition]] as String,
      trialType: json[TrialRepository.dbFieldNames[TrialFields.trialType]] as String,
      tieBreaker: json[TrialRepository.dbFieldNames[TrialFields.tieBreaker]] as String,
      trialRunCount: json[TrialRepository.dbFieldNames[TrialFields.trialRunCount]] as int ?? 0,
      requirements: json[TrialRepository.dbFieldNames[TrialFields.requirements]] as String,
      gameCount: json[TrialRepository.dbFieldNames[TrialFields.gameCount]] as int ?? 0);
}

Map<String, dynamic> _trialToJson(Trial instance) => <String, dynamic>{
  TrialRepository.dbFieldNames[TrialFields.createdTime]: Timestamp.fromDate(instance.createdTime),
  TrialRepository.dbFieldNames[TrialFields.creatorUserCareerID]: instance.creatorUserCareerID,
  TrialRepository.dbFieldNames[TrialFields.name]: instance.name,
  TrialRepository.dbFieldNames[TrialFields.description]: instance.description,
  TrialRepository.dbFieldNames[TrialFields.rules]: instance.rules,
  TrialRepository.dbFieldNames[TrialFields.winCondition]: instance.winCondition,
  TrialRepository.dbFieldNames[TrialFields.tieBreaker]: instance.tieBreaker,
  TrialRepository.dbFieldNames[TrialFields.trialRunCount]: instance.trialRunCount,
  TrialRepository.dbFieldNames[TrialFields.trialType]: instance.trialType,
  TrialRepository.dbFieldNames[TrialFields.requirements]: instance.requirements,
  TrialRepository.dbFieldNames[TrialFields.gameCount]: instance.gameCount
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
}
