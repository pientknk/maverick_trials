import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/base/data_model.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_settings_repository.dart';

class Settings with DataModel<Settings> {
  String docID; //used as an initial document id for firestore
  bool isDarkMode;
  bool allowFriendsEditTrial;
  bool allowFriendsEditGame;

  Settings(){
    isDarkMode = true;
  }

  Settings._fromProperties({this.isDarkMode,
    this.allowFriendsEditGame,
    this.allowFriendsEditTrial});

  factory Settings.fromJson(Map<dynamic, dynamic> json) => _settingsFromJson(json);

  Map<String, dynamic> toJson() => _settingsToJson(this);

  static Map<SettingsFields, String> friendlyFieldNameBySettingsField =
    <SettingsFields, String>{
      SettingsFields.isDarkMode: 'Dark Mode',
      SettingsFields.allowFriendsEditTrial: 'Allow Friends to edit your Trials',
      SettingsFields.allowFriendsEditGame: 'Allow Friends to edit your Games',
    };

  @override
  String toString() {
    return 'Settings { DocID: $docID, IsDarkMode: $isDarkMode }';
  }

  @override
  Settings fromSnapshot(DocumentSnapshot snapshot) {
    if(snapshot != null){
      Settings settings = Settings.fromJson(snapshot.data);
      if(settings == null){
        return Settings();
      }

      settings.reference = snapshot.reference;
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
  String get id => reference?.documentID ?? docID;
}

Settings _settingsFromJson(Map<dynamic, dynamic> json){
  if(json != null){
    return Settings._fromProperties(
      isDarkMode: json[FirebaseSettingsRepository.dbFieldNames[SettingsFields.isDarkMode]] as bool,
      allowFriendsEditTrial: json[FirebaseSettingsRepository.dbFieldNames[SettingsFields.allowFriendsEditTrial]] as bool,
      allowFriendsEditGame: json[FirebaseSettingsRepository.dbFieldNames[SettingsFields.allowFriendsEditGame]] as bool,
    );
  }
  else{
    return null;
  }
}

Map<String, dynamic> _settingsToJson(Settings instance) => <String, dynamic>{
  FirebaseSettingsRepository.dbFieldNames[SettingsFields.isDarkMode] : instance.isDarkMode,
  FirebaseSettingsRepository.dbFieldNames[SettingsFields.allowFriendsEditTrial] : instance.allowFriendsEditTrial,
  FirebaseSettingsRepository.dbFieldNames[SettingsFields.allowFriendsEditGame] : instance.allowFriendsEditGame,
};

enum SettingsFields {
  isDarkMode,
  allowFriendsEditTrial,
  allowFriendsEditGame,
}