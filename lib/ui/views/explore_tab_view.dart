import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreTabView extends StatefulWidget {
  ExploreTabView(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  State<StatefulWidget> createState() => _ExploreTabViewState(index);
}

class _ExploreTabViewState extends State<ExploreTabView> {
  int index;

  _ExploreTabViewState(this.index);

  @override
  Widget build(BuildContext context) {
    return Text("Explore Tab with index $index");
  }
}
