import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/features/authentication/bloc/auth.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/features/settings/ui/settings_form.dart';

class SettingsView extends StatefulWidget {
  final Settings settings;

  SettingsView({Key key, @required this.settings}) :
      assert(settings != null),
      super(key: key);

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
      appBar: _buildAppBar(),
      body: BlocProvider<SettingsBloc>(
        create: (BuildContext context){
          return SettingsBloc(
            authBloc: BlocProvider.of<AuthenticationBloc>(context),
            settings: widget.settings,
          );
        },
        child: SettingsForm(),
      ),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title: Text('Settings'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}
