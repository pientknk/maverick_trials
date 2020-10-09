import 'package:flutter/material.dart';

///
/// A class to associate a value with a field in the database.
/// Used to help with searches.
///
class SearchItem<T>{
  final T value;
  final String fieldName;
  final String collectionName;

  const SearchItem({
    @required this.collectionName,
    this.value,
    this.fieldName,
  });
}