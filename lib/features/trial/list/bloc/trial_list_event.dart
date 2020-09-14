import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/filter_item.dart';
import 'package:maverick_trials/core/models/sort_item.dart';
import 'package:maverick_trials/core/models/trial.dart';

abstract class TrialListEvent extends Equatable {
  TrialListEvent([List props = const[]]) : super(props);
}

class SearchTextChangedEvent extends TrialListEvent {
  final String searchText;

  SearchTextChangedEvent(this.searchText) : super([searchText]);

  @override
  String toString() {
    return 'SearchTextChangedEvent<$searchText>';
  }
}

class SearchTextClearedEvent extends TrialListEvent {
  @override
  String toString() {
    return 'SearchTextClearedEvent<TrialListEvent>';
  }
}

class TrialClickedEvent extends TrialListEvent {
  final Trial trial;

  TrialClickedEvent(this.trial) : super([trial]);

  @override
  String toString() {
    return 'TrialClickedEvent<$trial>';
  }
}

class FilterAddedEvent extends TrialListEvent {
  final FilterItem filterItem;

  FilterAddedEvent(this.filterItem) : super([filterItem]);

  @override
  String toString() {
    return 'FilterAddedEvent<$filterItem>';
  }
}

class FilterRemovedEvent extends TrialListEvent {
  final FilterItem filterItem;

  FilterRemovedEvent(this.filterItem) : super([filterItem]);

  @override
  String toString() {
    return 'FilterRemovedEvent<$filterItem>';
  }
}

class SortAddedEvent extends TrialListEvent {
  final SortItem sortItem;

  SortAddedEvent(this.sortItem) : super([sortItem]);

  @override
  String toString() {
    return 'SortAddedEvent<$sortItem>';
  }
}

class SortRemovedEvent extends TrialListEvent {
  final SortItem sortItem;

  SortRemovedEvent(this.sortItem) : super([sortItem]);

  @override
  String toString() {
    return 'SortRemovedEvent<$sortItem>';
  }
}