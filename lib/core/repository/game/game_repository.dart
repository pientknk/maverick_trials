import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'dart:async';

abstract class GameRepository {
  Future<void> addGame(Game game);

  Future<void> getGame(String id);

  Future<void> deleteGame(Game game);

  Future<List<Game>> getGames({SearchItem searchItem});

  Future<void> updateGame(Game game);
}