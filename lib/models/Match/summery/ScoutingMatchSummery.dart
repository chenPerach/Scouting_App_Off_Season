import 'package:scouting_app_2/models/Match/Cycle.dart';
import 'package:scouting_app_2/models/Match/GameInfo.dart';
import 'package:scouting_app_2/models/Match/MatchData.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';

/// this is a summery object for a few matches from the same team
class ScoutingMatchSummery {
  GameInfoSummery info;
  MatchDataSummery matchData;
  ScoutingMatchSummery(List<ScoutingMatch> matches) {
    this.info =
        GameInfoSummery(List.generate(matches.length, (i) => matches[i].info));
    this.matchData =
        MatchDataSummery(List.generate(matches.length, (i) => matches[i].data));
  }
}

class MatchDataSummery {
  MidGameDataSummery teleop, auto;
  EndGameSummery endGame;
  MatchDataSummery(List<ScoutingMatchData> data) {
    List<MidGameStage> teleList = [], autoList = [];
    data.forEach((e) {
      teleList.add(e.teleop);
      autoList.add(e.autonomus);
    });
    this.auto = MidGameDataSummery(autoList);
    this.teleop = MidGameDataSummery(teleList);
  }
}

class EndGameSummery {
  int evenSum, climbSum, platformSum, nothingSum;

  EndGameSummery(List<EndGameStage> list) {
    this.climbSum = 0;
    this.evenSum = 0;
    this.nothingSum = 0;
    this.platformSum = 0;

    list.forEach((e) {
      switch (e.type.value) {
        case EndGameClimbType.empty:
          nothingSum++;
          break;
        case EndGameClimbType.even:
          evenSum++;
          break;
        case EndGameClimbType.platform:
          platformSum++;
          break;
        case EndGameClimbType.uneven:
          climbSum++;
          break;
        default:
      }
    });
  }
}

class MidGameDataSummery {
  ShootingCyclesSummery shooting;
  BallsCyclesSummery balls;
  RolletCyclesSummery rollet;

  MidGameDataSummery(List<MidGameStage> data) {
    List<ShootingCycle> shooting = [];
    List<RolletCycle> rollet = [];
    List<BallsCycle> balls = [];
    data.forEach((element) {
      shooting.addAll(element.shooting);
      rollet.addAll(element.rollet);
      balls.addAll(element.balls);
    });
    this.shooting = ShootingCyclesSummery(shooting);
    this.rollet = RolletCyclesSummery(rollet);
    this.balls = BallsCyclesSummery(balls);
  }
}

class BallsCyclesSummery {
  List<BallsCycle> balls;
  double avgPicked;
  int tranchPasses;
  BallsCyclesSummery(this.balls) {
    int ballsPicked = 0;
    this.tranchPasses = 0;
    balls.forEach((e) {
      ballsPicked += e.numPicked;
      this.tranchPasses += e.tranch ? 1 : 0;
    });
    this.avgPicked = ballsPicked.toDouble() / balls.length.toDouble();
  }
}

class RolletCyclesSummery {
  int rotationNumber, positionNumber;
  RolletCyclesSummery(List<RolletCycle> l) {
    rotationNumber = 0;
    positionNumber = 0;
    l.forEach((e) {
      if (e.type == RolletCycle.rotation)
        rotationNumber++;
      else
        positionNumber++;
    });
  }
}

class ShootingCyclesSummery {
  List<ShootingCycle> shooting;
  double lowerAvg, outerAvg, innerAvg, accuracy;
  ShootingCyclesSummery(this.shooting) {
    int ballsShot = 0;
    int ballsLower = 0, ballsOuter = 0, ballsInner = 0;
    this.shooting.forEach((e) {
      ballsShot += e.ballsShot;
      ballsInner += e.ballsInner;
      ballsLower += e.ballsLower;
      ballsOuter += e.ballsOuter;
    });

    this.innerAvg = ballsInner.toDouble() / shooting.length.toDouble();
    this.outerAvg = ballsOuter.toDouble() / shooting.length.toDouble();
    this.lowerAvg = ballsLower.toDouble() / shooting.length.toDouble();
    this.accuracy = (ballsInner + ballsOuter + ballsLower).toDouble() /
        ballsShot.toDouble();
  }
}

class GameInfoSummery {
  int teamNumber;
  List<_Match> matches;
  GameInfoSummery(List<GameInfo> l) {
    this.teamNumber = l.first.teamNumber;
    this.matches = List.generate(
        l.length,
        (i) =>
            _Match(compLevel: l[i].compLevel.simple, number: l[i].matchNumber));
    this.matches.sort((a, b) => a.compareTo(b));
  }
}

class _Match {
  int number;
  String compLevel;
  _Match({this.compLevel, this.number});

  int compareTo(_Match other) {
    int compVal = _getVal(this.compLevel),
        otherCompVal = _getVal(other.compLevel);
    if (compVal.compareTo(otherCompVal) != 0) {
      return compVal.compareTo(otherCompVal);
    } else {
      return this.number.compareTo(other.number);
    }
  }

  int _getVal(String cl) {
    int val = 0;
    switch (cl) {
      case "qm":
        val = 1;
        break;
      case "qf":
        val = 2;
        break;
      case "sf":
        val = 3;
        break;
      case "f":
        val = 4;
        break;
      default:
    }
    return val;
  }

  @override
  String toString() {
    return "$compLevel - $number";
  }
}
