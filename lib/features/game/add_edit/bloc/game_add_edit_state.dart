import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/game.dart';

abstract class GameAddEditState extends Equatable {
  GameAddEditState([List props = const[]]) : super(props);
}

class GameAddEditDefaultState extends GameAddEditState {
  @override
  String toString() {
    return 'GameAddEditDefaultState<GameAddEditState>';
  }
}

class GameAddEditLoadingState extends GameAddEditState {
  @override
  String toString() {
    return 'GameAddEditLoadingState<GameAddEditState>';
  }
}

class GameAddEditSavingState extends GameAddEditState {
  @override
  String toString() {
    return 'GameAddEditSavingState<GameAddEditState>';
  }
}

class GameAddEditSuccessState extends GameAddEditState {
  final Game game;

  GameAddEditSuccessState({this.game}) : super([game]);

  @override
  String toString() {
    return 'GameAddEditSuccessState<GameAddEditState>';
  }
}

class GameAddEditFailureState extends GameAddEditState {
  final String error;

  GameAddEditFailureState({this.error}) : super([error]);

  @override
  String toString() {
    return 'GameAddEditFailureState<GameAddEditState>';
  }
}
