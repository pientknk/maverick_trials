import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/locator.dart';

class RankPoints {
  const RankPoints();

  static int getRankPoints(int rank, int numPlayers){
    if(rank > numPlayers){
      locator<Logging>().log(LogType.pretty, LogLevel.warning, 'Rank was higher than number of players! '
        'Rank: $rank, Players: $numPlayers');
      return 0;
    }
    else{
      return numPlayers - rank;
    }
  }
}