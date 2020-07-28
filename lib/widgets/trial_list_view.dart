import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/ui/views/trial_detail_view.dart';

class TrialListView extends StatefulWidget {
  TrialListView({Key key}) : super(key: key);

  @override
  _TrialListViewState createState() => _TrialListViewState();
}

class _TrialListViewState extends State<TrialListView> {
  //TrialViewModel _trialViewModel;

  @override
  void initState() {
    //_trialViewModel = TrialViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Trial>>(
      //stream: _trialViewModel.getTrialsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildList(context, snapshot.data);
        } else {
          return Center(child: Text("No Data Found"));
        }
        /*
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
          return _buildList(context, snapshot.data);
        }*/
      },
    );
  }

  Widget _buildList(BuildContext context, List<Trial> trials) {
    return trials.length == 0
        ? Center(
            child: Text("No Data Found"),
          )
        : Material(
            child: InkWell(
              child: Container(
                color: Colors.blueGrey[100],
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: trials.length,
                  itemBuilder: (context, index) {
                    return _buildTrialListItem(
                        context, trials.elementAt(index));
                  },
                ),
              ),
            ),
          );
  }

  Widget _buildTrialListItem(BuildContext context, Trial trial) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          title: Text(trial.name),
          subtitle: Text(trial.description),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrialDetailView(
                    trial: trial,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
