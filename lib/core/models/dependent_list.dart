import 'dart:core';

class DependentList<T> {
  T dependency;
  List<T> dependents;
}