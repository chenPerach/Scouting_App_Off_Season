import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
          height: 90,
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.black12,
                alignment: Alignment.centerLeft,
                child: Padding(
                  child: Text(
                    match.matchNumber.toString(),
                    style: title,
                  ),
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                ),
                width: screenWidth * 0.3,
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              Container(
                width: screenWidth * 0.5,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _RedRow(uc: uc, match: match, redStyle: redStyle),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.5),
                      child: Container(
                        color: Colors.grey,
                        width: screenWidth * 0.4,
                        height: 1,
                      ),
                    ),
                    _BlueRow(uc: uc, match: match, blueStyle: blueStyle)
                  ],
                ),
              ),
            ],
          )),
    );
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

        Widget t = SingleChildScrollView(
          child: Container(
            child: Text(
              match.blueAllience.teamNumbers[i].toString(),
              style: isfav ? goldStyle : blueStyle,
              textAlign: TextAlign.center,
            ),
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
