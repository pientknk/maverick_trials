import 'package:flutter/material.dart';
import 'package:maverick_trials/features/intro/ui/coming_soon_background.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/intro_page.dart';

class TutorialIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      key: UniqueKey(),
      header: 'Tutorial',
      background: ComingSoonBackground(),
      contentParts: [
        "Using the app's drawer menu you can go back to the tutorial anytime you want.",
        "If you'd like to see how the new features are used after an update, come back here for more information.",
      ],
    );
  }
}
