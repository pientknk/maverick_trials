import 'package:equatable/equatable.dart';

abstract class ApplicationInitializationEvent extends Equatable {
  ApplicationInitializationEvent([List props = const []]) : super(props);
}

class ApplicationInitializationStartEvent
    extends ApplicationInitializationEvent {
  @override
  String toString() {
    return 'ApplicationInitializationStartEvent';
  }
}

class ApplicationInitializationStopEvent
    extends ApplicationInitializationEvent {
  @override
  String toString() {
    return 'ApplicationInitializationStopEvent';
  }
}

class ApplicationInitializationLoginEvent
    extends ApplicationInitializationEvent {
  @override
  String toString() {
    return 'ApplicationInitializationLoginEvent';
  }
}

class ApplicationInitializationGuestAccountEvent
    extends ApplicationInitializationEvent {
  @override
  String toString() {
    return 'ApplicationInitializationGuestAccountEvent';
  }
}

class ApplicationInitializationSignUpEvent
    extends ApplicationInitializationEvent {
  @override
  String toString() {
    return 'ApplicationInitializationSignUpEvent';
  }
}
