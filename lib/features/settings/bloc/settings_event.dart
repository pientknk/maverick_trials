import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  SettingsEvent([List props = const[]]) : super(props);
}

class ResetSettingsEvent extends SettingsEvent {
  @override
  String toString() {
    return 'ResetSettingsEvent';
  }
}

class UpdateSettingsEvent extends SettingsEvent {
  //this should save locally
  @override
  String toString() {
    return 'UpdateSettingsEvent';
  }
}

class SaveSettingsEvent extends SettingsEvent {
  //this should save to cloud for backup of settings and to sync across devices
  @override
  String toString() {
    return 'SaveSettingsEvent';
  }
}