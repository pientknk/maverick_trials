import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maverick_trials/core/models/base/data_model.dart';

class Medal with DataModel {
  String name;
  String description;

  Medal(this.name, this.description);

  factory Medal.fromJson(Map<dynamic, dynamic> json) => _medalFromJson(json);

  Map<String, dynamic> toJson() => _medalToJson(this);

  @override
  String toString() => "Medal<$name>";

  @override
  fromSnapshot(DocumentSnapshot snapshot) {
    // TODO: implement fromSnapshot
    throw UnimplementedError();
  }

  @override
  bool operator ==(obj) {
    if(obj is Medal){
      return obj.name == name;
    }

    return false;
  }

  @override
  int get hashCode {
    return name.hashCode;
  }

  @override
  String get id => name;
}

Medal _medalFromJson(Map<dynamic, dynamic> json) {
  if(json != null){
    return Medal(json['name'] as String, json['description'] as String);
  }
  else{
    return null;
  }
}

Map<String, dynamic> _medalToJson(Medal instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description
    };
