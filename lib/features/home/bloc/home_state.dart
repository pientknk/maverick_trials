import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{
  HomeState([List props = const[]]) : super(props);
}

class HomeStateInitial extends HomeState {
  final int index;

  HomeStateInitial({this.index}) : super([index]);

  @override
  String toString() {
    return 'HomeStateInitial<$index>';
  }
}

class HomeStateTabSelected extends HomeState {
  final int index;

  HomeStateTabSelected({this.index}) : super([index]);

  @override
  String toString() {
    return 'HomeStateTabSelected<$index';
  }
}