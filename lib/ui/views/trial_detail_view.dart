import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/ui/shared/app_bottom_sheet.dart';
import 'package:maverick_trials/widgets/delete_alert_dialog.dart';

class TrialDetailView extends StatefulWidget {
  TrialDetailView({Key key, this.trial})
      : assert(trial != null),
        super(key: key);

  final Trial trial;

  @override
  State<StatefulWidget> createState() => _TrialDetailViewState();
}

class _TrialDetailViewState extends State<TrialDetailView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isEditable = false;
  Trial trial;

  @override
  void initState() {
    trial = widget.trial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: _buildDetails(context),
      ),
    );
  }

  List<Widget> _getMoreOptionsList(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.edit),
        title: Text('Edit Trial'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.delete_forever),
        title: Text('Delete Trial'),
        onTap: () {
          showDialog(
                  barrierDismissible: false,
                  builder: (innerContext) {
                    return DeleteAlertDialog(
                      title: "Delete Trial",
                      details: "Are you sure you want to delete this? "
                          "There is no undo and this trial will be removed from "
                          "any games that reference it.",
                      onDelete: () {
                        //TODO: use router.dart and also new api to delete
                        //repository.deleteTrial(trial);
                        Navigator.of(innerContext).pop();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  context: context)
              .then((value) {
            Navigator.pop(_scaffoldKey.currentContext);
            //might have to navigate back to trial list
          });
        },
      ),
      ListTile(
        leading: Icon(Icons.refresh),
        title: Text('Something Trial'),
        onTap: () {},
      ),
      Container(
        color: Colors.transparent,
        child: ListTile(
          title: Center(child: Text("CANCEL")),
          onTap: () {
            Navigator.pop(_scaffoldKey.currentContext);
          },
        ),
      ),
    ];
  }

  Widget _buildDetails(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              enabled: isEditable,
              initialValue: trial.name,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              enabled: isEditable,
              initialValue: trial.description,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Trial Type',
              ),
              enabled: isEditable,
              initialValue: trial.trialType,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Rules',
              ),
              enabled: isEditable,
              initialValue: trial.rules,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Win Condition',
              ),
              enabled: isEditable,
              initialValue: trial.winCondition,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tiebreaker',
              ),
              enabled: isEditable,
              initialValue: trial.tieBreaker,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Requirements',
              ),
              enabled: isEditable,
              initialValue: trial.requirements,
            ),
            Column(
              children: <Widget>[
                Material(
                  color: Colors.green[100],
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: InkWell(
                      onTap: () {
                        //TODO: navigate to Trial Runs with this trialID?
                      },
                      child: ListTile(
                        leading: Icon(Icons.text_fields),
                        title: Row(
                          children: <Widget>[
                            Expanded(child: Text('Trial Runs')),
                            Chip(
                              backgroundColor: Colors.green,
                              label: Text(trial.trialRunCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  )),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Divider(
                color: Colors.black,
                height: 1.0,
              ),
            ),
            Column(
              children: <Widget>[
                Material(
                  color: Colors.green[100],
                  child: InkWell(
                    onTap: () {
                      //TODO: navigate to Trial Runs with this trialID?
                    },
                    child: ListTile(
                      leading: Icon(Icons.games),
                      title: Row(
                        children: <Widget>[
                          Expanded(child: Text('Games')),
                          Chip(
                            backgroundColor: Colors.green,
                            label: Text(trial.gameCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                )),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Trial Details'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 25.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.more_vert,
            size: 25.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          onPressed: () {
            showModalBottomSheet(
              context: _scaffoldKey.currentContext,
              builder: (builder) {
                //TODO: use an action sheet instead?
                //like from the example here https://material.io/components/dialogs#usage
                return AppBottomSheet(
                  listItems: _getMoreOptionsList(context).reversed.toList(),
                );
              },
              backgroundColor: Colors.transparent,
            );
          },
        )
      ],
    );
  }
}
