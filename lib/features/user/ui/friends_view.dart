import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frenemies'),
      ),
      body: Center(
        child: ImportantText('Coming Soon...'),
      ),
    );
  }
}
