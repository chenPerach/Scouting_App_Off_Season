import 'dart:async';

import 'package:ansicolor/ansicolor.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/models/Match/CompLevel.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';
import 'package:scouting_app_2/models/Match/GameInfo.dart';
import 'package:scouting_app_2/models/Match/MatchData.dart';
import 'package:scouting_app_2/models/Match/PostGameData.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/HomeService.dart';
import 'package:scouting_app_2/services/gameForm.dart';

part 'gameform_event.dart';
part 'gameform_state.dart';

class GameFormBloc extends Bloc<GameFormEvent, GameFormState> {
  GameFormBloc() : super(GameformInitial());
  AnsiPen _pen = AnsiPen()..red(bold: true,bg: false)..white(bg: true);
  final _kTAG = "GAME FORM"; 
  int index;
  ScoutingMatch match;
  @override
  Stream<GameFormState> mapEventToState(
    GameFormEvent event,
  ) async* {
    if (event is GameFormUpdateGameInfo) {
      this.match.info = event.info;
      yield GameformPage(index: index, match: this.match);
    }
    if (event is GameFromInitialEvent) {
      this.index = 0;
      this.match = ScoutingMatch();
      this.match.info = getInfoByTime(DateTime.now()) ??
          GameInfo(
              alliance: "blue",
              teamNumber: 4586,
              compLevel: CompLevel.simple("qm"),
              matchNumber: 1);
      this.match.data = ScoutingMatchData();
      this.match.data.endGame =
          EndGameStage(type: EndGameClimbTypeGenerator.next());
      this.match.postGameData = PostGameData(
          winningState: WinningStateGenerator.next(),
          playingType: PlayingTypeGenerator.next());
      this.match.data.autonomus =
          MidGameStage(balls: [], rollet: [], shooting: []);
      this.match.data.teleop =
          MidGameStage(balls: [], rollet: [], shooting: []);
      yield GameformPage(index: index, match: this.match);
    }
    if (event is GameFormUpdateStartingPosition) {
      this.match.data.startingPosition = event.pos;
      yield GameformPage(index: index, match: this.match);
    }
    if (event is GameFromChangePage) {
      this.index = event.index;
      yield GameformPage(index: this.index, match: this.match);
    }
    if (event is GameFormAddShootingCycle) {
      if (event.type == "AUTO") {
        if (match.data.autonomus == null)
          match.data.autonomus =
              MidGameStage(balls: [], rollet: [], shooting: []);
        match.data.autonomus.shooting.add(event.cycle);
      } else {
        if (match.data.teleop == null)
          match.data.teleop = MidGameStage(balls: [], rollet: [], shooting: []);
        match.data.teleop.shooting.add(event.cycle);
      }
      yield GameformPage(index: index, match: this.match);
    }

    if (event is GameFormAddBallsCycle) {
      if (event.type == "AUTO") {
        if (match.data.autonomus == null)
          match.data.autonomus =
              MidGameStage(balls: [], rollet: [], shooting: []);
        match.data.autonomus.balls.add(event.cycle);
      } else {
        if (match.data.teleop == null)
          match.data.teleop = MidGameStage(balls: [], rollet: [], shooting: []);
        match.data.teleop.balls.add(event.cycle);
      }
      yield GameformPage(index: index, match: this.match);
    }
    if (event is GameFormAddRolletCycle) {
      if (event.type == "AUTO") {
        if (match.data.autonomus == null)
          match.data.autonomus =
              MidGameStage(balls: [], rollet: [], shooting: []);
        match.data.autonomus.rollet.add(event.cycle);
      } else {
        if (match.data.teleop == null)
          match.data.teleop = MidGameStage(balls: [], rollet: [], shooting: []);
        match.data.teleop.rollet.add(event.cycle);
      }
      yield GameformPage(index: index, match: this.match);
    }
    if (event is GameFormUpdateEndGame) {
      match.data.endGame = EndGameStage(type: EndGameClimbTypeGenerator.next());
      yield GameformPage(index: index, match: this.match);
    }
    if (event is GameFormUploadMatch) {
      bool valid = isMatchData(this.match.info);
      if (!valid) {
        this.index = 0;
        yield GameformPage(
            index: this.index,
            match: this.match,
            error: "match data not valid, please provide correct match data.");
      } else {
        print(_pen("$_kTAG: UPLOADING MATCH"));
        var summery = ScoutingMatchSummery([this.match]);
        yield GameFormLoading();
        await ScoutingDataService.uploadMatch(this.match, event.user);
        yield GameFormExit();
      }
    }
    if (event is GameFormUpdatePostGameData) {
      this.match.postGameData = event.data;

      yield GameformPage(index: index, match: this.match);
    }
  }

  bool isMatchData(GameInfo data) {
    List<MatchModel> matches = HomeService.matchList;
    for (var match in matches) {
      if (match.compLevel == data.compLevel.simple &&
          match.matchNumber == data.matchNumber) {
        if (data.alliance == "blue")
          for (var team in match.blueAllience.teamNumbers) {
            if (team == data.teamNumber) return true;
          }
        else if (data.alliance == "red")
          for (var team in match.redAllience.teamNumbers)
            if (team == data.teamNumber) return true;
      }
    }
    return false;
  }

  GameInfo getInfoByTime(DateTime time) {
    MatchModel closestGame = HomeService.matchList?.first;
    Duration dT = closestGame == null
        ? Duration(milliseconds: 0)
        : time.difference(HomeService.matchList.first.time).abs();
    if (closestGame != null)
      for (var game in HomeService.matchList) {
        var difference = time.difference(game.time).abs();
        if (difference.compareTo(dT) <= 0) {
          closestGame = game;
          dT = difference;
        }
      }
    else
      return null;
    return GameInfo(
      alliance: "blue",
      teamNumber: closestGame.blueAllience.teamNumbers[0],
      compLevel: CompLevel.simple(closestGame.compLevel),
      matchNumber: closestGame.matchNumber,
    );
  }
}

class EndGameClimbTypeGenerator {
  static int _i = 0;
  static EndGameClimbType next() {
    _i = (_i + 1) % 4;
    switch (_i) {
      case 0:
        return EndGameClimbType.generate(EndGameClimbType.empty);
      case 1:
        return EndGameClimbType.generate(EndGameClimbType.even);
      case 2:
        return EndGameClimbType.generate(EndGameClimbType.uneven);
      case 3:
        return EndGameClimbType.generate(EndGameClimbType.platform);
      default:
        return EndGameClimbType.generate(EndGameClimbType.empty);
    }
  }
}
