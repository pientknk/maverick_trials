import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RequestNicknameEvent extends Equatable {
  RequestNicknameEvent([List props = const[]]) : super(props);
}

class UpdateNickname extends RequestNicknameEvent {
  final String nickname;

  UpdateNickname({@required this.nickname}) : super([nickname]);

  @override
  String toString() {
    return 'UpdateNickname<$nickname>';
  }
}

class SubmitNickname extends RequestNicknameEvent {
  final String nickname;

  SubmitNickname({@required this.nickname}) : super([nickname]);

  @override
  String toString() {
    return 'SubmitNickname<$nickname>';
  }
}