import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class FirebaseSettingsRepository extends Repository {
  Future<void> addSettings(Settings settings) async {
    await dbAPI.addDocument(FirestoreAPI.settingsCollection, settings.toJson(), docID: await authAPI.currentUserUid());
  }

  Future<void> removeSettings(Settings settings) async {
    await dbAPI.removeDocument(FirestoreAPI.settingsCollection, await authAPI.currentUserUid());
  }

  Future<void> updateSettings(Settings settings) async {
    await dbAPI.updateDocument(FirestoreAPI.settingsCollection, settings.toJson(), await authAPI.currentUserUid());
  }

  Future<Settings> getSettings({@required String id}) async {
    DocumentSnapshot settingsSnapshot = await dbAPI.getDocumentById(FirestoreAPI.settingsCollection, id);
    return Settings.fromJson(settingsSnapshot.data);
  }

  Future<void> addNewUserSettings() async {
    Settings settings = Settings(isDarkMode: true);
    await addSettings(settings);
  }

  static Map<SettingsFields, String> dbFieldNameBySettingsField =
    <SettingsFields, String>{
      SettingsFields.allowFriendsEditTrial: 'aet',
      SettingsFields.allowFriendsEditGame: 'aet',
      SettingsFields.isDarkMode: 'dm',
    };
}