import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

///
/// The base avatar icon to display the players chosen avatar.
/// This version uses a stream to change the icon dynamically.
///
class AppAvatarStream extends StatelessWidget {
  final Stream<String> stream;
  final String initialData;
  final double size;
  final double width;

  AppAvatarStream(
      {@required this.stream, @required this.initialData, this.size,
      this.width = 75.0,});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        return SizedBox(
          width: width,
          child: ClipPolygon(
            sides: 6,
            boxShadows: [
              PolygonBoxShadow(color: ThemeColors.greenSheen, elevation: 3.0)
            ],
            rotate: 90.0,
            child: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: snapshot.hasData
                    ? Image.asset(snapshot.data, fit: BoxFit.contain)
                    : Icon(Icons.person),
              ),
              radius: size ?? 35,
            ),
          ),
        );
      },
    );
  }
}

///
/// The base avatar icon to display the players chosen avatar.
///
class AppAvatar extends StatelessWidget {
  final String link;
  final double size;

  AppAvatar({@required this.link, this.size});

  @override
  Widget build(BuildContext context) {
    Widget avatar = link == null
        ? Icon(Icons.person)
        : Image.asset(link, fit: BoxFit.contain);

    return ClipPolygon(
        sides: 6,
        boxShadows: [
          PolygonBoxShadow(color: ThemeColors.greenSheen, elevation: 3.0)
        ],
        rotate: 90.0,
        child: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: avatar,
          ),
          radius: size ?? 35,
        ),
    );
  }
}
