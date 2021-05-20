part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeWithData extends HomeState {
  final List<MatchModel> matches;
  HomeWithData({this.matches});
}
