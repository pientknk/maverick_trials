import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/game.dart';

abstract class PlayState extends Equatable {
  PlayState([List props = const[]]) : super(props);
}

class PlayStateNotPlaying extends PlayState {
  @override
  String toString() {
    return 'PlayStateNotPlaying';
  }
}

class PlayStateIsPlaying extends PlayState {
  final Game game;

  PlayStateIsPlaying(this.game) : super([game]);

  @override
  String toString() {
    return 'PlayStateIsPlaying';
  }
}

class PlayStateInitial extends PlayState {
  @override
  String toString() {
    return 'PlayStateInitial';
  }
}

class PlayStateLoading extends PlayState {
  @override
  String toString() {
    return 'PlayStateLoading';
  }
}

class PlayStateError extends PlayState {
  final String error;

  PlayStateError(this.error) : super([error]);

  @override
  String toString() {
    return 'PlayStateError<$error>';
  }
}