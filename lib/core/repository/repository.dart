import 'package:maverick_trials/core/services/auth_service.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class Repository {
  FirestoreAPI dbAPI = locator<FirestoreAPI>();
  AuthService authAPI = locator<AuthService>();
}
