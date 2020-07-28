import 'dart:collection';
import 'dart:core';

import 'package:maverick_trials/core/models/trial.dart';

//TODO: only build a cache for objects that will not need to be synced across different devices
//for instance, trials created by the user are locked for editing, so when the user goes to my Trials list - get the data once,
// then keep in memory since this data will not be seen by others
//cache should have no logic tied to a database or external dependency
class TrialCache {
  static const int cacheLimit = 2;

  //Look into a ListQueue instead if performance is an issue
  //A FIFO structure might be useful to easily get rid of older accessed data
  //while keeping more recently accessed data close
  ListQueue<Trial> _trials = ListQueue();

  ListQueue<Trial> getTrialsList() {
    return _trials;
  }

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
}
