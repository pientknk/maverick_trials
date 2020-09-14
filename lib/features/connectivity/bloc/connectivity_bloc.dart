import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:maverick_trials/features/connectivity/bloc/connectivity_event.dart';
import 'package:maverick_trials/features/connectivity/bloc/connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState>{
  Stream<ConnectivityResult> get connectivityResult => Connectivity().onConnectivityChanged;

  @override
  // TODO: implement initialState
  ConnectivityState get initialState => throw UnimplementedError();

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}