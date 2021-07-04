import 'package:scouting_app_2/models/Match/CompLevel.dart';
import 'package:scouting_app_2/models/model.dart';

class GameInfo extends Model {
  CompLevel compLevel;
  int matchNumber;
  int teamNumber;
  String alliance;
  GameInfo({this.alliance, this.compLevel, this.matchNumber, this.teamNumber});
  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
      alliance: json["alliance"],
      teamNumber: json["team_number"],
      matchNumber: json["match_number"],
      compLevel: CompLevel.simple(json["comp_level"]),);

  @override
  Map<String, dynamic> toJson() {
    return {
      "comp_level": compLevel.simple,
      "match_number": matchNumber,
      "alliance": alliance,
      "team_number": teamNumber
    };
  }
}
