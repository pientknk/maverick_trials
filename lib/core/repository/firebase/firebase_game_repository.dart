import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class FirebaseGameRepository extends Repository<Game> {
  @override
  Future<Game> add(Game data) async {
    if (data?.id != null) {
      DocumentSnapshot gameSnapshot = await dbAPI.addDocument(
          FirestoreAPI.gamesCollection, data.toJson(),
          docID: data.id);
      return Game().fromSnapshot(gameSnapshot);
    } else {
      throw Exception("Error Adding a new Game");
    }
  }

  @override
  Future<bool> delete(Game data) {
    return dbAPI.removeDocument(FirestoreAPI.gamesCollection, data.id);
  }

  @override
  Future<Game> get(String id) async {
    DocumentSnapshot gameSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.gamesCollection, id);
    return Game().fromSnapshot(gameSnapshot);
  }

  @override
  Future<List<Game>> getList(
      {SearchItem searchItem = const SearchItem(
          collectionName: FirestoreAPI.gamesCollection)}) async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(searchItem);

    if (querySnapshot != null) {
      return querySnapshot.documents.map((documentSnapshot) {
        Game game = Game.fromJson(documentSnapshot.data);
        game.reference = documentSnapshot.reference;
        return game;
      }).toList();
    } else {
      return List.empty();
    }
  }

  @override
  Future<bool> update(Game data) {
    return dbAPI.updateDocument(data.toJson(),
        path: FirestoreAPI.gamesCollection,
        id: data.id,
        isIDUpdatable: true,
        reference: data.reference);
  }

  @override
  Stream<List<Game>> getStreamList(
      {SearchItem searchItem =
          const SearchItem(collectionName: FirestoreAPI.gamesCollection)}) {
    Stream<QuerySnapshot> querySnapshots =
        dbAPI.getStreamDataCollection(searchItem);

    if (querySnapshots != null) {
      return querySnapshots.map((querySnapshot) => querySnapshot.documents
          .map((documentSnapshot) => Game().fromSnapshot(documentSnapshot))
          .toList());
    } else {
      return Stream.empty();
    }
    //usage - await for(List<Game> games in getStreamList())
  }

  static Map<GameFields, String> dbFieldNames = Map.fromIterable(
    GameFields.values,
    key: (gameField) => gameField,
    value: (gameField) => _getDbFieldName(gameField),
  );

  static String _getDbFieldName(GameFields gameField){
    switch (gameField) {
      case GameFields.createdTime:
        return 'ct';
      case GameFields.creatorUserCareerID:
        return 'cr';
      case GameFields.name:
        return 'n';
      case GameFields.description:
        return 'd';
      case GameFields.gameUserCount:
        return 'guc';
      case GameFields.ratingID:
        return 'rt';
      case GameFields.trialIDs:
        return 'ts';
      case GameFields.trialCount:
        return 'tc';
      case GameFields.gameRunCount:
        return 'grc';
      case GameFields.trialBossOption:
        return 'tbo';
      case GameFields.minPlayerCount:
        return 'mn';
      case GameFields.maxPlayerCount:
        return 'mx';
      case GameFields.uID:
        return 'uid';
      default:
        locator<Logging>().log(LogType.pretty, LogLevel.error,
          'No GameField mapping found in dbFieldNames for $gameField');
        return null;
    }
  }
}
