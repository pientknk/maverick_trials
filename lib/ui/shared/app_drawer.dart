import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';
import 'package:maverick_trials/ui/shared/logout_button.dart';

class AppDrawer extends StatelessWidget {
  final UserRepository userRepository;

  AppDrawer({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        userRepository = userRepository,
        super(key: key);

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
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.account_circle,
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<String>(
                      builder: (context, snapshot) {
                        return _buildDrawerNickname(snapshot);
                      },
                      future: getNickname(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      onPressed: () {},
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
            title: Text('v0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Future<String> getNickname() async {
    final user = await userRepository.getCurrentUser();
    return user.nickname;
  }

  Widget _buildDrawerNickname(AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      return Text(
        snapshot.data,
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400),
      );
    } else {
      return SizedBox(
        width: 25,
        child: BasicProgressIndicator(),
      );
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
