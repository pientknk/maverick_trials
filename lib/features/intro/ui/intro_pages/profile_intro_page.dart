import 'package:flutter/material.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/intro_page.dart';
import 'package:maverick_trials/ui/widgets/app_avatar.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class ProfileIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      header: 'Profile and Friends',
      backgroundAlignment: Alignment.center,
      background: _background(),
      contentParts: [
        'Customize your avatar and create a slogan to make your profile'
          ' unique. Add friends in order to play with them, and compare your levels'
          ' and trophies.',
        'You can also cuzstomize the theme of the app through the settings.',
      ],
    );
  }

  Widget _background(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: 75,
              child: AppAvatar(
                link: "images/avatars/loki_256.png",
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ImportantText(
                'WarmWatermelon',
                fontSize: 24,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Expanded(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: 'Slogan',
                    enabled: false,
                  ),
                  ListTile(
                    enabled: false,
                    title: Text('Dark Mode'),
                    subtitle:
                    Text('This determines the main theme colors of the app'),
                    trailing: Switch(
                      onChanged: null,
                      value: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
