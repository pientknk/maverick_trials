import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maverick_trials/core/exceptions/firestore_exception_handler.dart';
import 'package:maverick_trials/core/models/settings.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_settings_repository.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/locator.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Settings settings = Settings();
  final FirebaseSettingsRepository settingsRepository = locator<FirebaseSettingsRepository>();
  final FirebaseUserRepository userRepository = locator<FirebaseUserRepository>();

  final BehaviorSubject<bool> _isDarkModeController = BehaviorSubject<bool>();
  BehaviorSubject<String> _avatarController = BehaviorSubject<String>();

  Function(bool) get onDarkModeChanged => _isDarkModeController.sink.add;
  Function(String) get onAvatarChanged => _avatarController.sink.add;

  Stream<bool> get darkMode => _isDarkModeController.stream;
  Stream<String> get avatar => _avatarController.stream;

  @override
  SettingsState get initialState => SettingsLoadingState();

  @override
  Future<void> close() {
    _isDarkModeController.close();
    _avatarController.close();
    return super.close();
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if(event is SettingsEventInitialize){
      yield* _mapSettingsEventInitializeToState(event);
    }

    if(event is SettingsEventSave){
      yield* _mapSettingsEventSaveToState(event);
    }

    if(event is UpdateSettingsEvent){
      yield* _mapUpdateSettingsEventToState(event);
    }

    if(event is ResetSettingsEvent) {
      yield* _mapResetSettingsEventToState(event);
    }
  }

  Stream<SettingsState> _mapSettingsEventInitializeToState(SettingsEventInitialize event) async* {
    try{
      FirebaseUser user = await userRepository.getAuthUser();
      settings = await settingsRepository.get(user.uid);
      yield SettingsStateReady();
    }
    catch(error){
      String errorMsg = FirestoreExceptionHandler.tryGetMessage(error);
      print(errorMsg);
      yield SettingsFailureState(errorMsg);
    }
  }

  Stream<SettingsState> _mapSettingsEventSaveToState(SettingsEventSave event) async* {
    try{
      _setSettings(settings);
      await settingsRepository.update(settings);

      print('saved Settings: ${settings.toString()}');
      yield SettingsStateReady();
    }
    catch(error, stacktrace){
      print(stacktrace.toString());
      yield SettingsFailureState(FirestoreExceptionHandler.tryGetMessage(error));
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
    onDarkModeChanged(settings.isDarkMode);
    onAvatarChanged(settings.avatarLink);

    yield SettingsStateReady();
  }

  void _setSettings(Settings settings){
    print('Set Settings: avatar: ${_avatarController.stream.value}');
    settings.avatarLink = _avatarController.stream.value ?? settings.avatarLink;
    settings.isDarkMode = _isDarkModeController.stream.value ?? settings.isDarkMode;
  }
}