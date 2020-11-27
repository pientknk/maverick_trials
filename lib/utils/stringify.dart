import 'package:cloud_firestore/cloud_firestore.dart';

class Stringify{
  const Stringify();

  static String jsonToFriendlyString({
    Map<dynamic, String> dbFieldNames,
    Map<dynamic, String> friendlyFieldNames,
    Map<dynamic, dynamic> jsonData,
    String objectName})
  {

    if(dbFieldNames != null && friendlyFieldNames != null){
      Map<dynamic, dynamic> friendlyJson = Map<dynamic, dynamic>();
      dbFieldNames.forEach((key, value) {
        dynamic dataValue = jsonData[key];
        if(dataValue is Timestamp){
          dataValue = dataValue.toDate().toString();
        }
        else{
          dataValue = dataValue.toString();
        }

        friendlyJson[friendlyFieldNames[key]] = dataValue;
      });

      StringBuffer buffer = StringBuffer();
      buffer.writeln('$objectName {');
      friendlyJson.forEach((key, value) {
        buffer.writeln('\t$key: $value');
      });

      buffer.writeln('}');

      return buffer.toString();
    }
    else{
      return jsonData.toString();
    }
  }

  static String mapToFriendlyString(Map<dynamic, dynamic> map){
    StringBuffer buffer = StringBuffer();
    buffer.writeln('Map {');
    map.forEach((key, value) {
      buffer.writeln('\t$key: $value');
    });

    buffer.writeln('}');

    return buffer.toString();
  }

  /// Pass the ToString call of an enum value to this method
  static String enumValueFriendlyString(String enumValueToString){
    final splitString = enumValueToString.split('.');
    if(splitString.length == 2){
      return splitString[1];
    }

    return enumValueToString;
  }
}