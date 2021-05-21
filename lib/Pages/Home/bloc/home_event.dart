part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}
class HomeFetchGames extends HomeEvent {
  final UserContainer uc;
  HomeFetchGames(this.uc);
}
class HomeAddFavorite extends HomeEvent {
  final int favoite;
  final UserContainer uc;
  HomeAddFavorite({this.favoite,this.uc});
}