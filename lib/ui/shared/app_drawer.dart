import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/exceptions/firestore_exception_handler.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/repository/settings/firebase_settings_repository.dart';
import 'package:maverick_trials/core/repository/user/firebase_user_repository.dart';
import 'package:maverick_trials/features/settings/ui/settings_view.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/ui/shared/logout_button.dart';

class AppDrawer extends StatelessWidget {
  final userRepository = locator<FirebaseUserRepository>();
  final settingsRepository = locator<FirebaseSettingsRepository>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 4.0,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 75,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.account_circle,
                      size: 40.0,
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
                    child: FutureBuilder<Settings>(
                      future: getSettings(),
                      builder: (context, snapshot){
                        return IconButton(
                          icon: Icon(
                            Icons.settings,
                          ),
                          onPressed: () {
                            if(!snapshot.hasData){
                              print('settings is null, what da heck');
                              //TODO: maybe have a popup dialogue for the error?
                            }
                            else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                    SettingsView(settings: snapshot.data),
                                ));
                            }
                          },
                        );
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
                Navigator.pop(context);
              }),
          _createDivider(),
          _createDrawerItem(
              iconData: Icons.gavel,
              text: 'Frenemies',
              onTap: () {
                Navigator.pop(context);
              }),
          _createDrawerItem(
              iconData: Icons.gavel,
              text: 'About',
              onTap: () {
                Navigator.pop(context);
              }),
          LogOutButton(),
          ListTile(
            title: Center(child: Text('v0.0.1')),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Future<Settings> getSettings() async {
    try{
      String uid = (await userRepository.getCurrentUser()).userUID;
      return await settingsRepository.getSettings(id: uid);
    }
    catch(error){
      print(FirestoreExceptionHandler.tryGetPlatformExceptionMessage(error));
      return null;
    }
  }

  Widget _buildDrawerNickname(AsyncSnapshot<String> snapshot) {
    if(snapshot.hasData){
      return Text(
        snapshot.data,
        style: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400),
      );
    }
    else{
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
