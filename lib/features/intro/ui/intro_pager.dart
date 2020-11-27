import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/features/auth/bloc/auth.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/playing_intro_page.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/profile_intro_page.dart';
import 'package:maverick_trials/features/intro/ui/slider_indicator.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/trial_game_intro_page.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/tutorial_intro_page.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/welcome_intro_page.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:supercharged/supercharged.dart';

class IntroPager extends StatefulWidget {
  final FirebaseUserRepository userRepository = locator<FirebaseUserRepository>();
  final PageController pageController = PageController();
  final List<Widget> introPages = [
    WelcomeIntroPage(),
    ProfileIntroPage(),
    TrialGameIntroPage(),
    PlayingIntroPage(),
    TutorialIntroPage()
  ];

  @override
  _IntroPagerState createState() => _IntroPagerState();
}

class _IntroPagerState extends State<IntroPager> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('Current selected index of introPager: $currentIndex');
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: PageView(
            children: widget.introPages,
            controller: widget.pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      //width: 100,
                      child: AppButton(
                        text: currentIndex == 0 ? "Skip" : "Back",
                        fontSize: 14,
                        onPressed: () async{
                          if(currentIndex == 0){
                            await _setUserIntroCompletedAndLogin();
                          }
                          else{
                            setState(() {
                              currentIndex--;
                              widget.pageController.previousPage(duration: 400.milliseconds, curve: Curves.easeInOut);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: _buildSliderIndicators(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //width: 100,
                      child: AppButton(
                          text: currentIndex == widget.introPages.length - 1 ? "Done" : "Next",
                        onPressed: () async {
                          if (currentIndex < widget.introPages.length - 1) {
                            setState(() {
                              currentIndex++;
                              widget.pageController.nextPage(duration: 400.milliseconds, curve: Curves.easeInOut);
                            });
                          } else {
                            await _setUserIntroCompletedAndLogin();
                          }
                        },
                      ),
                    ),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSliderIndicators() {
    List<Widget> sliderIndicators = List<Widget>();

    for (int i = 0; i < widget.introPages.length; i++) {
      sliderIndicators.add(
        SliderIndicator(
          sliderStatus: _getSliderStatusForIndex(i, currentIndex),
          onTapped: () {
            setState(() {
              widget.pageController.animateToPage(i,
                  duration: 400.milliseconds,
                  curve: Curves.easeInOut);
              currentIndex = i;
            });
          },
        ),
      );
    }

    return sliderIndicators;
  }

  Future<void> _setUserIntroCompletedAndLogin() async {
    User user = await widget.userRepository.getCurrentUser();
    user.completedIntro = true;
    await widget.userRepository.update(user);

    BlocProvider.of<AuthBloc>(context).add(AuthLoggedInEvent(user: user));
  }

  SliderStatus _getSliderStatusForIndex(index, currentIndex) {
    if (currentIndex == index) {
      return SliderStatus.active;
    }

    if (currentIndex > index) {
      return SliderStatus.completed;
    } else {
      return SliderStatus.inactive;
    }
  }

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPop() async {
    return false;
  }
}
