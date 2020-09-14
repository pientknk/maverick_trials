import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/features/game/list/bloc/game_list.dart';
import 'package:maverick_trials/features/game/ui/game_card.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';

class GameListView extends StatelessWidget {
  GameListView({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context){
        return GameListBloc();
      },
      child: GameListViewBody(),
    );
  }
}

class GameListViewBody extends StatefulWidget {
  @override
  _GameListViewBodyState createState() => _GameListViewBodyState();
}

class _GameListViewBodyState extends State<GameListViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameListBloc, GameListState>(
      bloc: BlocProvider.of<GameListBloc>(context),
      builder: (BuildContext context, GameListState state){
        if(state is LoadingState){
          return _loadingBody(context);
        }

        if(state is DefaultState){
          BlocProvider.of<GameListBloc>(context).add(SearchTextClearedEvent());
        }

        if(state is SearchEmptyState){
          _buildGameList(context, state.games);
        }

        if(state is SearchSuccessState){
          _buildGameList(context, state.games);
        }

        if(state is SearchErrorState){
          return Container(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text('An error occurred while Searching: ${state.error}'),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _loadingBody(BuildContext context){
    return Column(
      children: <Widget>[
        Center(
          child: BasicProgressIndicator(),
        ),
      ],
    );
  }

  Widget _buildGameList(BuildContext context, List<Game> games){
    if(games.isEmpty){
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text('No Games found!'),
        ),
      );
    }

    return GridView.builder(
      itemCount: games.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.75
      ),
      itemBuilder: (BuildContext context, int index){
        return Container(
          child: GameCard(game: games.elementAt(index)),
        );
      }
    );
  }
}

