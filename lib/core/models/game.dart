import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/repository/game/firebase_game_repository.dart';

//FS
//Read only except for the creator
class Game {
  //A reference to a Firestore document representing this accolade
  DocumentReference reference; //reference.documentID == GameID
  String uID;
  DateTime createdTime;
  String creatorUserCareerID;// this should be user.nickname
  String name;
  String description;
  int gameUserCount;
  String ratingID;
  List<String> trialIDs;
  int trialCount;
  String trialBossOption;
  int minPlayerCount;
  int maxPlayerCount;
  int gameRunCount;

  Game.newGame();

  Game(
      {this.createdTime,
      this.creatorUserCareerID,
      this.name,
      this.description,
      this.gameUserCount,
      this.ratingID,
      this.trialIDs,
      this.trialCount,
      this.trialBossOption,
      this.gameRunCount,
      this.minPlayerCount,
      this.maxPlayerCount,
      this.uID});

  factory Game.fromJson(Map<dynamic, dynamic> json) => _gameFromJson(json);

  Map<String, dynamic> toJson() => _gameToJson(this);

  @override
  String toString() => "Game<$name>";
}

Game _gameFromJson(Map<dynamic, dynamic> json) {
  return Game(
    createdTime:
        (json[FirebaseGameRepository.dbFieldNames[GameFields.createdTime]] as Timestamp)
            .toDate(),
    creatorUserCareerID:
        json[FirebaseGameRepository.dbFieldNames[GameFields.creatorUserCareerID]]
            as String,
    name: json[FirebaseGameRepository.dbFieldNames[GameFields.name]] as String,
    description:
        json[FirebaseGameRepository.dbFieldNames[GameFields.description]] as String,
    gameUserCount:
        json[FirebaseGameRepository.dbFieldNames[GameFields.gameUserCount]] as int,
    ratingID: json[FirebaseGameRepository.dbFieldNames[GameFields.ratingID]] as String,
    trialIDs: List.from(
        json[FirebaseGameRepository.dbFieldNames[GameFields.trialIDs]] ?? List()),
    trialCount: json[FirebaseGameRepository.dbFieldNames[GameFields.trialCount]] as int,
    trialBossOption:
        json[FirebaseGameRepository.dbFieldNames[GameFields.trialBossOption]] as String,
    gameRunCount:
        json[FirebaseGameRepository.dbFieldNames[GameFields.gameRunCount]] as int,
    minPlayerCount: json[FirebaseGameRepository.dbFieldNames[GameFields.minPlayerCount]] as int,
    maxPlayerCount: json[FirebaseGameRepository.dbFieldNames[GameFields.maxPlayerCount]] as int,
    uID: json[FirebaseGameRepository.dbFieldNames[GameFields.uID]] as String,
  );
}

Map<String, dynamic> _gameToJson(Game instance) => <String, dynamic>{
      FirebaseGameRepository.dbFieldNames[GameFields.createdTime]:
          Timestamp.fromDate(instance.createdTime),
      FirebaseGameRepository.dbFieldNames[GameFields.creatorUserCareerID]:
          instance.creatorUserCareerID,
      FirebaseGameRepository.dbFieldNames[GameFields.name]: instance.name,
      FirebaseGameRepository.dbFieldNames[GameFields.description]: instance.description,
      FirebaseGameRepository.dbFieldNames[GameFields.gameUserCount]:
          instance.gameUserCount,
      FirebaseGameRepository.dbFieldNames[GameFields.ratingID]: instance.ratingID,
      FirebaseGameRepository.dbFieldNames[GameFields.trialIDs]: instance.trialIDs,
      FirebaseGameRepository.dbFieldNames[GameFields.trialCount]: instance.trialCount,
      FirebaseGameRepository.dbFieldNames[GameFields.trialBossOption]:
          instance.trialBossOption,
      FirebaseGameRepository.dbFieldNames[GameFields.gameRunCount]:
          instance.gameRunCount,
      FirebaseGameRepository.dbFieldNames[GameFields.minPlayerCount]: instance.minPlayerCount,
      FirebaseGameRepository.dbFieldNames[GameFields.maxPlayerCount]: instance.maxPlayerCount,
      FirebaseGameRepository.dbFieldNames[GameFields.uID]: instance.uID,
    };

Map<GameFields, String> friendlyFieldNames = <GameFields, String>{
  GameFields.createdTime: 'Created Time',
  GameFields.creatorUserCareerID: 'Creator',
  GameFields.name: 'Name',
  GameFields.gameUserCount: 'Players',
  GameFields.ratingID: 'Rating',
  GameFields.trialIDs: 'Trial List',
  GameFields.trialCount: 'Trials',
  GameFields.gameRunCount: 'Games Played',
  GameFields.trialBossOption: 'Trial Boss Option',
  GameFields.uID: 'Creator ID',
};

enum GameFields {
  createdTime,
  creatorUserCareerID,
  name,
  description,
  gameUserCount,
  ratingID,
  trialIDs,
  trialCount,
  gameRunCount,
  trialBossOption,
  minPlayerCount,
  maxPlayerCount,
  uID,
}