import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class GameRepository extends Repository {
  Future<void> addGame(Game game) async {
    await dbAPI.addDocument(FirestoreAPI.gamesCollection, game.toJson(), docID: game.name);
  }

  Future<void> removeGame(Game game) async {
    return await dbAPI.removeDocument(FirestoreAPI.gamesCollection, game.name);
  }

  Future<void> updateGame(Game game) async {
    await dbAPI.updateDocument(
        FirestoreAPI.gamesCollection, game.toJson(), game.name);
    return game;
  }

  Future<Game> getGame(String id) async {
    DocumentSnapshot gameSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.gamesCollection, id);
    return Game.fromJson(gameSnapshot.data);
  }

  Future<List<Game>> getGames() async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(
        SearchItem(collectionName: FirestoreAPI.gamesCollection));

    return querySnapshot.documents
        .map((documentSnapshot) => Game.fromJson(documentSnapshot.data))
        .toList();
  }

  static Map<GameFields, String> dbFieldNames = <GameFields, String>{
    GameFields.createdTime: 'CT',
    GameFields.creatorUserCareerID: 'Cr',
    GameFields.name: 'N',
    GameFields.description: 'D',
    GameFields.gameUserCount: 'GUCt',
    GameFields.ratingID: 'Rt',
    GameFields.trialIDs: 'Ts',
    GameFields.trialCount: 'TCt',
    GameFields.trialBossOption: 'TBO',
    GameFields.gameRunCount: 'GRCt',
  };
}