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

class HomeScheduleNotification extends HomeEvent { 
  final MatchModel match;
  HomeScheduleNotification(this.match);
}
class HomeRemoveScheduledNotification extends HomeEvent { 
  final MatchModel match;
  HomeRemoveScheduledNotification(this.match);
}