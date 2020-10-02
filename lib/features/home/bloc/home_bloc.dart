import 'package:bloc/bloc.dart';
import 'package:maverick_trials/core/models/app_tabs.dart';
import 'package:maverick_trials/features/home/bloc/home_event.dart';

class HomeBloc extends Bloc<HomeEvent, AppTabs> {
  @override
  AppTabs get initialState => AppTabs.play;

  @override
  Stream<AppTabs> mapEventToState(HomeEvent event) async* {
    if(event is HomeEventTabSelected){
      yield event.appTab;
    }
  }
}