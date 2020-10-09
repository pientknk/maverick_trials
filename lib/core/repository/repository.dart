import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/services/auth_service.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

abstract class Repository<T>{
  FirestoreAPI dbAPI = locator<FirestoreAPI>();
  AuthService authAPI = locator<AuthService>();

  Future<T> add(T data);

  Future<T> get(String id);

  Future<bool> delete(T data);

  Future<List<T>> getList({SearchItem searchItem});

  Stream<List<T>> getStreamList({SearchItem searchItem});

  Future<bool> update(T data);
}
