import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SortItem {
  final SortType sortType;
  final String fieldName;
  final String friendlyFieldName;
  final String collectionName;

  const SortItem({
    @required this.sortType,
    @required this.fieldName,
    @required this.collectionName,
    this.friendlyFieldName,
  });

  static FaIcon sortTypeToIcon(SortType sortType, {Color color}) {
    IconData iconData;
    switch (sortType) {
      case SortType.Asc:
        iconData = FontAwesomeIcons.sortDown;
        break;
      case SortType.Desc:
        iconData = FontAwesomeIcons.sortUp;
        break;
      case SortType.None:
        iconData = FontAwesomeIcons.sort;
        break;
      default:
        iconData = FontAwesomeIcons.sort;
        print("unknown sortType: $sortType");
        break;
    }

    return FaIcon(iconData,
      color: color ?? Colors.white);
  }

  @override
  bool operator ==(other) {
    if (other is SortItem &&
        other.sortType == sortType &&
        other.fieldName == fieldName &&
        other.friendlyFieldName == friendlyFieldName &&
        other.collectionName == collectionName) {
      return true;
    }

    return false;
  }

  @override
  int get hashCode =>
      19 * sortType.hashCode +
      fieldName.hashCode +
      friendlyFieldName.hashCode +
      collectionName.hashCode;
}

enum SortType { Asc, Desc, None }
