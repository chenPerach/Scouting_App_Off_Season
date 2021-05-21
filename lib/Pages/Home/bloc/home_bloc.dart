import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
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
      List matches = await HomeService.getMatches();
      await Future.doWhile(() => event.uc?.user?.user?.displayName == null);
      yield HomeWithData(matches: matches);
    }

    if (event is HomeAddFavorite) {
      var user = event.uc.user;
      var n = event.favoite;
      user.favorites[n] = !user.favorites[n];
      event.uc.user = user;
      await PrimoUserService.updateUser(user);
    }
  }
}

