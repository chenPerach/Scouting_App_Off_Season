part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}
class HomeFetchGames extends HomeEvent {
  final UserContainer uc;
  HomeFetchGames(this.uc);
}
class HomeUpdateUser extends HomeEvent {
  final PrimoUser user;
  HomeUpdateUser(this.user);
}

