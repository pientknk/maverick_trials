import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class AppRankIcon extends StatelessWidget {
  final int rank;

  AppRankIcon({Key key, @required this.rank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPolygon(
      sides: 6,
      rotate: 90.0,
      child: CircleAvatar(
        child: Text(rank.toString()),
        radius: 25,
      ),
    );
  }
}

class AppRankIconStream extends StatelessWidget {
  final Stream<int> stream;
  final int initialValue;

  AppRankIconStream({Key key,
    @required this.stream,
    this.initialValue = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      initialData: initialValue,
      builder: (context, snapshot) {
        return ClipPolygon(
          sides: 6,
          rotate: 90.0,
          child: CircleAvatar(
            child: Text(snapshot.data.toString()),
            radius: 25,
          ),
        );
      }
    );
  }
}

