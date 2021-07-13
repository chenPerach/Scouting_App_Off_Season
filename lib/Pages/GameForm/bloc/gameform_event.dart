part of 'gameform_bloc.dart';

@immutable
abstract class GameFormEvent {}

class GameFromChangePage extends GameFormEvent {
  final int index;
  GameFromChangePage(this.index);
}

class GameFormUpdateGameInfo extends GameFormEvent {
  final GameInfo info;
  GameFormUpdateGameInfo(this.info);
}

class GameFormUpdateStartingPosition extends GameFormEvent {
  final String pos;
  GameFormUpdateStartingPosition(this.pos);
}

class GameFromInitialEvent extends GameFormEvent {}

class GameFormAddShootingCycle extends GameFormEvent {
  final String type;
  final ShootingCycle cycle;
  GameFormAddShootingCycle({this.cycle, this.type});
}

class GameFormAddBallsCycle extends GameFormEvent {
  final String type;
  final BallsCycle cycle;
  GameFormAddBallsCycle({this.cycle, this.type});
}

class GameFormAddRolletCycle extends GameFormEvent {
  final String type;
  final Rollet cycle;
  GameFormAddRolletCycle({this.cycle, this.type});
}

class GameFormUpdateEndGame extends GameFormEvent {
  final EndGameStage data;
  GameFormUpdateEndGame(this.data);
}
class GameFormAddComment extends GameFormEvent{
  String comment;
  GameFormAddComment(this.comment);
}
class GameFormUpdatePostGameData extends GameFormEvent {
  final PostGameData data;
  GameFormUpdatePostGameData(this.data);
}

class GameFormCheckMatchData extends GameFormEvent {}

class GameFormUploadMatch extends GameFormEvent {
  final PrimoUser user;
  GameFormUploadMatch({
    @required this.user,
  });
}