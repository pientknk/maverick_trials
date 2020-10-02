import 'package:get_it/get_it.dart';
import 'package:maverick_trials/core/repository/game/firebase_game_repository.dart';
import 'package:maverick_trials/core/repository/settings/firebase_settings_repository.dart';
import 'package:maverick_trials/core/repository/trial/firebase_trial_repository.dart';
import 'package:maverick_trials/core/repository/user/firebase_user_repository.dart';
import 'package:maverick_trials/core/services/auth_service.dart';

import 'core/services/firestore_api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreAPI());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FirebaseTrialRepository());
  locator.registerLazySingleton(() => FirebaseGameRepository());
  locator.registerLazySingleton(() => FirebaseUserRepository());
  locator.registerLazySingleton(() => FirebaseSettingsRepository());
}
