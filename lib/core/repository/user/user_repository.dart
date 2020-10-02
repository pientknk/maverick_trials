import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'dart:async';


abstract class UserRepository {
  Future<void> addUser(User user);

  Future<void> getUser(String id);

  Future<void> deleteUser(User user);

  Future<List<User>> getUsers({SearchItem searchItem});

  Future<void> updateUser(User user);
}