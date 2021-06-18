part of 'gameform_bloc.dart';

@immutable
abstract class GameformEvent {}


class GameFromChangePage extends GameformEvent{
  final int index;
  GameFromChangePage(this.index);
}

class GameFormUpdateGameInfo extends GameformEvent{
  final GameInfo info;
  GameFormUpdateGameInfo(this.info);
}
class GameFormUpdate extends GameformEvent {
  final int index;
  final ScoutingMatch match;
  GameFormUpdate(this.index, this.match);
}
