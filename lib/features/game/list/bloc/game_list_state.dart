import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/game.dart';

abstract class GameListState extends Equatable {
  GameListState([List props = const[]]) : super(props);
}

class LoadingState extends GameListState {
  @override
  String toString() {
    return 'LoadingState<GameListState>';
  }
}

class DefaultState extends GameListState {
  @override
  String toString() {
    return 'DefaultState<GameListState>';
  }
}

class SearchEmptyState extends GameListState {
  final List<Game> games;

  SearchEmptyState(this.games) : super([games]);

  @override
  String toString() {
    return 'SearchEmptyState<GameListState>';
  }
}

class SearchSuccessState extends GameListState {
  final List<Game> games;

  SearchSuccessState(this.games) : super([games]);

  @override
  String toString() {
    return 'SearchSuccessState<${games.length} Records>';
  }
}

class SearchErrorState extends GameListState {
  final String error;

  SearchErrorState(this.error) : super([error]);

  @override
  String toString() {
    return 'SearchErrorState<$error>';
  }
}