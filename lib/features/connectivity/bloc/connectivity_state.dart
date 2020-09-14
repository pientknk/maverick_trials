import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable{
  ConnectivityState([List props = const []]) : super(props);
}

class ConnectionMobileState extends ConnectivityState {
  @override
  String toString() {
    return 'ConnectionMobileState';
  }
}

class ConnectionWifiState extends ConnectivityState {
  @override
  String toString() {
    return 'ConnectionWifiState';
  }
}

class ConnectionOfflineState extends ConnectivityState {
  @override
  String toString() {
    return 'ConnectionOfflineState';
  }
}