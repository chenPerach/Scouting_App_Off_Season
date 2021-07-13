import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/models/Match/PostGameData.dart';

class CommentAndSummary extends StatefulWidget {
  final PostGameData data;
  CommentAndSummary({this.data});

  @override
  _CommentAndSummaryState createState() => _CommentAndSummaryState();
}

class _CommentAndSummaryState extends State<CommentAndSummary> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    controller = TextEditingController(text: widget?.data?.comment ?? "");
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "winning state:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
              height: 200,
              child: ElevatedButton(
                child: widget.data.winningState.image,
                onPressed: () {
                  this.widget.data.winningState = WinningStateGenerator.next();
                  BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormUpdatePostGameData(this.widget.data));
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "playing type:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
              height: 200,
              child: ElevatedButton(
                child: Text(widget.data.playingType.type),
                onPressed: () {
                  this.widget.data.playingType = PlayingTypeGenerator.next();
                  BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormUpdatePostGameData(this.widget.data));
                },
              ),
            ),
            Container(
              width: 250,
              child: TextField(
                decoration: InputDecoration(hintText: "comment"),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: controller,
                onChanged: (value) {
                  // widget.data.comment = value;
                  
                  BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormAddComment(value));
                  // BlocProvider.of<GameFormBloc>(context)
                  //     .add(GameFormUpdatePostGameData(this.data));
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var user =
                    Provider.of<UserContainer>(context, listen: false).user;
                widget.data.comment = controller.text;
                BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormAddComment(controller.text));
                BlocProvider.of<GameFormBloc>(context)
                    .add(GameFormUploadMatch(user: user));

              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
