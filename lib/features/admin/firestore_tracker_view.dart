import 'package:flutter/material.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';

class FirestoreTrackerView extends StatefulWidget {
  final FirestoreAPI dbAPI;

  FirestoreTrackerView({this.dbAPI});

  @override
  _FirestoreTrackerViewState createState() => _FirestoreTrackerViewState();
}

class _FirestoreTrackerViewState extends State<FirestoreTrackerView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _header(),
        _firestoreTrackerTableView(),
        _resetButton(),
      ],
    );
  }

  Widget _paddedText({Widget child}){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: child,
    );
  }

  Widget _header(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(child: ImportantText('Data Usages'.toUpperCase(), fontSize: 25.0,)),
    );
  }

  Widget _firestoreTrackerTableView(){
    Table table = Table(
      border: TableBorder.all(width: 2.0, color: ThemeColors.greenSheen),
      children: [
        TableRow(
          children: [
            _paddedText(child: Text('Name')),
            _paddedText(child: Text('Creates')),
            _paddedText(child: Text('Reads')),
            _paddedText(child: Text('Updates')),
            _paddedText(child: Text('Deletes')),
          ]
        ),
      ],
    );

    widget.dbAPI.firestoreTracker.collectionDataMap.forEach((key, value) {
      table.children.add(TableRow(
        children: [
          _paddedText(child: Text(key, style: TextStyle(fontWeight: FontWeight.bold),)),
          _paddedText(child: Text(value.creates.toString(), textAlign: TextAlign.right,)),
          _paddedText(child: Text(value.reads.toString(), textAlign: TextAlign.right,)),
          _paddedText(child: Text(value.updates.toString(), textAlign: TextAlign.right,)),
          _paddedText(child: Text(value.deletes.toString(), textAlign: TextAlign.right,)),
        ],
      ));
    });

    return table;
  }

  Widget _resetButton(){
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: AppButton(text: 'Clear Data',
        onPressed: (){
          widget.dbAPI.firestoreTracker.resetTracker();
          setState(() {

          });
        },
      ),
    );
  }
}
