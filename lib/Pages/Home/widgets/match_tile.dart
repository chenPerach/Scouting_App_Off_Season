import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/Home/bloc/home_bloc.dart';
import 'package:scouting_app_2/models/matchModel.dart';

final Color gold = Color.fromARGB(255, 255, 215, 0);
final TextStyle goldStyle =
    TextStyle(color: gold, fontSize: 18, fontWeight: FontWeight.w700);

class MatchTile extends StatelessWidget {
  final TextStyle redStyle = TextStyle(
          color: Colors.red, fontSize: 18, fontWeight: FontWeight.w700),
      blueStyle = TextStyle(
          color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w700),
      title = TextStyle(
          fontSize: 50, fontWeight: FontWeight.w800, fontFamily: "OpenSans");

  final MatchModel match;
  MatchTile(this.match);

  @override
  Widget build(BuildContext context) {
    final UserContainer uc = Provider.of<UserContainer>(context);
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
          height: 90,
          child: Row(
            children: [
              Flexible(
                flex:6,
                child: Container(
                  color: Colors.black12,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    child: Text(
                      match.matchNumber.toString(),
                      style: title,
                    ),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  ),
                ),
              ),
              // Flexible(child: Container(),flex: 1,),

              Flexible(
                fit: FlexFit.loose,
                flex:12,
                child: Container(
                  // width: screenWidth*0.5,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _RedRow(uc: uc, match: match, redStyle: redStyle),
                      Container(height: 1,color: Colors.grey,width: 160,),
                      _BlueRow(uc: uc, match: match, blueStyle: blueStyle),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
              IconButton(
                  icon: uc.user.favoriteMatches.indexOf(match.matchNumber) == -1
                      ? Icon(Icons.favorite_border)
                      : Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    var user = uc.user;
                    var i = user.favoriteMatches.indexOf(match.matchNumber);
                    if (i == -1) {
                      user.favoriteMatches.add(match.matchNumber);
                      BlocProvider.of<HomeBloc>(context)
                          .add(HomeScheduleNotification(match));
                    } else {
                      user.favoriteMatches.removeAt(i);
                      BlocProvider.of<HomeBloc>(context)
                          .add(HomeRemoveScheduledNotification(match));
                    }
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeUpdateUser(user));
                    uc.user = user;
                  },
                  padding: EdgeInsets.fromLTRB(5, 0, 15, 0)),
            ],
          )),
    );
  }

  num getColumnWidth(num screenWidth) {
    if (screenWidth < 300) return 160;
  }
}

class _BlueRow extends StatelessWidget {
  const _BlueRow({
    Key key,
    @required this.uc,
    @required this.match,
    @required this.blueStyle,
  }) : super(key: key);

  final UserContainer uc;
  final MatchModel match;
  final TextStyle blueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(3, (i) {
        bool isfav =
            uc.user.isFavorite(match.blueAllience.teamNumbers[i]) ?? false;

        Widget t = Container(
          child: Text(
            match.blueAllience.teamNumbers[i].toString(),
            style: isfav ? goldStyle : blueStyle,
            textAlign: TextAlign.center,
          ),
        );

        return t;
      }),
    );
  }
}

class _RedRow extends StatelessWidget {
  const _RedRow({
    Key key,
    @required this.uc,
    @required this.match,
    @required this.redStyle,
  }) : super(key: key);

  final UserContainer uc;
  final MatchModel match;
  final TextStyle redStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        3,
        (i) {
          bool f =
              uc.user.isFavorite(match.redAllience.teamNumbers[i]) ?? false;
          return Container(
            child: Text(
              match.redAllience.teamNumbers[i].toString(),
              style: f ? goldStyle : redStyle,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
