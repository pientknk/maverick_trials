import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:flutter/material.dart';

class AppReportMode extends ReportMode {
  @override
  bool isContextRequired() => true;

  @override
  List<PlatformType> getSupportedPlatforms() =>
    [PlatformType.iOS, PlatformType.Android];

  @override
  void requestAction(Report report, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildMaterialDialog(report, context),
    );
  }

  Widget _buildMaterialDialog(Report report, BuildContext context) {
    return AlertDialog(
      title: Text('Oops!'),
      content: Text('An unknown error occurred. Please report this issue so that'
        ' we can start looking into it.'),
      actions: <Widget>[
        FlatButton(
          child: Text('Report'),
          onPressed: () => _onAcceptPressed(report, context),
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => _onCancelPressed(report, context),
        ),
      ],
    );
  }

  void _onAcceptPressed(Report report, BuildContext context){
    super.onActionConfirmed(report);
    Navigator.pop(context);
  }

  void _onCancelPressed(Report report, BuildContext context){
    super.onActionRejected(report);
    Navigator.pop(context);
  }
}