import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/ui/widgets/app_animated_switch.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isDarkMode = false;
  bool allowEditTrials = true;
  bool allowEditGames = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          children: <Widget>[
            AppAnimatedToggle(
              label: Settings
                  .friendlyFieldNameBySettingsField[SettingsFields.isDarkMode],
              isChecked: isDarkMode,
              onTap: toggleIsDarkModeSwitch,
            ),
            AppAnimatedToggle(
              label: Settings.friendlyFieldNameBySettingsField[
                  SettingsFields.allowFriendsEditTrial],
              isChecked: allowEditTrials,
              onTap: toggleAllowEditTrials,
            ),
            AppAnimatedToggle(
              label: Settings.friendlyFieldNameBySettingsField[
                  SettingsFields.allowFriendsEditGame],
              isChecked: allowEditGames,
              onTap: toggleAllowEditGames,
            ),
          ],
        ),
    );
  }

  toggleIsDarkModeSwitch() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  toggleAllowEditTrials() {
    setState(() {
      allowEditTrials = !allowEditTrials;
    });
  }

  toggleAllowEditGames() {
    setState(() {
      allowEditGames = !allowEditGames;
    });
  }
}
