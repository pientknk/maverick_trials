import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataModel<T> {
  DocumentReference reference;

  T fromSnapshot(DocumentSnapshot snapshot);

  String get id;
}