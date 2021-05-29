import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/Home/bloc/home_bloc.dart';
import 'package:scouting_app_2/Pages/Home/widgets/Favorites.dart';
import 'package:scouting_app_2/Pages/Home/widgets/match_list.dart';
import 'package:scouting_app_2/Pages/WaitingPage/Waiting.dart';
import 'package:scouting_app_2/Pages/nav_drawer.dart';
import 'package:scouting_app_2/Utils/BlocCreator.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';

import 'package:scouting_app_2/models/matchModel.dart';

class _HomePage extends StatelessWidget {
  final CompotitionModel matches;
  _HomePage(this.matches);

  @override
  Widget build(BuildContext context) {
    List<MatchModel> lst = List.from(this.matches.quals);
    lst.addAll(matches.quarter);
    lst.addAll(matches.semi);
    lst.addAll(matches.finals);

    UserContainer uc = Provider.of<UserContainer>(context);
    if (uc.user != null) uc.setUpChangeListener();
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.refresh_rounded),
            onPressed: () =>
                BlocProvider.of<HomeBloc>(context).add(HomeFetchGames(uc))),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                PrimoUser user = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Favorites(uc)));
                BlocProvider.of<HomeBloc>(context).add(HomeUpdateUser(user));
                uc.user = user;
              }),
        ],
      ),
      body: MatchList(matches: matches.quals),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _BlocHandler();
}

class _BlocHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageBlocCreator<HomeEvent, HomeState, HomeBloc>(
      create: (_) => HomeBloc(),
      builder: _build,
      listener: (context, state) {},
    );
  }

  Widget _build(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return Waiting();
    }
    if (state is HomeInitial) {
      BlocProvider.of<HomeBloc>(context)
          .add(HomeFetchGames(Provider.of<UserContainer>(context)));
      return Waiting();
    }
    if (state is HomeWithData) {
      return _HomePage(state.matches);
    }
    return null;
  }
}