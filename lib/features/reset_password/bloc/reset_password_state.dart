import 'package:flutter/material.dart';

class ResetPasswordState {
  final bool isSubmitting;
  final bool isSuccess;

  ResetPasswordState({
    @required this.isSubmitting,
    @required this.isSuccess,
  });

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      isSubmitting: false,
      isSuccess: false,
    );
  }

  factory ResetPasswordState.loading() {
    return ResetPasswordState(
      isSubmitting: true,
      isSuccess: false,
    );
  }

  factory ResetPasswordState.success() {
    return ResetPasswordState(
      isSubmitting: false,
      isSuccess: true,
    );
  }

  ResetPasswordState copyWith({
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return ResetPasswordState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  String toString() {
    return '''
      ResetPasswordState { 
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      }
    ''';
  }
}
