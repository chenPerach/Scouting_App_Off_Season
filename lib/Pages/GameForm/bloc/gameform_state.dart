part of 'gameform_bloc.dart';

@immutable
abstract class GameformState {}

class GameformInitial extends GameformState {}

class GameformPage extends GameformState {
  final int index;
  final Match match;
  GameformPage({@required this.index, @required this.match});
}
