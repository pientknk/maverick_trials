import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/repository/settings/firebase_settings_repository.dart';
import 'package:maverick_trials/features/authentication/bloc/auth.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/locator.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final FirebaseSettingsRepository settingsRepository = locator<FirebaseSettingsRepository>();
  final AuthenticationBloc authBloc;
  final Settings settings;

  final BehaviorSubject<bool> _isDarkModeController = BehaviorSubject<bool>();

  Function(bool) get onDarkModeChanged => _isDarkModeController.sink.add;

  Stream<bool> get darkMode => _isDarkModeController.stream;

  SettingsBloc({@required this.authBloc, @required this.settings})
    : assert(authBloc != null),
      assert(settings != null){
    print('Setting bloc, is dark mode? ${settings.isDarkMode}');
    onDarkModeChanged(settings.isDarkMode);
  }

  @override
  SettingsState get initialState => SettingsLoadingState();

  @override
  Future<void> close() {
    _isDarkModeController.close();
    return super.close();
  }

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
    switch(event.settingsField){
      case SettingsFields.isDarkMode:
        yield SettingsUpdateState(event.settingsField, event.value);
        break;
      default:
        print('_mapUpdateSettingsEventToState doesnt handle settings field: ${event.settingsField}');
    }
  }

  Stream<SettingsState> _mapResetSettingsEventToState(ResetSettingsEvent event) async* {

  }

  Stream<SettingsState> _mapSaveSettingsEventToState(SaveSettingsEvent event) async* {

  }

}