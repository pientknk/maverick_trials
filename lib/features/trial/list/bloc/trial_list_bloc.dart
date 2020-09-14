import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/filter_item.dart';
import 'package:maverick_trials/core/models/sort_item.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/trial_repository.dart';
import 'package:maverick_trials/features/trial/list/bloc/trial_list.dart';
import 'package:maverick_trials/locator.dart';

class TrialListBloc extends Bloc<TrialListEvent, TrialListState>{
  final TrialRepository trialRepository = locator<TrialRepository>();

  List<FilterItem> filterItems = List();
  List<SortItem> sortItems = List();

  @override
  TrialListState get initialState => DefaultState();

  @override
  Stream<TrialListState> mapEventToState(TrialListEvent event) async* {
    if(event is SearchTextChangedEvent){
      yield* _mapSearchTextChangedEventToState(event);
    }

    if(event is SearchTextClearedEvent){
      yield* _mapSearchTextClearedEventToState(event);
    }

    if(event is FilterAddedEvent){
      yield* _mapFilterAddedEventToState(event);
    }

    if(event is FilterRemovedEvent){
      yield* _mapFilterRemovedEventToState(event);
    }

    if(event is SortAddedEvent){
      yield* _mapSortAddedEventToState(event);
    }

    if(event is SortRemovedEvent){
      yield* _mapSortRemovedEventToState(event);
    }
  }

  Stream<TrialListState> _mapSearchTextChangedEventToState(SearchTextChangedEvent event) async* {
    yield LoadingState();

    try{
      if(event.searchText.isEmpty){
        List<Trial> results = await trialRepository.getTrials();
        yield SearchEmptyState(results);
      }
      else{
        //TODO: this will need to filter the results based off the search
        List<Trial> results = await trialRepository.getTrials();
        yield SearchSuccessState(results);
      }
    }
    catch(error){
      yield SearchErrorState(error.toString());
    }
  }

  Stream<TrialListState> _mapSearchTextClearedEventToState(SearchTextClearedEvent event) async* {
    yield LoadingState();

    try{
      final List<Trial> results = await trialRepository.getTrials();
      yield SearchEmptyState(results);
    }
    catch(error){
      yield SearchErrorState(error.toString());
    }
  }

  Stream<TrialListState> _mapFilterAddedEventToState(FilterAddedEvent event) async* {
    yield LoadingState();

    try{
      filterItems.add(event.filterItem);
      final results = await trialRepository.getTrialsByFilterAndSort(
        filterItems: filterItems,
        sortItems: sortItems,
      );
      yield FilterSuccessState(results, filterItems, sortItems);
    }
    catch(error){
      yield FilterErrorState(error.toString());
    }
  }

  Stream<TrialListState> _mapFilterRemovedEventToState(FilterRemovedEvent event) async* {
    yield LoadingState();

    try{
      filterItems.remove(event.filterItem);
      final results = await trialRepository.getTrialsByFilterAndSort(
        filterItems: filterItems,
        sortItems: sortItems,
      );
      yield FilterSuccessState(results, filterItems, sortItems);
    }
    catch(error){
      yield FilterErrorState(error.toString());
    }
  }

  Stream<TrialListState> _mapSortAddedEventToState(SortAddedEvent event) async* {
    yield LoadingState();

    try{
      sortItems.add(event.sortItem);
      final results = await trialRepository.getTrialsByFilterAndSort(
        filterItems: filterItems,
        sortItems: sortItems,
      );
      yield SortSuccessState(results, filterItems, sortItems);
    }
    catch(error){
      yield SortErrorState(error.toString());
    }
  }

  Stream<TrialListState> _mapSortRemovedEventToState(SortRemovedEvent event) async* {
    yield LoadingState();

    try{
      sortItems.remove(event.sortItem);
      final results = await trialRepository.getTrialsByFilterAndSort(
        filterItems: filterItems,
        sortItems: sortItems,
      );
      yield SortSuccessState(results, filterItems, sortItems);
    }
    catch(error){
      yield SortErrorState(error.toString());
    }
  }
}