import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/base/sort_item.dart';

class AppSortChip extends StatelessWidget {
  final SortItem sortItem;
  final VoidCallback onDelete;

  AppSortChip({Key key, @required this.sortItem, @required this.onDelete})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        children: <Widget>[
          Text(sortItem.friendlyFieldName),
          SortItem.sortTypeToIcon(sortItem.sortType),
        ],
      ),
      elevation: 4.0,
      onDeleted: onDelete,
    );
  }
}
