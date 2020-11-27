import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/settings.dart';

abstract class SettingsEvent extends Equatable {
  SettingsEvent([List props = const[]]) : super(props);
}

class SettingsEventInitialize extends SettingsEvent {
  @override
  String toString() {
    return 'SettingsEventInitialize';
  }
}

class InitializeSettingsEvent extends SettingsEvent {
  @override
  String toString() {
    return 'InitializeSettingsEvent';
  }
}

class SettingsEventSave extends SettingsEvent {
  @override
  String toString() {
    return 'SettingsEventSave';
  }
}

//TODO: use SharedObjects.prefs.setBool to save and read locally - and use Firebase to upload settings
class UpdateSettingsEvent extends SettingsEvent {
  final SettingsFields settingsField;
  final bool value;

  UpdateSettingsEvent(this.settingsField, this.value) : super([settingsField, value]);


  //this should save locally
  @override
  String toString() {
    return 'UpdateSettingsEvent';
  }
}

class UpdateAvatarSettingsEvent extends SettingsEvent {
  final String avatarLink;

  UpdateAvatarSettingsEvent(this.avatarLink) : super([avatarLink]);

  @override
  String toString() {
    return 'UpdateAvatarSettingsEvent';
  }
}