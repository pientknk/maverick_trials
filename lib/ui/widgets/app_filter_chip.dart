import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/base/filter_item.dart';

class AppFilterChip extends StatelessWidget {
  final FilterItem filterItem;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  AppFilterChip({Key key,
    @required this.filterItem,
    @required this.onDelete,
    @required this.onTap,
  })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    //see also FilterChip()
    return GestureDetector(
      child: Chip(
        label: Row(
          children: <Widget>[
            Text(filterItem.friendlyFieldName),
            FilterItem.filterTypeToIcon(filterItem.filterType),
            Text(filterItem.value),
          ],
        ),
        elevation: 4.0,
        onDeleted: onDelete,
      ),
      onTap: onTap,
    );
  }
}
