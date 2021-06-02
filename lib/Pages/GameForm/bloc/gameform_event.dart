part of 'gameform_bloc.dart';

@immutable
abstract class GameformEvent {}

class GameFormUpdate extends GameformEvent {
  final int index;
  final ScoutingMatch match;
  GameFormUpdate(this.index, this.match);
}
