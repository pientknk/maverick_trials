import 'package:maverick_trials/core/caches/cache.dart';
import 'package:maverick_trials/core/caches/cache_manager.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/models/user.dart';

class UserCache extends Cache<User>{
  UserCache() : super(cacheType: CacheType.user, cacheLimit: 1);

  @override
  User tryGet() {
    if(cachedList.length > 0){
      logging.log(LogType.pretty, LogLevel.debug, 'User Cache Hit');
      hit();
      return cachedList.first;
    }
    else{
      miss();
      logging.log(LogType.pretty, LogLevel.debug, 'User Cache Miss, cache list empty');
      return null;
    }
  }

  @override
  void addData(User data) {
    if(data != null && data.firebaseUser != null){
      if(data.firebaseUser.isAnonymous){
        logging.log(LogType.pretty, LogLevel.debug, "Anonymous user will not be added to cache.");
      }
      else if(cachedList.length == cacheLimit){
        if(removeData(data)){
          cachedList.add(data);
        }
        else{
          logging.log(LogType.pretty, LogLevel.debug, "Error adding to cache, unable to remove data: $data");
        }
      }
      else{
        cachedList.add(data);
      }
    }
    else{
      logging.log(LogType.pretty, LogLevel.debug, "Unable to add user to cache, provided user or firebase user is null");
    }
  }

  @override
  bool removeData(User data) {
    if(!cachedList.remove(data)){
      logging.log(LogType.pretty, LogLevel.debug, 'removeData: Unable to remove data from cache:\n${data.toString()}');
      return false;
    }

    return true;
  }
}
