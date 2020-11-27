import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:maverick_trials/core/caches/cache_manager.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/locator.dart';

class Cache<T> {
  final Logging logging = locator<Logging>();
  int cacheHits = 0;
  int cacheMisses = 0;
  int cacheLimit;
  CacheType cacheType;
  ListQueue<T> cachedList;

  Cache({@required this.cacheType, @required this.cacheLimit}){
    cachedList = ListQueue(cacheLimit);
  }

  T tryGet() {
    throw UnimplementedError('Implement Cache.tryGet');
  }

  void addData(T data){
    throw UnimplementedError('Implement Cache.add');
  }

  void addList(List<T> dataList){
    throw UnimplementedError('Implement Cache.addList');
  }

  void clearCache(){
    cachedList.clear();
    cacheHits = 0;
    cacheMisses = 0;
  }

  bool removeData(T data){
    throw UnimplementedError('Implement Cache.removeData');
  }

  void hit(){
    cacheHits++;
  }

  void miss(){
    cacheMisses++;
  }
}