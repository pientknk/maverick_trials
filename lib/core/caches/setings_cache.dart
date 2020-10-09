import 'package:maverick_trials/core/caches/cache.dart';
import 'package:maverick_trials/core/caches/cache_manager.dart';
import 'package:maverick_trials/core/models/settings.dart';

class SettingsCache extends Cache<Settings> {
  SettingsCache() : super(cacheType: CacheType.settings, cacheLimit: 1);

  @override
  Settings tryGet() {
    if(cachedList.length > 0){
      hit();
      return cachedList.first;
    }
    else{
      miss();
      return null;
    }
  }

  @override
  void addData(Settings data) {
    if(cachedList.length > 0){
      cachedList.clear();
      cachedList.add(data);
    }
  }

  @override
  void clearCache() {
    cachedList.clear();
  }
}