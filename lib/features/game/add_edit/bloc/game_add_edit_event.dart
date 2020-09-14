import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/game.dart';

abstract class GameAddEditEvent extends Equatable {
  GameAddEditEvent([List props = const[]]) : super(props);
}

class AddGameEvent extends GameAddEditEvent {
  final Game game;

  AddGameEvent({this.game}) : super([game]);

  @override
  String toString() {
    return 'AddGameEvent<${game?.name}>';
  }
}

class EditGameEvent extends GameAddEditEvent {
  final Game game;

  EditGameEvent({this.game}) : super([game]);

  @override
  String toString() {
    return 'EditGameEvent<${game?.name}>';
  }
}