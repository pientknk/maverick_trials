import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/base/data_model.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_settings_repository.dart';

class Settings with DataModel<Settings> {
  bool isDarkMode;
  String avatarLink; // if icons are stored in the app, this would be the link to images directory
  bool allowFriendsEditTrial;
  bool allowFriendsEditGame;

  Settings(){
    isDarkMode = true;
  }

  Settings._fromProperties({this.isDarkMode,
    this.avatarLink,
    this.allowFriendsEditGame,
    this.allowFriendsEditTrial});

  factory Settings.fromJson(Map<dynamic, dynamic> json) => _settingsFromJson(json);

  Map<String, dynamic> toJson() => _settingsToJson(this);

  static Map<SettingsFields, String> friendlyFieldNameBySettingsField =
    <SettingsFields, String>{
      SettingsFields.isDarkMode: 'Dark Mode',
      SettingsFields.avatarLink: 'Avatar',
      SettingsFields.allowFriendsEditTrial: 'Allow Friends to edit your Trials',
      SettingsFields.allowFriendsEditGame: 'Allow Friends to edit your Games',
    };

  @override
  String toString() {
    return 'Settings { IsDarkMode: $isDarkMode, AvatarLink: $avatarLink }';
  }

  @override
  Settings fromSnapshot(DocumentSnapshot snapshot) {
    if(snapshot != null){
      Settings settings = Settings.fromJson(snapshot.data);
      settings?.reference = snapshot.reference;
      return settings;
    }
    else{
      return null;
    }
  }

  @override
  bool operator ==(obj) {
    if(obj is Settings){
      return obj.reference.documentID == reference.documentID;
    }

    return false;
  }

  @override
  int get hashCode {
    return reference.documentID.hashCode;
  }

  @override
  String get id => reference.documentID;
}

Settings _settingsFromJson(Map<dynamic, dynamic> json){
  if(json != null){
    return Settings._fromProperties(
      isDarkMode: json[FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.isDarkMode]] as bool,
      avatarLink: json[FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.avatarLink]],
      allowFriendsEditTrial: json[FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditTrial]] as bool,
      allowFriendsEditGame: json[FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditGame]] as bool,
    );
  }
  else{
    return null;
  }
}

Map<String, dynamic> _settingsToJson(Settings instance) => <String, dynamic>{
  FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.isDarkMode] : instance.isDarkMode,
  FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.avatarLink] : instance.avatarLink,
  FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditTrial] : instance.allowFriendsEditTrial,
  FirebaseSettingsRepository.dbFieldNameBySettingsField[SettingsFields.allowFriendsEditGame] : instance.allowFriendsEditGame,
};

enum SettingsFields {
  isDarkMode,
  avatarLink,
  allowFriendsEditTrial,
  allowFriendsEditGame,
}