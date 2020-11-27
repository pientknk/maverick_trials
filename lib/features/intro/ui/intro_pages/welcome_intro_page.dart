import 'package:flutter/material.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/intro_page.dart';

class WelcomeIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      header: 'Welcome to Maverick Trials!',
      background: _pedestal(),
      contentParts: [
        'Maverick Trials brings together mini games and friends in a competitive, fun, and unique fun way.',
        'Earn your way to victory by winning Trials and getting first place in a Game against your friends!',
      ]);
  }
  
  Widget _pedestal(){
    return Stack(
      children: [
        Image.asset(
          "images/icons/pedestal_256.png",
          width: 300,
          height: 400,
        ),
        Positioned(
          top: 0,
          left: 150 - 125 / 2,
          child: Image.asset(
            "images/avatars/star_lord_256.png",
            height: 125,
            width: 125,
          ),
        ),
        Positioned(
          top: 70,
          left: 5,
          child: Image.asset(
            "images/avatars/thanos_256.png",
            width: 100,
            height: 100,
          ),
        ),
        Positioned(
          top: 110,
          right: 20,
          child: Image.asset(
            "images/avatars/ironman_256.png",
            height: 75,
            width: 75,
          ),
        ),
      ],
    );
  }
}
