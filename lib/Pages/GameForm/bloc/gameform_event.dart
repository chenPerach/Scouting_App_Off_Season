part of 'gameform_bloc.dart';

@immutable
abstract class GameformEvent {}
class GameFormUpdate extends GameformEvent{
  final int index;
  final Match match;
  GameFormUpdate(this.index,this.match);
}