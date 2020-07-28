import 'package:bloc/bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/device_auth_event.dart';
import 'package:maverick_trials/features/authentication/bloc/device_auth_state.dart';

class DeviceAuthenticationBloc
    extends Bloc<DeviceAuthenticationEvent, DeviceAuthenticationState> {
  @override
  DeviceAuthenticationState get initialState => DeviceNotAuthenticatedState();

  @override
  Stream<DeviceAuthenticationState> mapEventToState(
      DeviceAuthenticationEvent event) async* {
    if (event is DeviceAuthenticationLoginEvent) {
      yield DeviceAuthenticatingState(authType: event.authType);

      //run local_auth package to authorize

      if (event.didAuth) {
        DeviceAuthenticatedState(authType: event.authType);
      } else {
        DeviceAuthenticationFailureState(error: 'Something went wrong');
      }
    }

    if (event is DeviceAuthenticationSetupEvent) {}
  }
}
