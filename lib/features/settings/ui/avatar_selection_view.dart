import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

//TODO: eventually build this into a bloc so that it does not rebuild
// the entire thing with all avatars every time you select one
// or find another way to do it like returning to the previous screen right away
class AvatarSelectionView extends StatefulWidget {
  final Settings settings;

  AvatarSelectionView({@required this.settings}) : assert(settings != null);

  @override
  _AvatarSelectionViewState createState() => _AvatarSelectionViewState();
}

class _AvatarSelectionViewState extends State<AvatarSelectionView> {
  String chosenImage;

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
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0),)
              ),
              child: CircleAvatar(
                child: chosenImage == null
                  ? Icon(Icons.person)
                  : Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(chosenImage, fit: BoxFit.contain),
                  ),
                radius: 40,
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
                              setState(() {
                                chosenImage = path;
                                widget.settings.avatarLink = path;
                              });
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
                text: ImportantText(text: 'SAVE',),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> _getAvatarImagePaths() async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final avatarImagePaths =
        manifestMap.keys.where((key) => key.contains('images/avatars/'));
    print(avatarImagePaths.toList());

    return avatarImagePaths.toList();
  }
}
