import 'package:flutter/material.dart';
import 'package:maverick_trials/features/trial_run/ui/trial_run_status.dart';
import 'package:maverick_trials/ui/widgets/app_avatar.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';
import 'package:maverick_trials/utils/rank_points.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class TrialRunCard extends StatelessWidget {
  final TrialRunStatus trialRunStatus;

  TrialRunCard({this.trialRunStatus});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      color: ThemeColors.jetGrey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 200,
        width: 300,
        child: Column(
          children: [
            Stack(
              children: [
                _trialActiveIcon(),
                Center(
                  child: ImportantText(
                    'Trial #1',
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            Text("Trial Master: WarmWatermelon"),
            Expanded(
              child: Container(
                //color: ThemeColors.sonicSilver,
                child: ListView(
                  children: [
                    _rankingsCard(
                      totalPoints: 25,
                      playerName: 'GreenShirt',
                      numPlayers: 6,
                      rank: 2,
                    ),
                    _unplayedTrial('Trial #2')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _unplayedTrial(String trialName){
    return Card(
      elevation: 0.0,
      shadowColor: null,
      color: ThemeColors.sonicSilver,
      child: ListTile(
        title: ImportantText(trialName),
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2.0),
          child: AppAvatar(
            link: null,
          ),
        ),
        subtitle: Text('Winner: TBD'),
        trailing: Icon(
          Icons.remove_circle,
          color: ThemeColors.jetGrey,
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

  Widget _trialActiveIcon(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(6.0),
      height: 32,
      width: 32,
      child: ClipPolygon(
        sides: 6,
        rotate: 90.0,
        child: CircleAvatar(
          backgroundColor: _getTrialIconColor(),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(),
          ),
          radius: 24,
        ),
      ),
    );
  }

  Color _getTrialIconColor(){
    switch (trialRunStatus) {
      case TrialRunStatus.inactive:
        return ThemeColors.cadetGrey;
      case TrialRunStatus.active:
        return ThemeColors.greenSheen;
      case TrialRunStatus.done:
        return ThemeColors.lincolnGreen;
      default:
        return ThemeColors.cadetGrey;
    }
  }
}