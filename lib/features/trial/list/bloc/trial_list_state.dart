import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/filter_item.dart';
import 'package:maverick_trials/core/models/sort_item.dart';
import 'package:maverick_trials/core/models/trial.dart';

abstract class TrialListState extends Equatable {
  TrialListState([List props = const[]]) : super(props);
}

class LoadingState extends TrialListState {
  @override
  String toString() {
    return 'LoadingState<TrialListState>';
  }
}

class DefaultState extends TrialListState {
  @override
  String toString() {
    return 'DefaultState<TrialListState>';
  }
}

class SearchEmptyState extends TrialListState {
  final List<Trial> trials;

  SearchEmptyState(this.trials) : super([trials]);

  @override
  String toString() {
    return 'SearchEmptyState<TrialListState>';
  }
}

class SearchSuccessState extends TrialListState {
  final List<Trial> trials;

  SearchSuccessState(this.trials) : super([trials]);

  @override
  String toString() {
    return 'SearchSuccessState<${trials.length} Records>';
  }
}

class SearchErrorState extends TrialListState {
  final String error;

  SearchErrorState(this.error) : super([error]);

  @override
  String toString() {
    return 'SearchErrorState<$error>';
  }
}

class FilterSuccessState extends TrialListState {
  final List<Trial> trials;
  final List<FilterItem> filterItems;
  final List<SortItem> sortItems;

  FilterSuccessState(this.trials, this.filterItems, this.sortItems)
    : super([trials, filterItems, sortItems]);

  @override
  String toString() {
    return 'FilterSuccessState<${trials.length} items>';
  }
}

class FilterErrorState extends TrialListState {
  final String error;

  FilterErrorState(this.error) : super([error]);

  @override
  String toString() {
    return 'FilterErrorState<$error>';
  }
}

class SortSuccessState extends TrialListState {
  final List<Trial> trials;
  final List<FilterItem> filterItems;
  final List<SortItem> sortItems;

  SortSuccessState(this.trials, this.filterItems, this.sortItems)
    : super([trials, filterItems, sortItems]);

  @override
  String toString() {
    return 'SortSuccessState<${trials.length} items>';
  }
}

class SortErrorState extends TrialListState {
  final String error;

  SortErrorState(this.error) : super([error]);

  @override
  String toString() {
    return 'SortErrorState<$error>';
  }
}