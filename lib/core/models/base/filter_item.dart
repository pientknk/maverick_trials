import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterItem<T> {
  final FilterType filterType;
  final T value;
  final String fieldName;
  final String friendlyFieldName;
  final String collectionName;

  const FilterItem({
    @required this.filterType,
    @required this.value,
    @required this.fieldName,
    @required this.collectionName,
    this.friendlyFieldName,
  });

  static Widget filterTypeToIcon(FilterType filterType) {
    IconData iconData;
    switch (filterType) {
      case FilterType.EqualTo:
        iconData = Icons.drag_handle;
        break;
      case FilterType.GreaterThan:
        iconData = FontAwesomeIcons.angleLeft;
        break;
      case FilterType.LessThan:
        iconData = FontAwesomeIcons.angleRight;
        break;
      default:
        iconData = FontAwesomeIcons.question;
        print("unknown filter type: $filterType");
        break;
    }

    return FaIcon(iconData);
  }

  @override
  bool operator ==(other) {
    if (other is FilterItem &&
        other.filterType == filterType &&
        other.value == value &&
        other.fieldName == fieldName &&
        other.friendlyFieldName == friendlyFieldName &&
        other.collectionName == collectionName) {
      return true;
    }

    return false;
  }

  @override
  int get hashCode =>
      19 * filterType.hashCode +
      value.hashCode +
      fieldName.hashCode +
      friendlyFieldName.hashCode +
      collectionName.hashCode;
}

enum FilterType { EqualTo, GreaterThan, LessThan, Is }
