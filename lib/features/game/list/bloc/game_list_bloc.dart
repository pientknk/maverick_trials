import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/repository/game/firebase_game_repository.dart';
import 'package:maverick_trials/features/game/list/bloc/game_list_event.dart';
import 'package:maverick_trials/features/game/list/bloc/game_list_state.dart';
import 'package:maverick_trials/locator.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  final FirebaseGameRepository gameRepository = locator<FirebaseGameRepository>();

  @override
  GameListState get initialState => DefaultState();

  @override
  Stream<GameListState> mapEventToState(GameListEvent event) async* {
    if(event is SearchTextChangedEvent){
      yield* _mapSearchTextChangedEventToState(event);
    }

    if(event is SearchTextClearedEvent){
      yield* _mapSearchTextClearedEventToState(event);
    }
  }

  Stream<GameListState> _mapSearchTextChangedEventToState(SearchTextChangedEvent event) async* {
    yield LoadingState();

    try{
      if(event.searchText.isEmpty){
        List<Game> results = await gameRepository.getGames();

        yield SearchEmptyState(results);
      }
      else{
        //TODO: this will need to filter the results based off the search eventually
        List<Game> results = await gameRepository.getGames();
        yield SearchSuccessState(results);
      }
    }
    catch(error){
      yield SearchErrorState(error);
    }
  }

  Stream<GameListState> _mapSearchTextClearedEventToState(SearchTextClearedEvent event) async* {
    yield LoadingState();

    try{
      List<Game> results = await gameRepository.getGames();

      yield SearchEmptyState(results);
    }
    catch(error){
      yield SearchEmptyState(error);
    }
  }
}