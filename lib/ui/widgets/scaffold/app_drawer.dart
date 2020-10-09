import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/features/about/ui/about_view.dart';
import 'package:maverick_trials/features/admin/firestore_tracker_view.dart';
import 'package:maverick_trials/features/career/ui/career_view.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/features/settings/ui/settings_view.dart';
import 'package:maverick_trials/features/user/ui/friends_view.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/features/app_drawer/ui/logout_button.dart';
import 'package:maverick_trials/ui/widgets/app_avatar.dart';

class AppDrawer extends StatelessWidget {
  final userRepository = locator<FirebaseUserRepository>();
  final SettingsBloc settingsBloc;

  AppDrawer(this.settingsBloc, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 4.0,
      child: ListView(
        // Important: Remove any padding from the ListView here within drawer.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 75,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 3.0, bottom: 3.0),
                    child: AppAvatar(
                      link: settingsBloc.settings.avatarLink,
                      size: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FutureBuilder<String>(
                      builder: (context, snapshot) {
                        return _buildDrawerNickname(snapshot);
                      },
                      future: userRepository.nickname,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                      ),
                      onPressed: () {
                        settingsBloc.add(ResetSettingsEvent());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsView(settingsBloc: settingsBloc,),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _createDrawerItem(
              iconData: Icons.pages,
              text: 'Career',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context){
                      return CareerView();
                    }
                  )
                );
              }),
          _createDivider(),
          _createDrawerItem(
              iconData: Icons.people,
              text: 'Frenemies',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context){
                      return FriendsView();
                    }
                  )
                );
              }),
          _createDrawerItem(
              iconData: Icons.clear,
              text: 'Clear Cache',
              onTap: () {
                Navigator.pop(context);
              }),
          _createDrawerItem(
              iconData: Icons.question_answer,
              text: 'About',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context){
                      return AboutView();
                    }
                  )
                );
              }),
          LogOutButton(),
          _buildAdminToolsDrawerItem(),
          ListTile(
            title: Center(child: Text('v0.0.1')),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAdminToolsDrawerItem() {
    return FutureBuilder<User>(
      future: userRepository.getCurrentUser(),
      builder: (context, snapshot) {
        return Visibility(
          child: _createDrawerItem(
              iconData: Icons.security,
              text: 'Admin Tools',
              onTap: () {
                print('Admin Tools Tapped');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FirestoreTrackerView(),
                ));
              }),
          visible: snapshot.hasData ? snapshot.data.isAdmin : false,
        );
      },
    );
  }

  Widget _buildDrawerNickname(AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      return Text(
        snapshot.data,
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400),
      );
    } else {
      return Container();
    }
  }

  Widget _createDrawerItem(
      {IconData iconData, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(iconData),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createDivider() {
    return Divider(
      height: 4.0,
      indent: 15.0,
      endIndent: 15.0,
      thickness: 0.5,
      color: Colors.grey,
    );
  }
}
