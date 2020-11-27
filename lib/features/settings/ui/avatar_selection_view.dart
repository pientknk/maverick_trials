import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/ui/widgets/app_avatar.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:rxdart/rxdart.dart';

class AvatarSelectionView extends StatefulWidget {
  final SettingsBloc settingsBloc;

  AvatarSelectionView({@required this.settingsBloc}) : assert(settingsBloc != null);

  @override
  _AvatarSelectionViewState createState() => _AvatarSelectionViewState();
}

class _AvatarSelectionViewState extends State<AvatarSelectionView> {
  final BehaviorSubject<String> _avatarController = BehaviorSubject<String>();

  Function(String) get onAvatarChanged => _avatarController.sink.add;

  Stream<String> get avatar => _avatarController.stream;

  @override
  void dispose() {
    _avatarController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Avatar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: AppAvatarStream(
                stream: avatar,
                initialData: widget.settingsBloc.user.photoUrl,
                width: 100,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0),)
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: FutureBuilder<List<String>>(
                  future: _getAvatarImagePaths(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          String path = snapshot.data.elementAt(index);
                          return GestureDetector(
                            onTap: (){
                              onAvatarChanged(path);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(path, fit: BoxFit.contain),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            StreamBuilder<dynamic>(
              stream: avatar,
              builder: (context, snapshot) {
                return AppButton(
                  text: 'Choose',
                  onPressed: (snapshot.hasData)
                    ? () {
                    widget.settingsBloc.onAvatarChanged(_avatarController.stream.value);
                    Navigator.pop(context);
                  }
                    : null,
                );
              },
            ),
          ],
        ),
      ),
      /*
      body: BlocListener<SettingsBloc, SettingsState>(
        bloc: widget.settingsBloc,
        listener: (context, state){
          if(state is SettingsSavingState){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                AppSnackBar(
                  leading: CircularProgressIndicator(),
                  text: 'Saving...',
                  durationInMs: 2000,
                ).build()
              );
          }

          if(state is SettingsFailureState){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                AppSnackBar(
                  leading: Icon(Icons.error),
                  text: state.errorMsg,
                  durationInMs: 3000,
                  appSnackBarType: AppSnackBarType.error,
                ).build()
              );
          }

          if(state is SettingsUpdateSuccessState){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                AppSnackBar(
                  leading: Icon(Icons.check),
                  text: 'Saved Successfully',
                  durationInMs: 2000,
                  appSnackBarType: AppSnackBarType.success,
                ).build()
              );
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: AppAvatarStream(
                  stream: widget.settingsBloc.avatar,
                  initialData: widget.settingsBloc.settings.avatarLink,
                  width: 100,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1.0),)
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: FutureBuilder<List<String>>(
                    future: _getAvatarImagePaths(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index){
                            String path = snapshot.data.elementAt(index);
                            return GestureDetector(
                              onTap: (){
                                widget.settingsBloc.onAvatarChanged(path);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6.0),
                                child: Image.asset(path, fit: BoxFit.contain),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
              Container(
                child: AppButton(
                  text: 'Update',
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),

       */
      );
  }

  Future<List<String>> _getAvatarImagePaths() async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final avatarImagePaths =
        manifestMap.keys.where((key) => key.contains('images/avatars/'));

    return avatarImagePaths.toList();
  }
}
