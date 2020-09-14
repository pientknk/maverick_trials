import 'package:flutter/material.dart';
import 'package:maverick_trials/features/trial/list/ui/trial_list_view.dart';

class HomeTabView extends StatefulWidget {
  HomeTabView(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  State<StatefulWidget> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        return TrialListView();
        break;
      case 1:
        //TODO: after Trial is done, work on game
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(child: Text('Testing out widgets and theme here'),)
            ],
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }

/*
  Widget _buildHomeTabs(homeTabs homeTab){
    return StreamBuilder<QuerySnapshot>(
      stream: homeTab == homeTabs.trials
        ? repository.getTrialStream()
        : null,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: Container(
              width: 85,
              height: 85,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.grey,
                strokeWidth: 15.0,
              ),
            ),
          );
        }
        else{
          return _buildList(context, snapshot.data.documents, homeTab);
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, homeTabs homeTab) {
    return snapshot.length == 0
      ? Center(child: Text("No Data Found"),)
      : Material(
        child: InkWell(
          child: Container(
            color: Colors.blueGrey[100],
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return _buildGameListItem(context, snapshot.elementAt(index));
              },
            ),
          ),
        ),
      );
  }

   */
}

enum homeTabs {
  games,
  trials,
}
