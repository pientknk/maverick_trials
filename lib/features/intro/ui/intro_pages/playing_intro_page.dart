import 'package:flutter/material.dart';
import 'package:maverick_trials/features/intro/ui/coming_soon_background.dart';
import 'package:maverick_trials/features/intro/ui/intro_pages/intro_page.dart';
import 'package:maverick_trials/ui/widgets/app_avatar.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';
import 'package:maverick_trials/utils/rank_points.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class PlayingIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroPage(
      key: UniqueKey(),
      header: 'Playing a Game',
      backgroundAlignment:
      Alignment.lerp(Alignment.center, Alignment.topCenter, 0.5),
      background: ComingSoonBackground(),
      contentParts: [
        "Every trial will have a Trial Master who is in charge of "
          "scoring the other players. 1st place get the most points for this Trial. "
          "The Trial Master does not play that round.",
        " You decide how the Trial Master gets picked for every trial. After all"
          " trials have completed, the player with the highest score wins!",
      ]);
  }

  Widget _background(){
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      color: ThemeColors.jetGrey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            _trialHeader(),
            Text("Trial Master: WarmWatermelon"),
            _trialRankings(),
          ],
        ),
      ),
    );
  }

  Widget _trialRankings(){
    return Expanded(
      child: Container(
        //color: ThemeColors.sonicSilver,
        child: ListView(
          children: [
            _rankingsCard(
              rank: 2,
              avatarLink: "images/avatars/ironman_256.png",
              numPlayers: 6,
              playerName: 'GreenShirt',
              totalPoints: 35,
            ),
            _rankingsCard(
              rank: 2,
              avatarLink: "images/avatars/loki_256.png",
              numPlayers: 6,
              playerName: 'MintyFresh',
              totalPoints: 29,
            ),
            _rankingsCard(
              rank: 3,
              avatarLink: "images/avatars/spider_man_256.png",
              numPlayers: 6,
              playerName: 'OliveCat',
              totalPoints: 49,
            ),
          ],
        ),
      ),
    );
  }

  Widget _rankingsCard({int rank, int numPlayers, String playerName, int totalPoints, avatarLink}){
    return Card(
      elevation: 0.0,
      shadowColor: null,
      color: ThemeColors.sonicSilver,
      child: ListTile(
        title: ImportantText(playerName),
        subtitle: Text("$totalPoints Pts Total", style: TextStyle(color: Colors.grey[350])),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: AppAvatar(link: avatarLink),
        ),
        trailing: Text('${RankPoints.getRankPoints(rank, numPlayers)} Pts'),
      ),
    );
  }

  Widget _trialHeader(){
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(6.0),
          height: 32,
          width: 32,
          child: ClipPolygon(
            sides: 6,
            rotate: 90.0,
            child: CircleAvatar(
              backgroundColor: ThemeColors.greenSheen,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(),
              ),
              radius: 25,
            ),
          ),
        ),
        Center(
          child: ImportantText(
            "Trial #1",
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
