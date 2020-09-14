import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/core/models/sort_item.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class TrialBottomSheet extends StatefulWidget {
  @override
  _TrialBottomSheet createState() => _TrialBottomSheet();
}

class _TrialBottomSheet extends State<TrialBottomSheet> {
  SortType nameSortType = SortType.None;
  SortType ratingSortType = SortType.None;
  SortType fairnessSortType = SortType.None;
  SortType favoritesSortType = SortType.None;
  FaIcon currentNameSortIcon;
  FaIcon currentRatingSortIcon;
  FaIcon currentFairnessSortIcon;
  FaIcon currentFavoriteSortIcon;

  @override
  void initState() {
    currentNameSortIcon = SortItem.sortTypeToIcon(nameSortType);
    currentRatingSortIcon = SortItem.sortTypeToIcon(ratingSortType);
    currentFairnessSortIcon = SortItem.sortTypeToIcon(fairnessSortType);
    currentFavoriteSortIcon = SortItem.sortTypeToIcon(favoritesSortType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          topPiece(
            ListTile(
              title: Center(
                child: AccentThemeText(
                  text: 'Sorting By',
                ),
              ),
              dense: true,
            ),
          ),
          middlePiece(
            ListTile(
              title: AccentThemeText(
                text: 'Recently Played',
                isBold: true,
              ),
            ),
          ),
          middlePiece(
            ListTile(
              title: AccentThemeText(
                text: 'Name',
                isBold: true,
              ),
              trailing: currentNameSortIcon,
              onTap: () {
                setState(() {
                  setNameSort();
                });
              },
            ),
          ),
          middlePiece(
            ListTile(
              title: AccentThemeText(
                text: 'Rating',
                isBold: true,
              ),
              trailing: currentRatingSortIcon,
              onTap: () {
                setState(() {
                  setRatingSort();
                });
              },
            ),
          ),
          middlePiece(ListTile(
            title: AccentThemeText(
              text: 'Fairness',
              isBold: true,
            ),
            trailing: currentFairnessSortIcon,
            onTap: () {
              setState(() {
                setFairnessSort();
              });
            },
          )),
          bottomPiece(ListTile(
            title: AccentThemeText(
              text: 'Favorites',
              isBold: true,
            ),
            trailing: currentFavoriteSortIcon,
            onTap: () {
              setState(() {
                setFavoritesSort();
              });
            },
          )),
          dismissButton(),
        ],
      ),
    );
  }

  void resetSortTypes() {}

  void updateAllSortIcons() {
    currentNameSortIcon = setSortIcon(currentNameSortIcon, nameSortType);
    currentRatingSortIcon = setSortIcon(currentRatingSortIcon, ratingSortType);
    currentFairnessSortIcon =
        setSortIcon(currentFairnessSortIcon, fairnessSortType);
    currentFavoriteSortIcon =
        setSortIcon(currentFavoriteSortIcon, favoritesSortType);
  }

  void setRatingSort() {
    nameSortType = SortType.None;
    ratingSortType = switchSortType(ratingSortType);
    fairnessSortType = SortType.None;
    favoritesSortType = SortType.None;

    updateAllSortIcons();
  }

  void setNameSort() {
    nameSortType = switchSortType(nameSortType);
    ratingSortType = SortType.None;
    fairnessSortType = SortType.None;
    favoritesSortType = SortType.None;

    updateAllSortIcons();
  }

  void setFairnessSort() {
    nameSortType = SortType.None;
    ratingSortType = SortType.None;
    fairnessSortType = switchSortType(fairnessSortType);
    favoritesSortType = SortType.None;

    updateAllSortIcons();
  }

  void setFavoritesSort() {
    nameSortType = SortType.None;
    ratingSortType = SortType.None;
    fairnessSortType = SortType.None;
    favoritesSortType = switchSortType(favoritesSortType);

    updateAllSortIcons();
  }

  SortType switchSortType(SortType sortType) {
    sortType == SortType.None
        ? sortType = SortType.Asc
        : sortType == SortType.Asc
            ? sortType = SortType.Desc
            : sortType = SortType.None;
    return sortType;
  }

  FaIcon setSortIcon(FaIcon icon, SortType sortType) {
    icon = SortItem.sortTypeToIcon(
      sortType,
      color: sortType == SortType.None ? null : Colors.purple,
    );

    return icon;
  }

  Widget dismissButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: new BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ListTile(
        title: Center(
          child: AccentThemeText(
            text: "Dismiss",
            isBold: true,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget topPiece(Widget content) {
    return Container(
      //margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: content,
    );
  }

  Widget middlePiece(Widget widget) {
    return Container(
      //margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: widget,
    );
  }

  Widget bottomPiece(Widget widget) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: widget,
    );
  }
}
