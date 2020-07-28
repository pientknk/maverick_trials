import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

//FS
//Read only except for the creator
class Game {
  //A reference to a Firestore document representing this accolade
  DocumentReference reference; //reference.documentID == GameID
  DateTime createdTime;
  String creatorUserCareerID;
  String name;
  int gameUserCount;
  String ratingID;
  List<String> trialIDs;
  int trialCount;
  String trialBossOption;
  int gameRunCount;

  Game(this.createdTime, this.creatorUserCareerID, this.name,
      this.trialBossOption,
      {this.gameUserCount,
      this.ratingID,
      this.trialIDs,
      this.trialCount,
      this.gameRunCount});

  factory Game.fromJson(Map<dynamic, dynamic> json) => _gameFromJson(json);

  Map<String, dynamic> toJson() => _gameToJson(this);

  @override
  String toString() => "Game<$name>";
}

Game _gameFromJson(Map<dynamic, dynamic> json) {
  return Game(
    (json['CT'] as Timestamp).toDate(),
    json['Cr'] as String,
    json['N'] as String,
    json['TBO'] as String,
    gameUserCount: json['GUCt'] as int,
    ratingID: json['Rt'] as String,
    trialIDs: List.from(json['Ts'] ?? List()),
    trialCount: json['TCt'] as int,
    gameRunCount: json['GRCt'] as int,
  );
}

Map<String, dynamic> _gameToJson(Game instance) => <String, dynamic>{
      'CT': Timestamp.fromDate(instance.createdTime),
      'Cr': instance.creatorUserCareerID,
      'N': instance.name,
      'TBO': instance.trialBossOption,
      'GUCt': instance.gameUserCount,
      'Rt': instance.ratingID,
      'Ts': instance.trialIDs,
    };
