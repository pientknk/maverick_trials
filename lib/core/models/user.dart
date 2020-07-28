import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  DocumentReference reference; //reference.documentID == userID == nickname
  DateTime createdTime;
  String userUID; //firebase auth id
  String nickname; //used as the document id
  String firstName;
  String lastName;
  String
      localImageURL; //if avatars are only available from a list of local images, do we need to store them online?
  List<String> friendIDs;
  String careerID;
  String preferenceID;

  User(this.createdTime, this.userUID, this.nickname,
      {this.firstName,
      this.lastName,
      this.localImageURL,
      this.friendIDs,
      this.careerID,
      this.preferenceID});

  factory User.fromJson(Map<dynamic, dynamic> json) => _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);
}

User _userFromJson(Map<dynamic, dynamic> json) {
  return User(
    (json['CT'] as Timestamp).toDate(),
    json['UUID'] as String,
    json['N'] as String,
    firstName: json['FN'] as String,
    lastName: json['LN'] as String,
    localImageURL: json['A'] as String,
    friendIDs: List.from(json['Fs'] ?? List()),
    careerID: json['C'] as String,
    preferenceID: json['P'] as String,
  );
}

Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
      'CT': Timestamp.fromDate(instance.createdTime),
      'UUID': instance.userUID,
      'N': instance.nickname,
      'FN': instance.firstName,
      'LN': instance.lastName,
      'A': instance.localImageURL,
      'Fs': instance.friendIDs,
      'C': instance.careerID,
      'P': instance.preferenceID,
    };
