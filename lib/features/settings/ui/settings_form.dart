import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/user/firebase_user_repository.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/features/settings/ui/avatar_selection_view.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/ui/widgets/app_animated_switch.dart';
import 'package:maverick_trials/ui/widgets/app_text_fields.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final userRepository = locator<FirebaseUserRepository>();

  SettingsBloc _settingsBloc;
  bool isDarkMode;

  @override
  void initState() {
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AvatarSelectionView(settings: _settingsBloc.settings),
                      )
                    );
                  },
                  child: _settingsBloc.settings.avatarLink != null
                    ? CircleAvatar(
                    backgroundImage: AssetImage(_settingsBloc.settings.avatarLink),
                  )
                    : CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FutureBuilder<User>(
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      String firstName = snapshot.data.firstName;
                      String lastName = snapshot.data.lastName;
                      String displayName;
                      if(firstName != null && lastName != null){
                        displayName = '$firstName $lastName';
                      }

                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ImportantText(text: displayName ?? snapshot.data.nickname),
                        ),
                      );
                    }
                    else{
                      return CircularProgressIndicator();
                    }
                  },
                  future: userRepository.getCurrentUser(),
                )
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 20.0),
                  children: <Widget>[
                    SwitchListTileStreamField(
                      stream: _settingsBloc.darkMode,
                      title: ImportantText(text: 'Dark Mode'),
                      subtitle: Text('This determines the main theme colors of the app'),
                      initialValue: _settingsBloc.settings.isDarkMode,
                      onChanged: _settingsBloc.onDarkModeChanged,
                    ),
                    SwitchListTileStreamField(
                      stream: _settingsBloc.darkMode,
                      title: ImportantText(text: 'Testing'),
                      subtitle: Text('This is just to see what it looks like'),
                      initialValue: _settingsBloc.settings.isDarkMode,
                      onChanged: _settingsBloc.onDarkModeChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
