import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/Home/bloc/home_bloc.dart';
import 'package:scouting_app_2/Pages/Home/widgets/match_list.dart';
import 'package:scouting_app_2/Pages/WaitingPage/Waiting.dart';
import 'package:scouting_app_2/models/matchModel.dart';

class _HomePage extends StatelessWidget {
  static const String route = '/home';
  final List<MatchModel> matches;
  _HomePage(this.matches);

  @override
  Widget build(BuildContext context) {
    UserContainer uc = Provider.of<UserContainer>(context);
    if (uc.user != null) uc.setUpChangeListener();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () =>
                BlocProvider.of<HomeBloc>(context).add(HomeFetchGames())),
        actions: [
          IconButton(icon: Icon(Icons.arrow_right), onPressed: () {}),
        ],
      ),
      body: MatchList(matches: matches),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _BlocHandler();
}

class _BlocHandler extends StatelessWidget {
  final HomeBloc bloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener(
        listener: (context, state) {},
        child: BlocBuilder(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Waiting();
            }
            if (state is HomeInitial) {
              bloc.add(HomeFetchGames());
              return Waiting();
            }
            if (state is HomeWithData) {
              return _HomePage(state.matches);
            }
            return null;
          },
        ),
      ),
    );
  }
}
