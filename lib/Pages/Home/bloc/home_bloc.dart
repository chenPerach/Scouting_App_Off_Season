import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/HomeService.dart';
import 'package:scouting_app_2/services/PrimoUserService.dart';
import 'package:scouting_app_2/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeFetchGames) {
      yield HomeLoading();

      if (event.uc.user != null) event.uc.setUpChangeListener();
      List<MatchModel> matches = await HomeService.getMatches();
      await Future.doWhile(() => event.uc?.user?.user?.displayName == null);
      var comp = CompotitionModel(
        finals: _getList("f", matches),
        semi: _getList("sf", matches),
        quarter: _getList("qf", matches),
        quals: _getList("qm", matches),
      );
      yield HomeWithData(comp);
    }

    if (event is HomeUpdateUser) {
      await PrimoUserService.updateUser(event.user);
    }
    if (event is HomeScheduleNotification) {
      var m = event.match;

      await NotificationService.scheduleNotification(
          match2id(m), tz.TZDateTime.from(m.time, tz.local),
          title: "Scouting App", body: "your match is about to start");
    }
  }

  List<MatchModel> _getList(String matchType, List<MatchModel> matches) {
    List<MatchModel> l = List<MatchModel>.from(
        matches.where((e) => e.compLevel.toLowerCase() == matchType));
    l.sort((m1, m2) => m1.matchNumber - m2.matchNumber);
    return l;
  }

  int match2id(MatchModel m) {
    int id = 0;
    switch (m.compLevel) {
      case "qm":
        id = 1;
        break;
      case "f":
        id = 4;
        break;
      case "sf":
        id = 3;
        break;
      case "qf":
        id = 1;
        break;
      default:
    }
    id = id * pow(10, m.matchNumber.toString().length) + m.matchNumber;
    return id;
  }
}
