import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ApplicationInitializationState extends Equatable {
  ApplicationInitializationState([List props = const []]) : super(props);
}

class ApplicationInitializationInitialState
    extends ApplicationInitializationState {
  @override
  String toString() {
    return 'ApplicationInitializationInitialState';
  }
}

class ApplicationInitializationNotInitializedState
    extends ApplicationInitializationState {
  final bool isInitialized;
  final bool isInitializing;
  final int progress;

  ApplicationInitializationNotInitializedState(
      {this.isInitialized: false, this.isInitializing: false, this.progress: 0})
      : super([isInitialized, isInitialized, progress]);

  @override
  String toString() {
    return 'ApplicationInitializationNotInitializedState<$isInitialized, $isInitializing, $progress>';
  }
}

class ApplicationInitializationInitializedState
    extends ApplicationInitializationState {
  final bool isInitialized;
  final bool isInitializing;
  final int progress;

  ApplicationInitializationInitializedState(
      {this.isInitialized: true,
      this.isInitializing: false,
      this.progress: 100})
      : super([isInitialized, isInitialized, progress]);

  @override
  String toString() {
    return 'ApplicationInitializationInitializedState<$isInitialized, $isInitializing, $progress>';
  }
}

class ApplicationInitializationInitializingState
    extends ApplicationInitializationState {
  final bool isInitializing;
  final bool isInitialized;
  final int progress;

  ApplicationInitializationInitializingState(
      {this.isInitialized, this.isInitializing, this.progress})
      : super([isInitialized, isInitialized, progress]);

  factory ApplicationInitializationInitializingState.copyWithProgress(
      {@required int progress}) {
    return ApplicationInitializationInitializingState(
      isInitialized: progress == 100,
      isInitializing: true,
      progress: progress,
    );
  }

  @override
  String toString() {
    return 'ApplicationInitializationInitializingState<$isInitialized, $isInitializing, $progress>';
  }
}

class ApplicationInitializationLoginState
    extends ApplicationInitializationState {
  @override
  String toString() {
    return 'ApplicationInitializationLoginState';
  }
}

class ApplicationInitializationGuestAccountState
    extends ApplicationInitializationState {
  @override
  String toString() {
    return 'ApplicationInitializationGuestAccountState';
  }
}

class ApplicationInitializationSignUpState
    extends ApplicationInitializationState {
  @override
  String toString() {
    return 'ApplicationInitializationSignUpState';
  }
}
