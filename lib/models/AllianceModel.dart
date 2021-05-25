class Allience {
  List<int> teamNumbers;
  String color;
  Allience({this.color, this.teamNumbers});

  factory Allience.fromJson(List<String> teams, String color) {
    return Allience(
        color: color,
        teamNumbers: List<int>.generate(
            teams.length, (i) => int.parse(teams[i].substring(3))));
  }
}
