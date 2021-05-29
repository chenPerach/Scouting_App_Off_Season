part of 'gameform_bloc.dart';

@immutable
abstract class GameformState {}

class GameformInitial extends GameformState {}
class GameformPage extends GameformState {
  final int index;
  GameformPage(this.index);

}
