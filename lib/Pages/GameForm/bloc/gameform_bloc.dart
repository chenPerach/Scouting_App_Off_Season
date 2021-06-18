import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';

part 'gameform_event.dart';
part 'gameform_state.dart';

class GameformBloc extends Bloc<GameformEvent, GameformState> {
  GameformBloc() : super(GameformInitial());
  int index;
  ScoutingMatch match;
  @override
  Stream<GameformState> mapEventToState(
    GameformEvent event,
  ) async* {
    if (event is GameFormUpdate)
      yield GameformPage(index: event.index, match: event.match);
  }
}
