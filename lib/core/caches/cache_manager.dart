import 'package:maverick_trials/core/caches/cache.dart';

class CacheManager {
  Map<CacheType, Cache> cacheMap;

  CacheManager(Iterable<Cache> caches){
    cacheMap = Map<CacheType, dynamic>();
    caches.forEach((cache) {
      cacheMap[cache.cacheType] = cache;
    });
  }

  void clearAllCaches(){
    cacheMap.forEach((key, value) {
      value.clearCache();
    });
  }
}

enum CacheType { trial, user, settings }