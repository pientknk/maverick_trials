import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  SettingsState([List props = const[]]) : super(props);
}

class SettingsLoadingState extends SettingsState {
  @override
  String toString() {
    return 'SettingsLoadingState';
  }
}

class SettingsSavingState extends SettingsState {
  //pass in settings object here

  @override
  String toString() {
    return 'SettingsSavingState';
  }
}

class SettingsResetState extends SettingsState {
  @override
  String toString() {
    return 'SettingsResetState';
  }
}