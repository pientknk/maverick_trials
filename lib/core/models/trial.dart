import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

//FS
//Read only except for the creator
class Trial {
  //A reference to a Firestore document representing this trial
  DocumentReference reference; //reference.documentID == TrialID
  DateTime createdTime;
  String creatorUserCareerID;
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

  @override
  String toString() => "Trial<$name>";
}

Trial _trialFromJson(Map<dynamic, dynamic> json) {
  return Trial(
      createdTime: (json['CT'] as Timestamp).toDate(),
      creatorUserCareerID: json['Cr'] as String,
      name: json['N'] as String,
      description: json['D'] as String,
      rules: json['Rls'] as String,
      winCondition: json['WC'] as String,
      trialType: json['TT'] as String,
      tieBreaker: json["TBrk"] as String,
      trialRunCount: json['TRCt'] as int ?? 0,
      requirements: json['Rqs'] as String,
      gameCount: json['GCt'] as int ?? 0);
}

Map<String, dynamic> _trialToJson(Trial instance) => <String, dynamic>{
      'CT': Timestamp.fromDate(instance.createdTime),
      'Cr': instance.creatorUserCareerID,
      'N': instance.name,
      'D': instance.description,
      'Rls': instance.rules,
      'WC': instance.winCondition,
      'TBrk': instance.tieBreaker,
      'TRCt': instance.trialRunCount,
      'TT': instance.trialType,
      'Rqs': instance.requirements,
      'GCt': instance.gameCount
    };
