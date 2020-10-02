import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/app_tabs.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final AppTabs activeTab;
  final Function(AppTabs) onTabSelected;

  AppBottomNavigationBar({Key key,
    @required this.activeTab,
    @required this.onTabSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white24,
      //showUnselectedLabels: false,
      key: UniqueKey(),
      currentIndex: AppTabs.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTabs.values[index]),
      items: AppTabs.values.map((appTab){
        return BottomNavigationBarItem(
          icon: _getIconForTab(appTab),
          activeIcon: _getIconForTab(appTab, isActive: true),
          title: _getTitleForTab(appTab, activeTab),
        );
      }).toList(),
    );
  }

  Widget _getIconForTab(AppTabs tab, {bool isActive = false}){
    switch(tab){
      case AppTabs.trials:
        return Icon(Icons.text_fields);
      case AppTabs.play:
        return Icon(Icons.play_circle_outline);
      case AppTabs.games:
        return Icon(Icons.games);
      default:
        return null;
    }

    /*
    IconData iconData;

    switch(tab){
      case AppTabs.trials:
        iconData = Icons.text_fields;
        break;
      case AppTabs.play:
        iconData = Icons.play_circle_outline;
        break;
      case AppTabs.games:
        iconData = Icons.games;
        break;
      default:
        break;
    }

    if(iconData == null){
      return null;
    }
    else{
      return Icon(iconData,
        color: isActive ? Colors.tealAccent : null,
      );
    }

     */
  }

  Widget _getTitleForTab(AppTabs tab, AppTabs activeTab){
    switch(tab){
      case AppTabs.play:
        return Text('Play');
      case AppTabs.games:
        return Text('Games');
      case AppTabs.trials:
        return Text('Trials');
      default:
        return null;
    }
    /*
    String text;
    Color textColor = Colors.white70;

    if(activeTab == tab){
      textColor = Colors.tealAccent;
    }

    switch(tab){
      case AppTabs.play:
        text = 'Play';
        break;
      case AppTabs.games:
        text = 'Games';
        break;
      case AppTabs.trials:
        text = 'Trials';
        break;
      default:
        text = '';
    }

    return Text(text, style: TextStyle(color: textColor));

     */
  }
}
