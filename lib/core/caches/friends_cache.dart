import 'package:maverick_trials/core/caches/cache.dart';
import 'package:maverick_trials/core/caches/cache_manager.dart';
import 'package:maverick_trials/core/models/user.dart';

class FriendsCache extends Cache<User> {
  FriendsCache() : super(cacheType: CacheType.friends, cacheLimit: 50);

  @override
  User tryGet() {
    // TODO: implement tryGet
    return super.tryGet();
  }

  @override
  void addList(List<User> dataList) {
    // TODO: implement addList
    super.addList(dataList);
  }

  @override
  void addData(User data) {
    // TODO: implement addData
    super.addData(data);
  }

  @override
  bool removeData(User data) {
    // TODO: implement removeData
    return super.removeData(data);
  }
}