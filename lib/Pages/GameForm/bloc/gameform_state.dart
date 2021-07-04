part of 'gameform_bloc.dart';

@immutable
abstract class GameFormState {}

class GameformInitial extends GameFormState {}

class GameformPage extends GameFormState {
  final int index;
  final ScoutingMatch match;
  final String error;
  GameformPage({@required this.index, @required this.match,this.error});
}

class GameFormLoading extends GameFormState {}
class GameFormExit extends GameFormState {}
class GameFormShowSummery extends GameFormState{
  final ScoutingMatchSummery summery;
  GameFormShowSummery(this.summery);
}