import 'package:bloc/bloc.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {


  @override
  SettingsState get initialState => SettingsLoadingState();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if(event is UpdateSettingsEvent){
      yield* _mapUpdateSettingsEventToState(event);
    }

    if(event is ResetSettingsEvent) {
      yield* _mapResetSettingsEventToState(event);
    }

    if(event is SaveSettingsEvent) {
      yield* _mapSaveSettingsEventToState(event);
    }
  }

  Stream<SettingsState> _mapUpdateSettingsEventToState(UpdateSettingsEvent event) async* {

  }

  Stream<SettingsState> _mapResetSettingsEventToState(ResetSettingsEvent event) async* {

  }

  Stream<SettingsState> _mapSaveSettingsEventToState(SaveSettingsEvent event) async* {

  }

}