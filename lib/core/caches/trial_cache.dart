import 'dart:core';

import 'package:maverick_trials/core/caches/cache.dart';
import 'package:maverick_trials/core/caches/cache_manager.dart';
import 'package:maverick_trials/core/models/trial.dart';

//TODO: only build a cache for objects that will not need to be synced across different devices
//for instance, trials created by the user are locked for editing, so when the user goes to my Trials list - get the data once,
// then keep in memory since this data will not be seen by others
//cache should have no logic tied to a database or external dependency
class TrialCache extends Cache<Trial> {
  TrialCache() : super(cacheType: CacheType.trial, cacheLimit: 20);

  @override
  Trial tryGet() {
    // TODO: implement tryGet
    return null;
  }

  @override
  void addData(Trial data) {
    // TODO: implement addData
    if(data != null){

    }
  }

  @override
  void addList(List<Trial> dataList) {
    // TODO: implement addList
    if(dataList != null && dataList.isNotEmpty){

    }
  }

  @override
  void clearCache() {
    cachedList.clear();
  }

  /*
  void addTrial(Trial trial) {
    if (_trials.length != 0 && _trials.length == cacheLimit) {
      _trials.removeFirst();
      _trials.add(trial);
    } else {
      _trials.add(trial);
    }
  }

  /// This method overwrites the existing cache
  /// with the given list of Trials
  void saveTrialsList(List<Trial> trials) {
    if (_trials != null) {
      _trials.clear();
      _trials.addAll(trials);
    } else {
      _trials = new ListQueue(cacheLimit);
      _trials.addAll(trials);
    }
  }

   */
}
