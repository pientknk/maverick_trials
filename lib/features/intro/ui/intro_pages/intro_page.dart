import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class IntroPage extends StatelessWidget {
  final String header;
  final Widget background;
  final AlignmentGeometry backgroundAlignment;
  final List<String> contentParts;

  IntroPage({Key key, this.header, this.background,
    this.contentParts, this.backgroundAlignment = Alignment.center})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Align(
            alignment: backgroundAlignment,
            child: background,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImportantText(header, fontSize: 32),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildContentParts(),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }

  List<Widget> _buildContentParts(){
    List<Widget> contentsList = List<Widget>();
    contentParts.forEach((content) {
      contentsList.add(Card(
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImportantText(content, fontSize: 16,),
        ),
      ));
    });

    return contentsList;
  }
}
