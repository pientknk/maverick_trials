import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/repository/game_repository.dart';

//FS
//Read only except for the creator
class Game {
  //A reference to a Firestore document representing this accolade
  DocumentReference reference; //reference.documentID == GameID
  DateTime createdTime;
  String creatorUserCareerID;
  String name;
  String description;
  int gameUserCount;
  String ratingID;
  List<String> trialIDs;
  int trialCount;
  String trialBossOption;
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
      this.gameRunCount});

  factory Game.fromJson(Map<dynamic, dynamic> json) => _gameFromJson(json);

  Map<String, dynamic> toJson() => _gameToJson(this);

  @override
  String toString() => "Game<$name>";
}

Game _gameFromJson(Map<dynamic, dynamic> json) {
  return Game(
    createdTime:
        (json[GameRepository.dbFieldNames[GameFields.createdTime]] as Timestamp)
            .toDate(),
    creatorUserCareerID:
        json[GameRepository.dbFieldNames[GameFields.creatorUserCareerID]]
            as String,
    name: json[GameRepository.dbFieldNames[GameFields.name]] as String,
    description:
        json[GameRepository.dbFieldNames[GameFields.description]] as String,
    gameUserCount:
        json[GameRepository.dbFieldNames[GameFields.gameUserCount]] as int,
    ratingID: json[GameRepository.dbFieldNames[GameFields.ratingID]] as String,
    trialIDs: List.from(
        json[GameRepository.dbFieldNames[GameFields.trialIDs]] ?? List()),
    trialCount: json[GameRepository.dbFieldNames[GameFields.trialCount]] as int,
    trialBossOption:
        json[GameRepository.dbFieldNames[GameFields.trialBossOption]] as String,
    gameRunCount:
        json[GameRepository.dbFieldNames[GameFields.gameRunCount]] as int,
  );
}

Map<String, dynamic> _gameToJson(Game instance) => <String, dynamic>{
      GameRepository.dbFieldNames[GameFields.createdTime]:
          Timestamp.fromDate(instance.createdTime),
      GameRepository.dbFieldNames[GameFields.creatorUserCareerID]:
          instance.creatorUserCareerID,
      GameRepository.dbFieldNames[GameFields.name]: instance.name,
      GameRepository.dbFieldNames[GameFields.description]: instance.description,
      GameRepository.dbFieldNames[GameFields.gameUserCount]:
          instance.gameUserCount,
      GameRepository.dbFieldNames[GameFields.ratingID]: instance.ratingID,
      GameRepository.dbFieldNames[GameFields.trialIDs]: instance.trialIDs,
      GameRepository.dbFieldNames[GameFields.trialCount]: instance.trialCount,
      GameRepository.dbFieldNames[GameFields.trialBossOption]:
          instance.trialBossOption,
      GameRepository.dbFieldNames[GameFields.gameRunCount]:
          instance.gameRunCount,
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
}