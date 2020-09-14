import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/connectivity/bloc/connectivity.dart';

class ConnectivityWidget extends StatelessWidget {
  final Widget widget;

  ConnectivityWidget(Key key, {
    this.widget
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: BlocProvider.of<ConnectivityBloc>(context).connectivityResult,
      builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot){
        return Stack(
          children: <Widget>[
            Positioned(
              child: widget,
            ),
            (snapshot.hasData)
              ? Positioned(
                  child: Container(
                    color: Colors.red,
                    child: connectivityStatusWidget(snapshot.data),
                  ),
                )
              : Container(),
          ],
        );
      },
    );
  }

  Widget connectivityStatusWidget(ConnectivityResult result){
    Color color;
    IconData icon;
    switch(result){
      case ConnectivityResult.wifi:
        color = Colors.green;
        icon = Icons.wifi;
        break;
      case ConnectivityResult.mobile:
        color = Colors.greenAccent;
        icon = Icons.signal_cellular_4_bar;
        break;
      case ConnectivityResult.none:
      default:
        color = Colors.red;
        icon = Icons.cloud_off;
        break;
    }

    return Positioned(
      top: 0,
      right: 0,
      height: 25,
      child: Container(
        color: color,
        child: Icon(icon,),
      ),
    );
  }
}
