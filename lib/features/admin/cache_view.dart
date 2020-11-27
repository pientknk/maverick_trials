import 'package:flutter/material.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';
import 'package:maverick_trials/utils/stringify.dart';

class CacheView extends StatefulWidget {
  final FirestoreAPI dbAPI;

  CacheView({this.dbAPI});

  @override
  _CacheViewState createState() => _CacheViewState();
}

class _CacheViewState extends State<CacheView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _header(),
        _cacheTableView(),
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
      child: Center(child: ImportantText('Cache Usages'.toUpperCase(), fontSize: 25.0,)),
    );
  }

  Widget _cacheTableView(){
    Table table = Table(
      border: TableBorder.all(width: 2.0, color: ThemeColors.greenSheen),
      children: [
        TableRow(
          children: [
            _paddedText(child: Text('Name')),
            _paddedText(child: Text('Size')),
            _paddedText(child: Text('Hits')),
            _paddedText(child: Text('Misses')),
          ],
        )
      ],
    );

    widget.dbAPI.cacheManager.cacheMap.forEach((cacheType, cache) {
      String name = Stringify.enumValueFriendlyString(cacheType.toString());
      table.children.add(TableRow(
        children: [
          _paddedText(child: Text(name, style: TextStyle(fontWeight: FontWeight.bold),)),
          _paddedText(child: Text(cache.cachedList.length.toString(), textAlign: TextAlign.right,)),
          _paddedText(child: Text(cache.cacheHits.toString(), textAlign: TextAlign.right,)),
          _paddedText(child: Text(cache.cacheMisses.toString(), textAlign: TextAlign.right,)),
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
          widget.dbAPI.cacheManager.clearAllCaches();
          setState(() {

          });
        },
      ),
    );
  }
}
