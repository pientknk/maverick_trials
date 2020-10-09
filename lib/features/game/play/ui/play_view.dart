import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/game/play/bloc/play.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class PlayView extends StatefulWidget {
  @override
  _PlayViewState createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<PlayBloc>(
      create: (BuildContext context){
        return PlayBloc()..add(PlayEventNoGame());
      },
      child: BlocBuilder<PlayBloc, PlayState>(
        builder: (BuildContext context, PlayState state){
          print('PLay State: $state');
          if(state is PlayStateError){
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(state.error),
                  ),
                ),
              ],
            );
          }

          if(state is PlayStateLoading){
            return Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }

          if(state is PlayStateNotPlaying){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: ImportantText("Looks like you don't have a "
                                "game running. Get started by finding a game "
                                "and playing!"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: AppButton(
                              onPressed: () {
                                //navigate to Home tab with filter set to games
                              },
                              text: 'Find Games',
                            ),
                          ),
                          Flexible(
                            child: AppButton(
                              onPressed: () {
                                //navigate to Home tab with filter set to games
                              },
                              text: 'My Games'
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if(state is PlayStateIsPlaying){
            //TODO: make this a new screen?
            return ListView(
              children: [
                Row(
                  children: [
                    Text("Tab 1"),
                    Text("Tab 2"),
                    Text("Tab 3"),
                  ],
                ),
                Expanded(
                  child: Text(state.game.toString()),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}