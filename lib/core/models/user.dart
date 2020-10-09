import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/base/data_model.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';

class User with DataModel {
  DateTime createdTime;
  String userUID; //firebase auth id
  String nickname; //used as the document id
  String firstName;
  String lastName;
  List<String> friendIDs;
  String careerID;
  bool isAdmin;

  User();

  User.newUser(){
    this.createdTime = DateTime.now();
    this.isAdmin = false;
  }

  User._fromProperties(this.createdTime,
    this.userUID,
    this.nickname,
      {this.firstName,
      this.lastName,
      this.friendIDs,
      this.careerID,
      this.isAdmin = false});

  factory User.fromJson(Map<dynamic, dynamic> json) => _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);

  @override
  fromSnapshot(DocumentSnapshot snapshot) {
    if(snapshot != null){
      User user = User.fromJson(snapshot.data);
      user?.reference = snapshot.reference;
      return user;
    }
    else{
      return null;
    }
  }

  @override
  String get id => nickname;
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
      json[FirebaseUserRepository.dbFieldNames[UserFields.userUID]] as String,
      json[FirebaseUserRepository.dbFieldNames[UserFields.nickname]] as String,
      firstName: json[FirebaseUserRepository.dbFieldNames[UserFields.firstName]] as String,
      lastName: json[FirebaseUserRepository.dbFieldNames[UserFields.lastName]] as String,
      friendIDs: List.from(json[FirebaseUserRepository.dbFieldNames[UserFields.friendIDs]] ?? List()),
      careerID: json[FirebaseUserRepository.dbFieldNames[UserFields.careerID]] as String,
      isAdmin: json[FirebaseUserRepository.dbFieldNames[UserFields.isAdmin]] as bool,
    );
  }
  else{
    return null;
  }
}

Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
  FirebaseUserRepository.dbFieldNames[UserFields.createdTime]: Timestamp.fromDate(instance.createdTime),
  FirebaseUserRepository.dbFieldNames[UserFields.userUID]: instance.userUID,
  FirebaseUserRepository.dbFieldNames[UserFields.nickname]: instance.nickname,
  FirebaseUserRepository.dbFieldNames[UserFields.firstName]: instance.firstName,
  FirebaseUserRepository.dbFieldNames[UserFields.lastName]: instance.lastName,
  FirebaseUserRepository.dbFieldNames[UserFields.friendIDs]: instance.friendIDs,
  FirebaseUserRepository.dbFieldNames[UserFields.careerID]: instance.careerID,
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
  isAdmin,
}