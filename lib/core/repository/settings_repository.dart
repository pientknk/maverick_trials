import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class SettingsRepository extends Repository {
  Future<void> addSettings(Settings settings) async {
    await dbAPI.addDocument(FirestoreAPI.settingsCollection, settings.toJson(), docID: settings.userID);
  }

  static Map<SettingsFields, String> dbFieldNameBySettingsField =
    <SettingsFields, String>{
      SettingsFields.allowFriendsEditTrial: 'AET',
      SettingsFields.allowFriendsEditGame: 'AEG',
      SettingsFields.isDarkMode: 'DM',
    };
}