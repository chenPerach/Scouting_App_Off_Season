part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeWithData extends HomeState {
  final CompotitionModel matches;
  HomeWithData(this.matches);
}

class CompotitionModel {
  final List<MatchModel> quals, quarter, semi, finals;
  CompotitionModel({this.finals, this.quals, this.quarter, this.semi});
}
