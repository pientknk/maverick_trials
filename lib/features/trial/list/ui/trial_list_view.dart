import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/core/models/sort_item.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/features/trial/list/bloc/trial_list.dart';
import 'package:maverick_trials/features/trial/ui/trial_bottom_sheet.dart';
import 'package:maverick_trials/features/trial/ui/trial_card.dart';
import 'package:maverick_trials/features/trial/ui/trial_filter_list.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';

class TrialListView extends StatelessWidget {
  TrialListView({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrialListBloc>(
      create: (BuildContext context){
        return TrialListBloc();
      },
      child: TrialListViewBody(),
    );
  }
}

class TrialListViewBody extends StatefulWidget {
  @override
  _TrialListViewBodyState createState() => _TrialListViewBodyState();
}

class _TrialListViewBodyState extends State<TrialListViewBody> {
  SortType nameSort = SortType.None;
  final TextEditingController searchController = TextEditingController();
  String currentText = '';
  FaIcon currentNameSort;

  @override
  void initState() {
    currentNameSort = SortItem.sortTypeToIcon(nameSort);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrialListBloc, TrialListState>(
      bloc: BlocProvider.of<TrialListBloc>(context),
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
    );
  }

  Widget _buildLoadingBody(BuildContext context){
    return Column(
      children: <Widget>[
        _buildFilterAndSortArea(context),
        Center(
          child: BasicProgressIndicator(),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context, List<Trial> trials){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildFilterAndSortArea(context),
        Flexible(child: _buildTrialList(context, trials)),
      ],
    );
  }

  Widget _buildFilterAndSortArea(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(5),
      height: 50,
      child: Row(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: TextField(
                  onChanged: (text){
                    setState(() {
                      currentText = searchController.text;
                    });
                  },
                  controller: searchController,
                    decoration: InputDecoration(
                      //contentPadding: const EdgeInsets.all(5),
                      hintText: 'Search for Trials',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: currentText.isEmpty
                        ? null
                        : IconButton(
                            icon: Icon(Icons.clear),
                            color: Colors.red,
                            splashColor: Colors.redAccent,
                            onPressed: _onClearSearchBarTapped,
                          ),
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      filled: true,
                    ),
                  ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RaisedButton(
                  child: Text('Filter'),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context){
                          return TrialFilterList();
                        }
                      )
                    );
                  },
                ),
              )
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RaisedButton(
                  child: Text('Sort'),
                  onPressed: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context){
                        return TrialBottomSheet();
                      },
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.white60,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildTrialList(BuildContext context, List<Trial> trials){
    if(trials.isEmpty){
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text("No Trials found!"),
        ),
      );
    }
    
    return GridView.builder(
      itemCount: trials.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (BuildContext context, int index){
        return Material(
          child: InkWell(
            child: Container(
              //color: Colors.orangeAccent,
              //child: SizedBox(height: 30, width: 40,),
              child: TrialCard(trial: trials.elementAt(index)),
              //child: _buildTrialListTile(context, trials.elementAt(index)),
            ),
          ),
        );
      },
    );
  }

  void _onClearSearchBarTapped(){
    searchController.text = '';
    currentText = searchController.text;
    BlocProvider.of<TrialListBloc>(context).add(SearchTextChangedEvent(''));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

