part of 'gameform_bloc.dart';

@immutable
abstract class GameformEvent {}
class GameFormMoveTo extends GameformEvent{
  final int index;
  GameFormMoveTo(this.index);
}