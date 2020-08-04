import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_view.dart';
import 'package:maverick_trials/ui/shared/app_drawer.dart';
import 'package:maverick_trials/ui/shared/app_fab.dart';
import 'package:maverick_trials/ui/views/explore_tab_view.dart';
import 'package:maverick_trials/ui/views/home_tab_view.dart';
import 'package:maverick_trials/ui/views/play_tab_view.dart';
import 'package:maverick_trials/ui/views/trial_add_view.dart';

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold>
    with TickerProviderStateMixin {
  bool hasActiveGame = false;
  TabController _homeTabController;
  TabController _playTabController;
  TabController _exploreTabController;
  int _selectedBottomNavigationIndex = 0;
  List<int> _selectedTabBarIndexes = [
    0,
    0,
    0,
  ];
  List<AppBar> _appBars;
  List<List<PageStorage>> _pageStorages;
  List<AppFab> _appFabs;
  AuthenticationBloc authBloc;

  final PageStorageBucket _storageBucket = PageStorageBucket();

  @override
  void initState() {
    _homeTabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _playTabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _exploreTabController =
        TabController(initialIndex: 0, length: 2, vsync: this);

    _appBars = getAppBars();
    _pageStorages = getPageStorages();
    _appFabs = getAppFabs();

    authBloc = BlocProvider.of<AuthenticationBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottomNavigationBar() {
      return BottomNavigationBar(
          onTap: _onBottomNavigationTapped,
          currentIndex: _selectedBottomNavigationIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('HOME'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              title: Text('PLAY'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text('EXPLORE'),
            ),
          ]);
    }

    return Scaffold(
      appBar: _appBars[_selectedBottomNavigationIndex],
      drawer: AppDrawer(userRepository: authBloc.userRepository),
      body: _pageStorages[_selectedBottomNavigationIndex]
          [_selectedTabBarIndexes[_selectedBottomNavigationIndex]],
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: _appFabs[_selectedBottomNavigationIndex],
      resizeToAvoidBottomInset: false,
    );
  }

  List<AppFab> getAppFabs() {
    return [
      AppFab(
        fabs: <FloatingActionButton>[
          FloatingActionButton(
            heroTag: 'HomeTrialAdd',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrialAddEditView(trial: null),
                )
              );
            },
            tooltip: 'Add Trial',
            child: Stack(
              children: <Widget>[
                Icon(Icons.text_fields),
                Positioned(
                  bottom: 3.0,
                  left: 3.0,
                  child: Icon(
                    Icons.add,
                    size: 10.0,
                  ),
                )
              ],
            ),
          ),
          FloatingActionButton(
            heroTag: 'HomeGameAdd',
            onPressed: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameAddView(),
                )
              );

               */
            },
            tooltip: 'Game Trial',
            child: Stack(
              children: <Widget>[
                Icon(Icons.games),
                Positioned(
                  bottom: 3.0,
                  left: 3.0,
                  child: Icon(
                    Icons.add,
                    size: 10.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      AppFab(
        fabs: <FloatingActionButton>[
          FloatingActionButton(
            onPressed: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  //builder: (context) => GameAddView(),
                )
              );

               */
            },
            tooltip: 'Start Game',
            child: Icon(Icons.videogame_asset),
          ),
          FloatingActionButton(
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
            child: Stack(
              children: <Widget>[
                Icon(Icons.games),
                Positioned(
                  bottom: 3.0,
                  left: 3.0,
                  child: Icon(
                    Icons.add,
                    size: 10.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      AppFab(
        fabs: <FloatingActionButton>[
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrialAddView(),
                  ));
            },
            tooltip: 'Add Trial',
            child: Stack(
              children: <Widget>[
                Icon(Icons.text_fields),
                Positioned(
                  bottom: 3.0,
                  left: 3.0,
                  child: Icon(
                    Icons.add,
                    size: 10.0,
                  ),
                )
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  //builder: (context) => GameAddView(),
                )
              );

               */
            },
            tooltip: 'Game Trial',
            child: Stack(
              children: <Widget>[
                Icon(Icons.games),
                Positioned(
                  bottom: 3.0,
                  left: 3.0,
                  child: Icon(
                    Icons.add,
                    size: 10.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ];
  }

  List<List<PageStorage>> getPageStorages() {
    return [
      //home
      [
        PageStorage(
          bucket: _storageBucket,
          child: HomeTabView(
            0,
            key: PageStorageKey('hometabtrials'),
          ),
        ),
        PageStorage(
          bucket: _storageBucket,
          child: HomeTabView(
            1,
            key: PageStorageKey('hometabgames'),
          ),
        ),
      ],
      //play
      [
        PageStorage(
          bucket: _storageBucket,
          child: PlayTabView(
            0,
            hasActiveGame,
            key: PageStorageKey('playtabtrial'),
          ),
        ),
        PageStorage(
          bucket: _storageBucket,
          child: PlayTabView(
            1,
            hasActiveGame,
            key: PageStorageKey('playtabrounds'),
          ),
        ),
        PageStorage(
          bucket: _storageBucket,
          child: PlayTabView(
            2,
            hasActiveGame,
            key: PageStorageKey('playtabranks'),
          ),
        ),
      ],
      //explore
      [
        PageStorage(
          bucket: _storageBucket,
          child: ExploreTabView(
            0,
            key: PageStorageKey('exploretabtrials'),
          ),
        ),
        PageStorage(
          bucket: _storageBucket,
          child: ExploreTabView(
            1,
            key: PageStorageKey('exploretabgames'),
          ),
        ),
      ],
    ];
  }

  List<AppBar> getAppBars() {
    return [
      AppBar(
        title: Text('HOME'),
        bottom: TabBar(
          controller: _homeTabController,
          onTap: _onTabBarTapped,
          tabs: <Widget>[
            Tab(
              child: Text('Trials'),
            ),
            Tab(
              child: Text('Games'),
            ),
          ],
          indicatorWeight: 3.0,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      AppBar(
        title: Text('PLAY'),
        bottom: TabBar(
          controller: _playTabController,
          onTap: _onTabBarTapped,
          tabs: <Widget>[
            Tab(
              child: Text('Trial'),
            ),
            Tab(
              child: Text('Rounds'),
            ),
            Tab(
              child: Text('Ranks'),
            )
          ],
          indicatorWeight: 3.0,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      AppBar(
        title: Text("EXPLORE"),
        bottom: TabBar(
          controller: _exploreTabController,
          onTap: _onTabBarTapped,
          tabs: <Widget>[
            Tab(
              child: Text('Trials'),
            ),
            Tab(
              child: Text('Games'),
            ),
          ],
          indicatorWeight: 3.0,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
    ];
  }

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _selectedBottomNavigationIndex = index;
    });
  }

  void _onTabBarTapped(int index) {
    setState(() {
      _selectedTabBarIndexes[_selectedBottomNavigationIndex] = index;
    });
  }

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }
}
