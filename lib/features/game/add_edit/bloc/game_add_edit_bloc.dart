import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/game_repository.dart';
import 'package:maverick_trials/features/authentication/bloc/auth.dart';
import 'package:maverick_trials/features/game/add_edit/bloc/game_add_edit.dart';
import 'package:maverick_trials/locator.dart';
import 'package:rxdart/rxdart.dart';

class GameAddEditBloc extends Bloc<GameAddEditEvent, GameAddEditState> {
  final AuthenticationBloc authBloc;
  final Game game;
  final GameRepository _gameRepository = locator<GameRepository>();
  final List<String> trialBossOptions = [
    'Option 1',
    'Option 2',
  ];

  final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _descriptionController = BehaviorSubject<String>();
  final BehaviorSubject<int> _gameUserCountController = BehaviorSubject<int>();
  final BehaviorSubject<List<String>> _trialListController = BehaviorSubject<List<String>>();
  final BehaviorSubject<String> _trialBossOptionController = BehaviorSubject<String>.seeded('Option 1');

  GameAddEditBloc({@required this.authBloc, this.game})
    : assert(authBloc != null);

  @override
  GameAddEditState get initialState => GameAddEditDefaultState();

  @override
  Future<void> close() {
    _nameController.close();
    _descriptionController.close();
    _gameUserCountController.close();
    _trialListController.close();
    _trialBossOptionController.close();
    return super.close();
  }

  @override
  Stream<GameAddEditState> mapEventToState(GameAddEditEvent event) async* {
    if(event is AddGameEvent){
      yield* _mapAddGameEventToState(event);
    }

    if(event is EditGameEvent){
      yield* _mapEditGameEventToState(event);
    }
  }

  Stream<GameAddEditState> _mapAddGameEventToState(AddGameEvent event) async* {
    yield GameAddEditSavingState();

    try{
      Game game = await createNewGame();
      _gameRepository.addGame(game);
    }
    catch(e){
      yield GameAddEditFailureState(error: e.toString());
    }


  }

  Stream<GameAddEditState> _mapEditGameEventToState(EditGameEvent event) async* {
    yield GameAddEditSavingState();

    Game game = event.game;
    _setGame(game);

    try{
      await _gameRepository.updateGame(game);
    }
    catch(e){
      yield GameAddEditFailureState(error: e.toString());
    }

    yield GameAddEditSuccessState();
  }

  Future<Game> createNewGame() async {
    Game game = Game.newGame();
    _setGame(game);

    User user = await authBloc.userRepository.getCurrentUser();
    game.creatorUserCareerID = user.nickname;
    game.createdTime = DateTime.now();
    game.trialCount = 0;
    game.gameRunCount = 0;
    game.trialIDs = List<String>();

    return game;
  }

  void _setGame(Game game){

  }
}