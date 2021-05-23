import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/Home/bloc/home_bloc.dart';
import 'package:scouting_app_2/Pages/Home/widgets/ExpantionTile.dart';
import 'package:scouting_app_2/Pages/Home/widgets/Favorites.dart';
import 'package:scouting_app_2/Pages/Home/widgets/match_list.dart';
import 'package:scouting_app_2/Pages/WaitingPage/Waiting.dart';
import 'package:scouting_app_2/models/matchModel.dart';

class _HomePage extends StatelessWidget {
  final CompotitionModel matches;
  _HomePage(this.matches);

  @override
  Widget build(BuildContext context) {
    UserContainer uc = Provider.of<UserContainer>(context);
    if (uc.user != null) uc.setUpChangeListener();
    return Scaffold(
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
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Favorites(uc)));
              }),
        ],
      ),
      body: ListView(
        children: [
          MatchesExpansionTile(title: "Qualification Matches",matches: this.matches.quals,),
          MatchesExpansionTile(title: "Quarter Finals",matches: this.matches.quarter,),
          MatchesExpansionTile(title: "Semi Finals",matches: this.matches.semi,),
          MatchesExpansionTile(title: "Finals",matches: this.matches.finals,),
        ],
      ),
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
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: _BlocBuilder(),
      ),
    );
  }
}

class _BlocBuilder extends StatelessWidget {
  const _BlocBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
      },
    );
  }
}
