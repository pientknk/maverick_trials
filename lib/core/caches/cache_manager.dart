import 'package:maverick_trials/core/caches/cache.dart';
import 'package:maverick_trials/core/caches/friends_cache.dart';
import 'package:maverick_trials/core/caches/setings_cache.dart';
import 'package:maverick_trials/core/caches/trial_cache.dart';
import 'package:maverick_trials/core/caches/user_cache.dart';
import 'package:maverick_trials/utils/stringify.dart';

class CacheManager {
  Map<CacheType, Cache> cacheMap;

  CacheManager(){
    _createCaches();
  }

  void _createCaches(){
    cacheMap = <CacheType, Cache>{
      CacheType.user : UserCache(),
      CacheType.settings : SettingsCache(),
      CacheType.friends : FriendsCache(),
      CacheType.trial : TrialCache(),
    };
  }

  String printCacheMap(){
    return Stringify.mapToFriendlyString(cacheMap);
  }

  void clearAllCaches(){
    cacheMap.values.forEach((cache) => cache.clearCache());
  }
}

enum CacheType { trial, user, friends, settings }