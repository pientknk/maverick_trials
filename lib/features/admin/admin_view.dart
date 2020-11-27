import 'package:flutter/material.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/features/admin/cache_view.dart';
import 'package:maverick_trials/features/admin/firestore_tracker_view.dart';
import 'package:maverick_trials/locator.dart';

class AdminView extends StatefulWidget {
  final FirestoreAPI dbAPI = locator<FirestoreAPI>();

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Pages'),
          bottom: TabBar(
            tabs: [
              Text('Database'),
              Text('Cache'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FirestoreTrackerView(dbAPI: widget.dbAPI),
            CacheView(dbAPI: widget.dbAPI),
            
          ],
        ),
      ),
    );
  }
}
