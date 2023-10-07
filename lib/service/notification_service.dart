import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class NotificationService{
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  Future initNotification() async {
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('@drawable/app_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: initializationSettingsIOS);

    await notificationPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse response) async {

    });
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max),
        iOS: DarwinNotificationDetails()
    );
  }

  Future showNotification({int id=0,String? title, String? body,String? payload}) async {
    return notificationPlugin.show(id, title, body, await notificationDetails());
  }

  /// Set right date and time for notifications
  // tz.TZDateTime _convertTime(int hour, int minutes) {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduleDate = tz.TZDateTime(
  //     tz.local,
  //     now.year,
  //     now.month,
  //     now.day,
  //     hour,
  //     minutes,
  //   );
  //   if (scheduleDate.isBefore(now)) {
  //     scheduleDate = scheduleDate.add(const Duration(days: 0));
  //   }
  //   return scheduleDate;
  // }

  Future<void> scheduleDailyNotification({int id = 0,
    String? title,
    String? body,
    String? payLoad}) async {
    log('message');
    // Calculate the time for 3:00 PM
    // final location = DateTime.now().toLocal().timeZoneName.toString();
    // log('location - $location ');
    // final local = tz.getLocation(location);
    // final now = tz.TZDateTime.now(local);
    // log('date - $now - $location - $local');
    // final scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, 13, 47,00);
    // final scheduledTime = tz.TZDateTime().add(Duration(days: 1));
    return notificationPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.daily,
        await notificationDetails());
  }

}