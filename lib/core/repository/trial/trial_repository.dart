import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'dart:async';

abstract class TrialRepository {
  Future<void> addTrial(Trial trial);

  Future<void> getTrial(String id);

  Future<void> deleteTrial(Trial trial);

  Future<List<Trial>> getTrials({SearchItem searchItem});

  Future<void> updateTrial(Trial trial);
}