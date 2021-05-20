import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/HomeService.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    
    
    if(event is HomeFetchGames){
      yield HomeLoading();
      List matches = await HomeService.getMatches();
      yield HomeWithData(matches: matches);
    }
     
  }
}
