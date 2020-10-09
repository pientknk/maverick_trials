import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/base/filter_item.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/models/base/trial_filter.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_filter_chip.dart';

class TrialFilterList extends StatefulWidget {
  @override
  _TrialFilterListState createState() => _TrialFilterListState();
}

class _TrialFilterListState extends State<TrialFilterList> {
  List<TrialFilter> trialFilters;

  @override
  void initState() {
    trialFilters = List<TrialFilter>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: trialFilters.isNotEmpty
                ? ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return AppFilterChip(
                      filterItem: trialFilters.elementAt(index).filterItem,
                      onDelete: (){
                        setState(() {
                          trialFilters.removeAt(index);
                        });
                      },
                      onTap: (){
                        showBottomSheet(context: context, builder: (BuildContext innerContext){
                          return Container(
                            height: 350,
                            margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.grey[300], spreadRadius: 5),
                              ],
                            ),
                            child: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Filtering on Trials'),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'fieldName',
                                      hintText: 'select the field name to filter on',
                                      filled: true,
                                    ),
                                  ),
                                  //this should be a DropdownButtonFormField eventually
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'filter type',
                                      hintText: 'select the how you want to filter',
                                      filled: true,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'value',
                                      hintText: 'select the filter value',
                                      filled: true,
                                    ),
                                  ),
                                  AppIconButton(
                                    text: 'Add Filter',
                                    icon: Icon(Icons.add),
                                    onPressed: (){
                                      setState(() {
                                        trialFilters.add(TrialFilter(
                                          filterType: FilterType.Is,
                                          trialField: TrialFields.creatorUserCareerID,
                                          value: 'Nike',
                                        ));
                                      });
                                      Navigator.of(context).pop();
                                      //TODO: add to filter list and dismiss popup
                                    },
                                    color: Theme.of(context).primaryColor,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                        //TODO: edit this filter and update the chip
                      },
                    );
                  }
                )
                : Center(
                  child: Text('No filters'),
                ),
            ),
          ],
        ),
      )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Trial Filters'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 25.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            //TODO: popup to prompt for fields for filter
            //field selector
            //filter type
            //filter value (depends on the type)
            showBottomSheet(context: context, builder: (BuildContext innerContext)
            {
              return Container(
                height: 350,
                margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10, color: Colors.grey[300], spreadRadius: 5),
                  ],
                ),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Filtering on Trials'),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'fieldName',
                          hintText: 'select the field name to filter on',
                          filled: true,
                        ),
                      ),
                      //this should be a DropdownButtonFormField eventually
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'filter type',
                          hintText: 'select the how you want to filter',
                          filled: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'value',
                          hintText: 'select the filter value',
                          filled: true,
                        ),
                      ),
                      AppIconButton(
                        text: 'Add Filter',
                        icon: Icon(Icons.add),
                        color: Theme
                          .of(context)
                          .primaryColor,
                        onPressed: () {
                          setState(() {
                            trialFilters.add(TrialFilter(
                              trialField: TrialFields.creatorUserCareerID,
                              filterType: FilterType.Is,
                              value: 'Nike',
                            ));
                          });
                          Navigator.of(context).pop();
                          //TODO: add to filter list and dismiss popup
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        )
      ],
    );
  }
}
