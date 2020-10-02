import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/settings.dart';

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

class SettingsUpdateState extends SettingsState {
  final SettingsFields settingsField;
  final bool value;

  SettingsUpdateState(this.settingsField, this.value) : super([settingsField, value]);

  @override
  String toString() {
    return 'SettingsUpdateState';
  }
}

class SettingsResetState extends SettingsState {
  @override
  String toString() {
    return 'SettingsResetState';
  }
}