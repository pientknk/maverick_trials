import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/models/user.dart';

class Profile {
  User user;
  FirebaseUser firebaseUser;
  Settings settings;
  //Career career;

  Profile(
      {@required this.user,
      @required this.firebaseUser,
      @required this.settings})
      : assert(user != null),
        assert(firebaseUser != null),
        assert(settings != null);
}
