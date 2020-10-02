import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/filter_item.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/trial/firebase_trial_repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class TrialFilter<T> {
  FilterItem _filterItem;

  TrialFilter({@required FilterType filterType,
    @required TrialFields trialField,
    @required T value,
  }){
    _filterItem = FilterItem(
      collectionName: FirestoreAPI.trialsCollection,
      filterType: filterType,
      fieldName: FirebaseTrialRepository.dbFieldNames[trialField],
      friendlyFieldName: Trial.friendlyFieldNames[trialField],
      value: value,
    );
  }

  get filterItem => _filterItem;
}