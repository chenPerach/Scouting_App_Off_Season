import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/HomeService.dart';
import 'package:scouting_app_2/services/PrimoUserService.dart';

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
  }

  List<MatchModel> _getList(String matchType, List<MatchModel> matches) {
    List<MatchModel> l = List<MatchModel>.from(
        matches.where((e) => e.compLevel.toLowerCase() == matchType));
    l.sort((m1, m2) => m1.matchNumber - m2.matchNumber);
    return l;
  }
}
