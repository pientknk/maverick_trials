import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/medal.dart';

//RTDB
class UserCareer {
  //A reference to a Firestore document representing this accolade
  DocumentReference reference;
  DateTime createdTime;
  int experience;
  List<Medal> accolades = List<Medal>();

  UserCareer({this.createdTime, this.experience, this.accolades});

  factory UserCareer.fromSnapshot(DocumentSnapshot snapshot) {
    UserCareer newUserCareer = UserCareer.fromJson(snapshot.data);
    newUserCareer.reference = snapshot.reference;
    return newUserCareer;
  }

  factory UserCareer.fromJson(Map<String, dynamic> json) =>
      _userCareerFromJson(json);

  Map<String, dynamic> toJson() => _userCareerToJson(this);

  @override
  String toString() => "UserCareer<$createdTime-$experience>";
}

UserCareer _userCareerFromJson(Map<String, dynamic> json) {
  return UserCareer(
      createdTime: json['createdTime'] == null
          ? null
          : (json['createdTime'] as Timestamp).toDate(),
      experience: json['experience'] as int,
      accolades: _convertAccolades(json['accolades'] as List));
}

List<Medal> _convertAccolades(List accoladeMap) {
  List<Medal> accolades = List<Medal>();
  if (accoladeMap != null) {
    accoladeMap.forEach((value) {
      accolades.add(Medal.fromJson(value));
    });
  }

  return accolades;
}

Map<String, dynamic> _userCareerToJson(UserCareer instance) =>
    <String, dynamic>{
      'createdTime': instance.createdTime,
      'experience': instance.experience,
      'accolades': _accoladeList(instance.accolades)
    };

List<Map<String, dynamic>> _accoladeList(List<Medal> accolades) {
  if (accolades == null) {
    return null;
  }

  List<Map<String, dynamic>> accoladeMap = List<Map<String, dynamic>>();
  accolades.forEach((accolade) {
    accoladeMap.add(accolade.toJson());
  });

  return accoladeMap;
}
