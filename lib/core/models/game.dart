import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/base/data_model.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_game_repository.dart';

class Game with DataModel<Game> {
  String uID;
  DateTime createdTime;
  String creatorUserCareerID; // this should be user.nickname
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

  Game();

  factory Game.newGame() {
    return Game()
      ..createdTime = DateTime.now()
      ..trialCount = 0
      ..gameRunCount = 0
      ..trialIDs = List<String>();
  }

  Game._withProperties(
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

  @override
  Game fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      Game game = Game.fromJson(snapshot.data);
      game?.reference = snapshot.reference;
      return game;
    } else {
      return null;
    }
  }

  @override
  bool operator ==(obj) {
    if (obj is Game) {
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

Game _gameFromJson(Map<dynamic, dynamic> json) {
  if (json != null) {
    return Game._withProperties(
      createdTime:
          (json[FirebaseGameRepository.dbFieldNames[GameFields.createdTime]]
                  as Timestamp)
              .toDate(),
      creatorUserCareerID: json[FirebaseGameRepository
          .dbFieldNames[GameFields.creatorUserCareerID]] as String,
      name:
          json[FirebaseGameRepository.dbFieldNames[GameFields.name]] as String,
      description:
          json[FirebaseGameRepository.dbFieldNames[GameFields.description]]
              as String,
      gameUserCount:
          json[FirebaseGameRepository.dbFieldNames[GameFields.gameUserCount]]
              as int,
      ratingID: json[FirebaseGameRepository.dbFieldNames[GameFields.ratingID]]
          as String,
      trialIDs: List.from(
          json[FirebaseGameRepository.dbFieldNames[GameFields.trialIDs]] ??
              List()),
      trialCount:
          json[FirebaseGameRepository.dbFieldNames[GameFields.trialCount]]
              as int,
      trialBossOption:
          json[FirebaseGameRepository.dbFieldNames[GameFields.trialBossOption]]
              as String,
      gameRunCount:
          json[FirebaseGameRepository.dbFieldNames[GameFields.gameRunCount]]
              as int,
      minPlayerCount:
          json[FirebaseGameRepository.dbFieldNames[GameFields.minPlayerCount]]
              as int,
      maxPlayerCount:
          json[FirebaseGameRepository.dbFieldNames[GameFields.maxPlayerCount]]
              as int,
      uID: json[FirebaseGameRepository.dbFieldNames[GameFields.uID]] as String,
    );
  } else {
    return null;
  }
}

Map<String, dynamic> _gameToJson(Game instance) => <String, dynamic>{
      FirebaseGameRepository.dbFieldNames[GameFields.createdTime]:
          Timestamp.fromDate(instance.createdTime),
      FirebaseGameRepository.dbFieldNames[GameFields.creatorUserCareerID]:
          instance.creatorUserCareerID,
      FirebaseGameRepository.dbFieldNames[GameFields.name]: instance.name,
      FirebaseGameRepository.dbFieldNames[GameFields.description]:
          instance.description,
      FirebaseGameRepository.dbFieldNames[GameFields.gameUserCount]:
          instance.gameUserCount,
      FirebaseGameRepository.dbFieldNames[GameFields.ratingID]:
          instance.ratingID,
      FirebaseGameRepository.dbFieldNames[GameFields.trialIDs]:
          instance.trialIDs,
      FirebaseGameRepository.dbFieldNames[GameFields.trialCount]:
          instance.trialCount,
      FirebaseGameRepository.dbFieldNames[GameFields.trialBossOption]:
          instance.trialBossOption,
      FirebaseGameRepository.dbFieldNames[GameFields.gameRunCount]:
          instance.gameRunCount,
      FirebaseGameRepository.dbFieldNames[GameFields.minPlayerCount]:
          instance.minPlayerCount,
      FirebaseGameRepository.dbFieldNames[GameFields.maxPlayerCount]:
          instance.maxPlayerCount,
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
