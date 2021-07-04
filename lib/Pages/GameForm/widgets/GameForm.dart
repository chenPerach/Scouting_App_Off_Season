import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/BottomNavigation.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryPage.dart';
import 'package:scouting_app_2/Pages/WaitingPage/Waiting.dart';
import 'package:scouting_app_2/Utils/BlocCreator.dart';

class GameFormBlocCreator extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return WillPopScope(
      onWillPop: () => _onWillPop(c),
      child: PageBlocCreator<GameFormEvent, GameFormState, GameFormBloc>(
        create: (_) => GameFormBloc(),
        builder: _builder,
        listener: (context, state) {
          if(state is GameFormExit)
            Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _builder(BuildContext context, GameFormState state) {
    if (state is GameformPage)
      return GameFormBottomNavPage(
        index: state.index,
        match: state.match,
        error: state.error,
      );
    if (state is GameformInitial){
      BlocProvider.of<GameFormBloc>(context).add(GameFromInitialEvent());
      return Waiting();
    }
    if(state is GameFormLoading){
      return Waiting();
    }
    if(state is GameFormExit){
      return Scaffold();
    }
    if(state is GameFormShowSummery){
      return SummeryPage(state.summery);
    }
    return Container();
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
