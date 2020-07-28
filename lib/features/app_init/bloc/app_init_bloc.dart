import 'package:bloc/bloc.dart';
import 'package:maverick_trials/features/app_init/bloc/app_init_event.dart';
import 'package:maverick_trials/features/app_init/bloc/app_init_state.dart';

class ApplicationInitializationBloc extends Bloc<ApplicationInitializationEvent,
    ApplicationInitializationState> {
  @override
  ApplicationInitializationState get initialState =>
      ApplicationInitializationInitialState();

  @override
  Stream<ApplicationInitializationState> mapEventToState(
      ApplicationInitializationEvent event) async* {
    if (event is ApplicationInitializationStartEvent) {
      for (int progress = 0; progress < 101; progress += 10) {
        await Future.delayed(const Duration(
            milliseconds:
                300)); //simulating contacting server or any other setup needed
        yield ApplicationInitializationInitializingState.copyWithProgress(
            progress: progress);
      }
    }

    if (event is ApplicationInitializationStopEvent) {
      yield ApplicationInitializationInitializedState();
    }

    if (event is ApplicationInitializationLoginEvent) {
      yield ApplicationInitializationLoginState();
    }

    if (event is ApplicationInitializationGuestAccountEvent) {
      yield ApplicationInitializationGuestAccountState();
    }

    if (event is ApplicationInitializationSignUpEvent) {
      yield ApplicationInitializationSignUpState();
    }
  }

  @override
  void onTransition(
      Transition<ApplicationInitializationEvent, ApplicationInitializationState>
          transition) {
    print(transition);
    super.onTransition(transition);
  }
}
