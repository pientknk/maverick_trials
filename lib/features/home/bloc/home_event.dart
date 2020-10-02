import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/app_tabs.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const[]]) : super(props);
}

class HomeEventTabSelected extends HomeEvent {
  final AppTabs appTab;

  HomeEventTabSelected({this.appTab}) : super([appTab]);

  @override
  String toString() {
    return 'HomeEventTabSelected<$appTab>';
  }
}