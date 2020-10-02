import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/repository/settings/firebase_settings_repository.dart';

class Settings {
  DocumentReference reference; //use user.uuid
  bool isDarkMode;
  String avatarLink; // if icons are stored in the app, this would be the link to images directory
  bool allowFriendsEditTrial;
  bool allowFriendsEditGame;

  Settings.newSettings();

  Settings({this.isDarkMode, this.allowFriendsEditGame, this.allowFriendsEditTrial});

  factory Settings.fromJson(Map<dynamic, dynamic> json) => _settingsFromJson(json);

  Map<String, dynamic> toJson() => _settingsToJson(this);

  static Map<SettingsFields, String> friendlyFieldNameBySettingsField =
    <SettingsFields, String>{
      SettingsFields.isDarkMode: 'Dark Mode',
      SettingsFields.allowFriendsEditTrial: 'Allow Friends to edit your Trials',
      SettingsFields.allowFriendsEditGame: 'Allow Friends to edit your Games',
    };
}

Settings _settingsFromJson(Map<dynamic, dynamic> json){
  return Settings(
    isDarkMode: json[FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.isDarkMode]] as bool,
    allowFriendsEditTrial: json[FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditTrial]] as bool,
    allowFriendsEditGame: json[FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditGame]] as bool,
  );
}

Map<String, dynamic> _settingsToJson(Settings instance) => <String, dynamic>{
  FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.isDarkMode] : instance.isDarkMode,
  FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditTrial] : instance.allowFriendsEditTrial,
  FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditGame] : instance.allowFriendsEditGame,
};

enum SettingsFields {
  isDarkMode,
  allowFriendsEditTrial,
  allowFriendsEditGame,
}