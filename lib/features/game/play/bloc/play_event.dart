import 'package:equatable/equatable.dart';

abstract class PlayEvent extends Equatable {
  PlayEvent([List props = const[]]) : super(props);
}

class PlayEventFindGame extends PlayEvent {
  @override
  String toString() {
    return 'PlayEventFindGame';
  }
}

class PlayEventMyGames extends PlayEvent {
  @override
  String toString() {
    return 'PlayEventMyGames';
  }
}

class PlayEventPlayingGame extends PlayEvent {
  final String gameID;

  PlayEventPlayingGame(this.gameID) : super([gameID]);

  @override
  String toString() {
    return 'PlayEventPlayingGame<$gameID>';
  }
}

class PlayEventNoGame extends PlayEvent {
  @override
  String toString() {
    return 'PlayEventNoGame';
  }
}