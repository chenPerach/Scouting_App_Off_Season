import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/GameFormWrapper.dart';

class GameFormBlocCreator extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return WillPopScope(
      onWillPop: () => _onWillPop(c),
      child: BlocProvider(
        create: (_) => GameformBloc(),
        child: Builder(
          builder: (context) {
            return BlocListener(
              listener: (context, state) {},
              bloc: BlocProvider.of<GameformBloc>(context),
              child: BlocBuilder(
                bloc: BlocProvider.of<GameformBloc>(context),
                builder: (context, state) {
                  return GameFormMenu(index: 1);
                },
              ),
            );
          },
        ),
      ),
    );
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
