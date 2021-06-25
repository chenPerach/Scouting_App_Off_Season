import 'dart:math';

import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/notification_service.dart';

class MatchNotificationScheduler {
  static Future<void> scheduleMatch(MatchModel match) async {
    if(match.time.compareTo(DateTime.now())>0)
    await NotificationService.scheduleNotification(_match2Id(match), match.time,
        title: "match ${match.compLevel}-${match.matchNumber}",
        body: "is starting now!!");
  }

  static void removeSchedualMatch(MatchModel match) {
    NotificationService.removeScheduledNotification(_match2Id(match));
  }

  static int _match2Id(MatchModel m) {
    int id = 0;
    switch (m.compLevel) {
      case "qm":
        id = 1;
        break;
      case "f":
        id = 4;
        break;
      case "sf":
        id = 3;
        break;
      case "qf":
        id = 1;
        break;
      default:
    }
    id = id * pow(10, m.matchNumber.toString().length) + m.matchNumber;
    return id;
  }
}
