import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'dart:async';

abstract class SettingsRepository {
  Future<void> addSettings(Settings settings);

  Future<void> getSettings(String id);

  Future<void> deleteSettings(Settings settings);

  Stream<List<Settings>> getSettingsList({SearchItem searchItem});

  Future<void> updateSettings(Settings settings);
}