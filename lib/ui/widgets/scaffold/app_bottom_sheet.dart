import 'package:flutter/material.dart';

class AppBottomSheet extends StatefulWidget {
  AppBottomSheet({this.listItems, Key key})
      : assert(listItems != null),
        super(key: key);

  final List<Widget> listItems;

  @override
  State<StatefulWidget> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.listItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.only(top: index == 0 ? 30.0 : 0.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: Colors.green[300],
            child: widget.listItems[index],
          );
        },
      ),
    );
  }

/*[
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Enter your reference number',
                    ),
                  ),
                ),
                MaterialButton(
                  color: Colors.grey[800],
                  onPressed: () {

                  },
                  child: Text(
                    'Check Flight',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]*/

}
