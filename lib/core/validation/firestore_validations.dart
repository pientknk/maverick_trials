import 'package:flutter/material.dart';

class FirestoreValidations<T> {
  bool validateUnique({
    @required String id,
    @required String path,
  }){
    //TODO: build uniqueness validation for the object by searching firestore
    // for something with the same id
    return true;
  }
}