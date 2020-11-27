import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/models/base/data_model.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/utils/stringify.dart';

class User with DataModel {
  FirebaseUser firebaseUser;
  DateTime createdTime;
  bool completedIntro;
  List<String> friendIDs; //limit this to 100?
  String careerID;
  bool isAdmin;

  User(){
    this.isAdmin = false;
  }

  User.newUser(){
    this.createdTime = DateTime.now();
    this.isAdmin = false;
    this.completedIntro = false;
  }

  User._fromProperties(this.createdTime,
      {this.friendIDs,
      this.careerID,
      this.isAdmin = false,
      this.completedIntro = false});

  factory User.fromJson(Map<dynamic, dynamic> json) => _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);

  @override
  fromSnapshot(DocumentSnapshot snapshot) {
    if(snapshot != null){
      User user = User.fromJson(snapshot.data);
      if(user == null){
        locator<Logging>().logPretty(LogLevel.info, "Unable to get user from DocumentSnapshot. Creating default user.");
        return User.newUser();
      }

      user.reference = snapshot.reference;
      return user;
    }
    else{
      return null;
    }
  }

  @override
  String get id => reference?.documentID ?? firebaseUser?.displayName;

  bool get hasCompletedIntro => completedIntro ?? false;

  bool get hasNickname => firebaseUser == null
    ? firebaseUser.isAnonymous
    : firebaseUser.displayName != null;

  @override
  String toString() {
    return Stringify.jsonToFriendlyString(
      objectName: 'User',
      dbFieldNames: FirebaseUserRepository.dbFieldNames,
      friendlyFieldNames: friendlyFieldNames,
      jsonData: _userToJson(this),
    );
    //return _userToJson(this).toString();
  }

  @override
  bool operator ==(obj) {
    if(obj is User){
      return obj.id != null && this.id != null && obj.id == this.id;
    }

    return false;
  }

  @override
  int get hashCode => id.hashCode;
}

/*
List<User> _convertFriendIDs(List<String> friendsIDs) {
  List<User> users = List<User>();
  if (friendsIDs != null) {
    friendsIDs.forEach((value) {
      //should this method be in the repository? otherwise need to query here to get users by id
      //users.add();
    });
  }

  return users;
}

 */

User _userFromJson(Map<dynamic, dynamic> json) {
  if(json != null){
    return User._fromProperties(
      (json[FirebaseUserRepository.dbFieldNames[UserFields.createdTime]] as Timestamp).toDate(),
      friendIDs: List.from(json[FirebaseUserRepository.dbFieldNames[UserFields.friendIDs]] ?? List()),
      careerID: json[FirebaseUserRepository.dbFieldNames[UserFields.careerID]] as String,
      isAdmin: json[FirebaseUserRepository.dbFieldNames[UserFields.isAdmin]] as bool,
      completedIntro: json[FirebaseUserRepository.dbFieldNames[UserFields.completedIntro]] as bool,
    );
  }
  else{
    return null;
  }
}

Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
  FirebaseUserRepository.dbFieldNames[UserFields.createdTime]: instance.createdTime == null ? DateTime.now() : Timestamp.fromDate(instance.createdTime),
  FirebaseUserRepository.dbFieldNames[UserFields.friendIDs]: instance.friendIDs,
  FirebaseUserRepository.dbFieldNames[UserFields.careerID]: instance.careerID,
  FirebaseUserRepository.dbFieldNames[UserFields.isAdmin]: false,
  FirebaseUserRepository.dbFieldNames[UserFields.completedIntro]: instance.completedIntro,
    };

Map<UserFields, String> friendlyFieldNames = <UserFields, String> {
  UserFields.createdTime: 'Created Time',
  UserFields.friendIDs: 'Friends',
  UserFields.completedIntro: 'Completed Intro',
  UserFields.careerID: 'Career',
  UserFields.isAdmin: 'Admin',
};

enum UserFields {
  createdTime,
  completedIntro,
  friendIDs,
  careerID,
  isAdmin,
}