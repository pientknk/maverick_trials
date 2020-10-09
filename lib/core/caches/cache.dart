import 'dart:collection';

import 'package:maverick_trials/core/caches/cache_manager.dart';

class Cache<T> {
  int cacheHits = 0;
  int cacheMisses = 0;
  CacheType cacheType;
  ListQueue<T> cachedList;

  Cache({this.cacheType, int cacheLimit}){
    cachedList = ListQueue(cacheLimit);
  }

  T tryGet() {
    throw UnimplementedError('Implement Cache.tryGet');
  }

  void addData(T data){
    throw UnimplementedError('Implement Cache.add');
  }

  void clearCache(){
    throw UnimplementedError('Implement Cache.clearCache');
  }

  void hit(){
    cacheHits++;
  }

  void miss(){
    cacheMisses++;
  }
}