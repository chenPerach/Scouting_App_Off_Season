import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static int _id = 0;
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static var _initializationSettingsAndroid;
  static var _initializationSettings;
  static var _androidPlatformChannelSpecifics;
  static var _platformChannelSpecifics;

  static Future<bool> initalize(
      {Future<dynamic> Function(String payload) onSelectNotification}) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));

    _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
    _initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    _initializationSettings =
        InitializationSettings(android: _initializationSettingsAndroid);
    _androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "Scouting App", 'Scouting App', 'the app that scouts',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    _platformChannelSpecifics =
        NotificationDetails(android: _androidPlatformChannelSpecifics);
    await _flutterLocalNotificationPlugin.initialize(_initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static Future<void> showNotification(
      {@required String title, @required String body}) async {
    await _flutterLocalNotificationPlugin.show(
        _id, title, body, _platformChannelSpecifics);
    _id++;
  }

  /// this function scheduals notification in the future
  /// [Note] this method only accepts [dates in the future]
  static Future<void> scheduleNotification(int id, DateTime date,
      {@required String title, @required String body}) async {
    await _flutterLocalNotificationPlugin.zonedSchedule(
        id, title, body, tz.TZDateTime.from(date, tz.local), _platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    List<PendingNotificationRequest> n = await _flutterLocalNotificationPlugin.pendingNotificationRequests();
    n.forEach((element) {
      print(element.title);
    });
  }
  static void removeScheduledNotification(int id){
    _flutterLocalNotificationPlugin.cancel(id);
  }
}
