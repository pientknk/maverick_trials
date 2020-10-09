import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class FirebaseGameRepository extends Repository<Game> {
  @override
  Future<Game> add(Game data) async {
    DocumentSnapshot gameSnapshot = await dbAPI.addDocument(
      FirestoreAPI.gamesCollection, data.toJson(),
      docID: data.id);
    return Game().fromSnapshot(gameSnapshot);
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
    {SearchItem searchItem = const SearchItem(collectionName: FirestoreAPI.gamesCollection)}) async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(searchItem);

    if(querySnapshot != null){
      return querySnapshot.documents
        .map((documentSnapshot){
        Game game = Game.fromJson(documentSnapshot.data);
        game.reference = documentSnapshot.reference;
        return game;
      })
        .toList();
    }
    else{
      return List.empty();
    }
  }

  @override
  Future<bool> update(Game data) {
    return dbAPI.updateDocument(data.toJson(),
      path: FirestoreAPI.gamesCollection,
      id: data.id,
      isIDUpdatable: true,
      reference: data.reference
    );
  }

  @override
  Stream<List<Game>> getStreamList({
    SearchItem searchItem = const SearchItem(collectionName: FirestoreAPI.gamesCollection)
  }) {
    Stream<QuerySnapshot> querySnapshots = dbAPI.getStreamDataCollection(searchItem);

    if(querySnapshots != null){
      return querySnapshots.map((querySnapshot) => querySnapshot.documents
        .map((documentSnapshot) => Game().fromSnapshot(documentSnapshot))
        .toList()
      );
    }
    else{
      return Stream.empty();
    }
    //usage - await for(List<Game> games in getStreamList())
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