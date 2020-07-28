import 'package:cloud_firestore/cloud_firestore.dart';

//RTDB + CS (for icons)
class Medal {
  //A reference to a Firestore document representing this accolade
  DocumentReference reference;
  String name;
  String description;

  Medal(this.name, this.description);

  factory Medal.fromJson(Map<dynamic, dynamic> json) => _medalFromJson(json);

  Map<String, dynamic> toJson() => _medalToJson(this);

  @override
  String toString() => "Accolade<$name>";
}

Medal _medalFromJson(Map<dynamic, dynamic> json) {
  return Medal(json['name'] as String, json['description'] as String);
}

Map<String, dynamic> _medalToJson(Medal instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description
    };
