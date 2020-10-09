import 'package:bloc/bloc.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_game_repository.dart';
import 'package:maverick_trials/features/game/play/bloc/play_event.dart';
import 'package:maverick_trials/features/game/play/bloc/play_state.dart';
import 'package:maverick_trials/locator.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  final FirebaseGameRepository _gameRepository = locator<FirebaseGameRepository>();
  @override
  PlayState get initialState => PlayStateLoading();

  @override
  Stream<PlayState> mapEventToState(PlayEvent event) async* {
    if(event is PlayEventNoGame){
      yield* _mapPlayEventNoGame(event);
    }

    if(event is PlayEventFindGame){
      //TODO: navigate to Games Tab
      yield* _mapPlayEventFindGameToState(event);
    }

    if(event is PlayEventMyGames){
      //TODO: navigate to Games Tab with filter set to current user
      yield* _mapPlayEventMyGamesToState(event);
    }

    if(event is PlayEventPlayingGame){
      //TODO: navigate to playing page? or else update this page to have new tabs
      yield* _mapPlayEventPlayingGameToState(event);
    }
  }

  Stream<PlayState> _mapPlayEventNoGame(PlayEventNoGame event) async* {
    yield PlayStateNotPlaying();
  }

  Stream<PlayState> _mapPlayEventFindGameToState(PlayEventFindGame event) async* {
    yield PlayStateNotPlaying();
  }

  Stream<PlayState> _mapPlayEventMyGamesToState(PlayEventMyGames event) async* {
    yield PlayStateNotPlaying();
  }

  Stream<PlayState> _mapPlayEventPlayingGameToState(PlayEventPlayingGame event) async* {
    yield PlayStateLoading();

    try{
      Game game = await _gameRepository.get(event.gameID);
      yield PlayStateIsPlaying(game);
    }
    catch(error, stacktrace){
      print('Error: ${error.toString()} StackTrace: ${stacktrace.toString()}');
      yield PlayStateError('Oops, looks like an error has occurred. Please retry later.');
    }
  }

}