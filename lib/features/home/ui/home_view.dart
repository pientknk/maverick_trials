import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/base/app_tabs.dart';
import 'package:maverick_trials/features/game/list/ui/game_list_view.dart';
import 'package:maverick_trials/features/game/play/ui/play_view.dart';
import 'package:maverick_trials/features/home/bloc/home.dart';
import 'package:maverick_trials/features/settings/bloc/settings.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_view.dart';
import 'package:maverick_trials/features/trial/list/ui/trial_list_view.dart';
import 'package:maverick_trials/ui/widgets/scaffold/app_bottom_nav_bar.dart';
import 'package:maverick_trials/features/app_drawer/ui/app_drawer.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context){
              return HomeBloc();
            },
          ),
          BlocProvider<SettingsBloc>(
            create: (context){
              return SettingsBloc()..add(SettingsEventInitialize());
            },
          )
        ],
        child: BlocBuilder<HomeBloc, AppTabs>(
          builder: (BuildContext context, AppTabs activeTab) {
            //TODO: look into CustomScrollView with SliverAppBar to add animation
            // and remove appbar when scrolling up - unless the search bar gets
            // put onto the app bar
              return SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.lerp(Alignment.bottomLeft, Alignment.centerLeft, 0.5),
                      end: Alignment.lerp(Alignment.topRight, Alignment.centerRight, 0.5),
                      stops: [0.2, 0.45, 0.65, 0.8, .9],
                      colors: [
                        Colors.black,
                        Colors.grey[900],
                        Colors.grey[850],
                        Colors.grey[800],
                        Colors.grey[700],
                      ]
                    ),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      leading: Builder(
                        builder: (context){
                          return IconButton(
                            icon: Icon(Icons.menu, size: 30),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          );
                        },
                      ),
                    ),
                    drawer: AppDrawer(BlocProvider.of<SettingsBloc>(context)),
                    body: _getBody(activeTab),
                    floatingActionButton: _getFab(activeTab),
                    bottomNavigationBar: AppBottomNavigationBar(
                      activeTab: activeTab,
                      onTabSelected: (tab) => BlocProvider.of<HomeBloc>(context)
                        .add(HomeEventTabSelected(appTab: tab))),
                  ),
                ),
              );
            },
        ),
      );
  }

  Widget _getFab(AppTabs appTab) {
    Widget fab;
    switch (appTab) {
      case AppTabs.games:
        fab = FloatingActionButton(
          onPressed: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                  //builder: (context) => GameAddView(),
                )
              );

               */
          },
          tooltip: 'Add Game',
          child: Icon(Icons.add),
        );
        break;
      case AppTabs.trials:
        fab =  FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrialAddEditView(),
              ));
          },
          tooltip: 'Add Trial',
          child: Icon(Icons.add),
        );
        break;
      default:
        fab = null;
        break;
    }

    if(fab == null){
      return null;
    }
    else{
      return Container(
        width: 65,
        height: 65,
        child: FittedBox(
          child: fab,
        ),
      );
    }
  }

  Widget _getBody(AppTabs appTab) {
    int newIndex = 0;
    switch (appTab) {
      case AppTabs.play:
        newIndex = 1;
        break;
      case AppTabs.games:
        newIndex = 2;
        break;
      case AppTabs.trials:
      default:
        newIndex = 0;
        break;
    }

    return IndexedStack(
      index: newIndex,
      children: [
        TrialListView(),
        PlayView(),
        GameListView(),
      ],
    );
  }
}