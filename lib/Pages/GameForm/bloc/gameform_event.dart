part of 'gameform_bloc.dart';

@immutable
abstract class GameformEvent {}

class GameFromChangePage extends GameformEvent {
  final int index;
  GameFromChangePage(this.index);
}

class GameFormUpdateGameInfo extends GameformEvent {
  final GameInfo info;
  GameFormUpdateGameInfo(this.info);
}

class GameFormUpdate extends GameformEvent {
  final int index;
  final ScoutingMatch match;
  GameFormUpdate(this.index, this.match);
}

class GameFormUpdateStartingPosition extends GameformEvent {
  final String pos;
  GameFormUpdateStartingPosition(this.pos);
}

class GameFromInitialEvent extends GameformEvent {}

class GameFormAddShootingCycle extends GameformEvent{
  final String  type;
  final ShootingCycle cycle;
  GameFormAddShootingCycle({this.cycle,this.type});
}

class GameFormAddBallsCycle extends GameformEvent{
  final String  type;
  final BallsCycle cycle;
  GameFormAddBallsCycle({this.cycle,this.type});
}
class GameFormAddRolletCycle extends GameformEvent{
  final String  type;
  final RolletCycle cycle;
  GameFormAddRolletCycle({this.cycle,this.type});
}