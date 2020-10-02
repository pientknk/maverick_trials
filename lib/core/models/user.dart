import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/repository/user/firebase_user_repository.dart';

class User {
  DocumentReference reference; //reference.documentID == userID == nickname
  DateTime createdTime;
  String userUID; //firebase auth id
  String nickname; //used as the document id
  String firstName;
  String lastName;
  List<String> friendIDs;
  String careerID;
  String settingsID;
  bool isAdmin;

  User.newUser(){
    this.createdTime = DateTime.now();
    this.isAdmin = false;
  }

  User(this.createdTime,
    this.userUID,
    this.nickname,
      {this.firstName,
      this.lastName,
      this.friendIDs,
      this.careerID,
      this.settingsID,
      this.isAdmin = false});

  factory User.fromJson(Map<dynamic, dynamic> json) => _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);
}

User _userFromJson(Map<dynamic, dynamic> json) {
  return User(
    (json[FirebaseUserRepository.dbFieldNames[UserFields.createdTime]] as Timestamp).toDate(),
    json[FirebaseUserRepository.dbFieldNames[UserFields.userUID]] as String,
    json[FirebaseUserRepository.dbFieldNames[UserFields.nickname]] as String,
    firstName: json[FirebaseUserRepository.dbFieldNames[UserFields.firstName]] as String,
    lastName: json[FirebaseUserRepository.dbFieldNames[UserFields.lastName]] as String,
    friendIDs: List.from(json[FirebaseUserRepository.dbFieldNames[UserFields.friendIDs]] ?? List()),
    careerID: json[FirebaseUserRepository.dbFieldNames[UserFields.careerID]] as String,
    settingsID: json[FirebaseUserRepository.dbFieldNames[UserFields.settingsID]] as String,
    isAdmin: json[FirebaseUserRepository.dbFieldNames[UserFields.isAdmin]] as bool,
  );
}

Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
  FirebaseUserRepository.dbFieldNames[UserFields.createdTime]: Timestamp.fromDate(instance.createdTime),
  FirebaseUserRepository.dbFieldNames[UserFields.userUID]: instance.userUID,
  FirebaseUserRepository.dbFieldNames[UserFields.nickname]: instance.nickname,
  FirebaseUserRepository.dbFieldNames[UserFields.firstName]: instance.firstName,
  FirebaseUserRepository.dbFieldNames[UserFields.lastName]: instance.lastName,
  FirebaseUserRepository.dbFieldNames[UserFields.friendIDs]: instance.friendIDs,
  FirebaseUserRepository.dbFieldNames[UserFields.careerID]: instance.careerID,
  FirebaseUserRepository.dbFieldNames[UserFields.settingsID]: instance.settingsID,
  FirebaseUserRepository.dbFieldNames[UserFields.isAdmin]: false,
    };

Map<UserFields, String> friendlyFieldNames = <UserFields, String> {
  UserFields.createdTime: 'Created Time',
  UserFields.userUID: 'User ID',
  UserFields.nickname: 'Nickname',
  UserFields.firstName: 'Firstname',
  UserFields.lastName: 'Lastname',
  UserFields.friendIDs: 'Friends',
  UserFields.careerID: 'Career',
  UserFields.settingsID: 'Settings',
  UserFields.isAdmin: 'Admin',
};

enum UserFields {
  createdTime,
  userUID,
  nickname,
  firstName,
  lastName,
  friendIDs,
  careerID,
  settingsID,
  isAdmin,
}