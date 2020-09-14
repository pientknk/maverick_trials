import 'package:equatable/equatable.dart';

abstract class GameListEvent extends Equatable {
  GameListEvent([List props = const[]]) : super(props);
}

class SearchTextChangedEvent extends GameListEvent {
  final String searchText;

  SearchTextChangedEvent(this.searchText) : super([searchText]);

  @override
  String toString() {
    return 'SearchTextChangedEvent<$searchText>';
  }
}

class SearchTextClearedEvent extends GameListEvent {
  @override
  String toString() {
    return 'SearchTextClearedEvent<GameListEvent>';
  }
}