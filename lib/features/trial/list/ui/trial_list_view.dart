import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/features/trial/list/bloc/trial_list.dart';
import 'package:maverick_trials/features/trial/ui/trial_card.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class TrialListView extends StatefulWidget {
  @override
  _TrialListViewState createState() => _TrialListViewState();
}

class _TrialListViewState extends State<TrialListView> with AutomaticKeepAliveClientMixin {
  bool isListMode = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<TrialListBloc>(
      create: (BuildContext context){
        return TrialListBloc();
      },
      child: BlocBuilder<TrialListBloc, TrialListState>(
        builder: (BuildContext context, TrialListState state){
          if(state is LoadingState){
            print('Loading State');
            return _buildLoadingBody(context);
          }

          if(state is DefaultState){
            print('default State');
            BlocProvider.of<TrialListBloc>(context).add(SearchTextClearedEvent());
          }

          if(state is SearchEmptyState){
            print('Search Empty State with ${state.trials.length} records');
            return _buildBody(context, state.trials);
          }

          if(state is SearchSuccessState){
            return _buildBody(context, state.trials);
          }

          if(state is SearchErrorState){
            return Center(
              child: Text('Error when searching: ${state.error}'),
            );
          }

          if(state is FilterSuccessState){
            return _buildBody(context, state.trials);
          }

          if(state is FilterErrorState){
            return Center(
              child: Text('Error when filtering: ${state.error}'),
            );
          }

          if(state is SortSuccessState){
            return _buildBody(context, state.trials);
          }

          if(state is SortErrorState){
            return Center(
              child: Text('Error when sorting: ${state.error}'),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildLoadingBody(BuildContext context){
    return ListView(
      children: <Widget>[
        //_buildFilterAndSortArea(context),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context, List<Trial> trials){


    return _buildTrialView(context, trials);
    //return _buildTrialList2(context, trials);

    /*
    return ListView(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //_buildFilterAndSortArea(context),
            Flexible(child: _buildTrialList(context, trials)),
          ],
        ),
      ],
    );

     */
  }

  Widget _buildTrialView(BuildContext context, List<Trial> trials){
    return Stack(
      children: [
        isListMode
          ? _buildListView(context, trials)
          : _buildGridView(context, trials),
        Positioned(
          bottom: 6.0,
          left: 6.0,
          child: SizedBox(
            width: 100,
            child: AppButton(
              onPressed: (){
                setState(() {
                  isListMode = !isListMode;
                });
              },
              text: Text(isListMode ? 'List' : 'Grid'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(BuildContext context, List<Trial> trials){
    if(trials.isEmpty){
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text("No Trials found!"),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: RefreshIndicator(
        onRefresh: (){
          BlocProvider.of<TrialListBloc>(context).add(TrialListRefreshEvent());
          return Future.delayed(Duration(milliseconds: 250));
        },
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: trials.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (BuildContext context, int index){

              return TrialCard(trial: trials.elementAt(index));
          },
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<Trial> trials){
    if(trials.isEmpty){
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text("No Trials found!"),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: RefreshIndicator(
        onRefresh: (){
          BlocProvider.of<TrialListBloc>(context).add(TrialListRefreshEvent());
          return Future.delayed(Duration(milliseconds: 250));
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: trials.length,
          itemBuilder: (BuildContext context, int index){
              return _buildListTileForTrial(trials.elementAt(index));
          },
        ),
      ),
    );
  }

  Widget _buildListTileForTrial(Trial trial){
    return Card(
      child: ListTile(
        title: ImportantText(text: trial.name),
        subtitle: Text('Rating: 3.5 | Fairness: 4.6 | Likes: 3 526'),
        trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: (){

          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}