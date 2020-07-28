import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/trial.dart';

abstract class TrialAddEditEvent extends Equatable {
  TrialAddEditEvent([List props = const []]) : super(props);
}

class AddTrialEvent extends TrialAddEditEvent {
  final Trial trial;

  AddTrialEvent({this.trial}) : super([trial]);

  @override
  String toString() {
    return 'AddTrialEvent<${trial?.name}>';
  }
}

class EditTrialEvent extends TrialAddEditEvent {
  final Trial trial;

  EditTrialEvent({this.trial}) : super([trial]);

  @override
  String toString() {
    return 'EditTrialEvent<${trial?.name}>';
  }
}
