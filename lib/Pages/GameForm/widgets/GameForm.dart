import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/BottomNavigation.dart';
import 'package:scouting_app_2/Utils/BlocCreator.dart';
import 'package:scouting_app_2/models/Match/Match.dart';

class GameFormBlocCreator extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return WillPopScope(
      onWillPop: () => _onWillPop(c),
      child: PageBlocCreator<GameformEvent,GameformState,GameformBloc>(
        create: (_) => GameformBloc(),
        builder: _builder,
        listener: (context, state) {},
      ),
    );
  }

  Widget _builder(BuildContext context, GameformState state) {
    if (state is GameformPage) return GameFormBottomNavPage(index: state.index,match: state.match,);
    if (state is GameformInitial) return GameFormBottomNavPage(index: 0,match: Match.empty(),);
    return null;
  }

  Future<bool> _onWillPop(BuildContext c) async {
    return await showDialog(
      context: c,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure you want to quit?"),
          content: Text("All of the data that you submitted will be lost."),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("quit")),
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("cancel")),
          ],
        );
      },
    );
  }
}
