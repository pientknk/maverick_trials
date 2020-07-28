import 'package:get_it/get_it.dart';
import 'package:maverick_trials/core/services/auth_service.dart';

import 'core/services/firestore_api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreAPI());
  locator.registerLazySingleton(() => AuthService());
}