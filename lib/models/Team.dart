class Team {
  int number;
  String nickname;
  Team({this.nickname, this.number});
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(number: json["number"], nickname: json["nickname"]);
  }
  Map<String, dynamic> toJson() {
    return {"nickname": nickname, "number": number};
  }
}

class TeamsConsts {
  static const List<Map<String, dynamic>> teams_json = [
    {"nickname": "MisCar", "number": 1574},
    {"nickname": "Voltrix", "number": 1576},
    {"nickname": "Steampunk", "number": 1577},
    {"nickname": "Hamosad", "number": 1657},
    {"nickname": "Orbit", "number": 1690},
    {"nickname": "Elysium ", "number": 1937},
    {"nickname": "Neat Team", "number": 1943},
    {"nickname": "ElectroBunny", "number": 1954},
    {"nickname": "RoboActive", "number": 2096},
    {"nickname": "The Spikes", "number": 2212},
    {"nickname": "General Angels", "number": 2230},
    {"nickname": "OnyxTronix", "number": 2231},
    {"nickname": "Thunderbolts", "number": 2630},
    {"nickname": "Tiger Team", "number": 2679},
    {"nickname": "Galileo", "number": 3034},
    {"nickname": "Jatt High School", "number": 3065},
    {"nickname": "Ha-Dream Team", "number": 3075},
    {"nickname": "Artemis", "number": 3083},
    {"nickname": "The Y Team", "number": 3211},
    {"nickname": "D-Bug", "number": 3316},
    {"nickname": "BumbleB", "number": 3339},
    {"nickname": "Vulcan", "number": 3835},
    {"nickname": "Ladies FIRST", "number": 4319},
    {"nickname": "The Joker", "number": 4320},
    {"nickname": "Falcons", "number": 4338},
    {"nickname": "Skynet", "number": 4416},
    {"nickname": "PRIMO", "number": 4586},
    {"nickname": "GreenBlitz", "number": 4590},
    {"nickname": "The Red Pirates", "number": 4661},
    {"nickname": "Ninjas", "number": 4744},
    {"nickname": "Black Unicorns", "number": 5135},
    {"nickname": "The Poros", "number": 5554},
    {"nickname": "Team Sycamore", "number": 5614},
    {"nickname": "Demacia", "number": 5635},
    {"nickname": "Phoenix", "number": 5654},
    {"nickname": "DRC", "number": 5715},
    {"nickname": "Athena", "number": 5747},
    {"nickname": "Galaxia", "number": 5987},
    {"nickname": "TRIGON", "number": 5990},
    {"nickname": "Pegasus", "number": 6049},
    {"nickname": "Desert Eagles", "number": 6104},
    {"nickname": "alzahrawi", "number": 6168},
    {"nickname": "Team Koi", "number": 6230},
    {"nickname": "Excalibur", "number": 6738},
    {"nickname": "G3", "number": 6740},
    {"nickname": "Space monkeys", "number": 6741},
    {"nickname": "\u274c\u2b55", "number": 7039},
    {"nickname": "Team Streak", "number": 7067},
    {"nickname": "EverGreen", "number": 7112},
    {"nickname": "Green Rockets", "number": 7554},
    {"nickname": "8BIT", "number": 7845},
    {"nickname": "Mariners", "number": 8223}
  ];
  static List<Team> teams =
      List.generate(teams_json.length, (i) => Team.fromJson(teams_json[i]));
}
