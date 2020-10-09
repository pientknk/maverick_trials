import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/features/settings/bloc/settings_bloc.dart';
import 'package:maverick_trials/features/settings/ui/settings_form.dart';

class SettingsView extends StatefulWidget {
  final SettingsBloc settingsBloc;

  SettingsView({Key key, @required this.settingsBloc}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SettingsForm(settingsBloc: widget.settingsBloc,),
    );
  }
}
