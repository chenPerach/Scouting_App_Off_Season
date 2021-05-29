import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'gameform_event.dart';
part 'gameform_state.dart';

class GameformBloc extends Bloc<GameformEvent, GameformState> {
  GameformBloc() : super(GameformInitial());

  @override
  Stream<GameformState> mapEventToState(
    GameformEvent event,
  ) async* {
    if(event is GameFormMoveTo)
      yield GameformPage(event.index);
  }
}
