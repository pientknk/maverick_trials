import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'package:maverick_trials/core/repository/game/game_repository.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class FirebaseGameRepository extends Repository implements GameRepository  {
  @override
  Future<void> addGame(Game game) async {
    await dbAPI.addDocument(FirestoreAPI.gamesCollection, game.toJson(), docID: game.name);
  }

  @override
  Future<void> deleteGame(Game game) async {
    return await dbAPI.removeDocument(FirestoreAPI.gamesCollection, game.name);
  }

  @override
  Future<void> updateGame(Game game) async {
    await dbAPI.updateDocument(
        FirestoreAPI.gamesCollection, game.toJson(), game.name);
    return game;
  }

  @override
  Future<Game> getGame(String id) async {
    DocumentSnapshot gameSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.gamesCollection, id);
    return Game.fromJson(gameSnapshot.data);
  }

  @override
  Future<List<Game>> getGames({
    SearchItem searchItem = const SearchItem(collectionName: FirestoreAPI.gamesCollection)
  }) async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(
        SearchItem(collectionName: FirestoreAPI.gamesCollection));

    return querySnapshot.documents
        .map((documentSnapshot) => Game.fromJson(documentSnapshot.data))
        .toList();
  }

  static Map<GameFields, String> dbFieldNames = <GameFields, String>{
    GameFields.createdTime: 'ct',
    GameFields.creatorUserCareerID: 'cr',
    GameFields.name: 'n',
    GameFields.description: 'd',
    GameFields.gameUserCount: 'guc',
    GameFields.ratingID: 'rt',
    GameFields.trialIDs: 'ts',
    GameFields.trialCount: 'tc',
    GameFields.trialBossOption: 'tbo',
    GameFields.gameRunCount: 'grc',
    GameFields.minPlayerCount: 'mn',
    GameFields.maxPlayerCount: 'mx',
    GameFields.uID: 'uid'
  };
}