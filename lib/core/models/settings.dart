import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/repository/settings_repository.dart';

class Settings {
  DocumentReference reference; //use user.nickname for id
  String userID; //this should be the user.UID since this is not front facing data
  bool isDarkMode;
  bool allowFriendsEditTrial;
  bool allowFriendsEditGame;

  Settings.newSettings();

  Settings({this.userID, this.isDarkMode, this.allowFriendsEditGame, this.allowFriendsEditTrial});

  factory Settings.fromJson(Map<dynamic, dynamic> json) => _settingsFromJson(json);

  Map<String, dynamic> toJson() => _settingsToJson(this);

  static Map<SettingsFields, String> friendlyFieldNameBySettingsField =
    <SettingsFields, String>{
    SettingsFields.userID: 'User',
      SettingsFields.isDarkMode: 'Dark Mode',
      SettingsFields.allowFriendsEditTrial: 'Allow Friends to edit your Trials',
      SettingsFields.allowFriendsEditGame: 'Allow Friends to edit your Games',
    };
}

Settings _settingsFromJson(Map<dynamic, dynamic> json){
  return Settings(
    userID: json[SettingsRepository.dbFieldNameBySettingsField[SettingsFields.userID]] as String,
    isDarkMode: json[SettingsRepository.dbFieldNameBySettingsField[SettingsFields.isDarkMode]] as bool,
    allowFriendsEditTrial: json[SettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditTrial]] as bool,
    allowFriendsEditGame: json[SettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditGame]] as bool,
  );
}

Map<String, dynamic> _settingsToJson(Settings instance) => <String, dynamic>{
  SettingsRepository.dbFieldNameBySettingsField[SettingsFields.userID] : instance.userID,
  SettingsRepository.dbFieldNameBySettingsField[SettingsFields.isDarkMode] : instance.isDarkMode,
  SettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditTrial] : instance.allowFriendsEditTrial,
  SettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditGame] : instance.allowFriendsEditGame,
};

enum SettingsFields {
  userID,
  isDarkMode,
  allowFriendsEditTrial,
  allowFriendsEditGame,
}