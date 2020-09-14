import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  ConnectivityEvent([List props = const[]]) : super(props);
}

class ConnectivityInitialEvent extends ConnectivityEvent {
  @override
  String toString() {
    return 'ConnectivityInitialEvent';
  }
}

class ConnectivityFailureEvent extends ConnectivityEvent {
  @override
  String toString() {
    return 'ConnectivityFailureEvent';
  }
}

class ConnectivitySuccessEvent extends ConnectivityEvent {
  @override
  String toString() {
    return 'ConnectivitySuccessEvent';
  }
}

class ConnectivityChangedEvent extends ConnectivityEvent {
  @override
  String toString() {
    return 'ConnectivityChangedEvent';
  }
}