import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/features/settings/ui/avatar_selection_view.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/ui/widgets/app_avatar.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_text_fields.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class SettingsForm extends StatefulWidget {
  final SettingsBloc settingsBloc;

  SettingsForm({@required this.settingsBloc});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final userRepository = locator<FirebaseUserRepository>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              child: SizedBox(
                width: 75,
                child: AppAvatarStream(
                  stream: widget.settingsBloc.avatar,
                  initialData: widget.settingsBloc.settings.avatarLink,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvatarSelectionView(
                      settingsBloc: widget.settingsBloc,
                    ),
                  ));
            },
          ),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: FutureBuilder<String>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ImportantText(snapshot.data,
                          fontSize: 24,
                        ),
                      ),
                    );
                  } else{
                    return CircularProgressIndicator();
                  }
                },
                future: userRepository.nickname,
              )),
          Expanded(
            child: Column(
              children: [
                SwitchListTileStreamField(
                  stream: widget.settingsBloc.darkMode,
                  title: ImportantText('Dark Mode'),
                  subtitle:
                      Text('This determines the main theme colors of the app'),
                  initialValue: widget.settingsBloc.settings.isDarkMode,
                  onChanged: widget.settingsBloc.onDarkModeChanged,
                ),
                SwitchListTileStreamField(
                  stream: widget.settingsBloc.darkMode,
                  title: ImportantText('Testing'),
                  subtitle: Text('This is just to see what it looks like'),
                  initialValue: widget.settingsBloc.settings.isDarkMode,
                  onChanged: widget.settingsBloc.onDarkModeChanged,
                ),
              ],
            ),
          ),
          AppButton(
              text: 'Save',
              onPressed: () {
                widget.settingsBloc.add(SettingsEventSave());
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
