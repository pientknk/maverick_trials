import 'package:maverick_trials/core/models/user.dart';

class UserCache {
  User _user;

  User getUser() {
    return _user;
  }

  addUser(User user) {
    _user = user;
  }
}
