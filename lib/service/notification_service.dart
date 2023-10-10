


import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {

  void initNotification() async {
    OneSignal.initialize('67d38057-79fb-4a17-84f9-6fee922649da');
    OneSignal.Notifications.requestPermission(true);
  }

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // final notificationPlugin = FlutterLocalNotificationsPlugin();
  //
  // Future initFirebaseMessage() async {
  //   messaging.requestPermission();
  //   String? token= await messaging.getToken();
  //   print(token);
  //   // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);
  // }
  //
  // Future handleBackgroundMessages(RemoteMessage message) async {
  //   log('message title - ${message.notification?.title}');
  //   log('message body - ${message.notification?.body}');
  //   log('message payload - ${message.data}');
  // }
  //
  //
  // Future initNotification() async {
  //
  //   AndroidInitializationSettings androidInitializationSettings =
  //       const AndroidInitializationSettings('@drawable/app_logo');
  //
  //   var initializationSettingsIOS = DarwinInitializationSettings(
  //       requestAlertPermission: true,
  //       requestBadgePermission: true,
  //       requestSoundPermission: true,
  //       onDidReceiveLocalNotification:
  //           (int id, String? title, String? body, String? payload) async {});
  //
  //   var initializationSettings = InitializationSettings(
  //       android: androidInitializationSettings, iOS: initializationSettingsIOS);
  //
  //   await notificationPlugin.initialize(initializationSettings,
  //       onDidReceiveNotificationResponse:
  //           (NotificationResponse response) async {
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       RemoteNotification? notification = message.notification;
  //       AndroidNotification? android = message.notification?.android;
  //       if (android != null) {
  //         notificationPlugin.show(notification.hashCode, notification!.title,
  //             notification.body, notificationDetails());
  //       }
  //     });
  //   });
  // }
  //
  // notificationDetails() {
  //   return const NotificationDetails(
  //       android: AndroidNotificationDetails('channelId', 'channelName',
  //           importance: Importance.max),
  //       iOS: DarwinNotificationDetails());
  // }
  //
  // Future showNotification(
  //     {int id = 0, String? title, String? body, String? payload}) async {
  //   // return notificationPlugin.show(id, title, body, await notificationDetails());
  // }

  //
  // /// Set right date and time for notifications
  // // tz.TZDateTime _convertTime(int hour, int minutes) {
  // //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  // //   tz.TZDateTime scheduleDate = tz.TZDateTime(
  // //     tz.local,
  // //     now.year,
  // //     now.month,
  // //     now.day,
  // //     hour,
  // //     minutes,
  // //   );
  // //   if (scheduleDate.isBefore(now)) {
  // //     scheduleDate = scheduleDate.add(const Duration(days: 0));
  // //   }
  // //   return scheduleDate;
  // // }
  //
  // Future<void> scheduleDailyNotification({int id = 0,
  //   String? title,
  //   String? body,
  //   String? payLoad}) async {
  //   log('message');
  //   // Calculate the time for 3:00 PM
  //   // final location = DateTime.now().toLocal().timeZoneName.toString();
  //   // log('location - $location ');
  //   // final local = tz.getLocation(location);
  //   // final now = tz.TZDateTime.now(local);
  //   // log('date - $now - $location - $local');
  //   // final scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, 13, 47,00);
  //   // final scheduledTime = tz.TZDateTime().add(Duration(days: 1));
  //   return notificationPlugin.periodicallyShow(
  //       id,
  //       title,
  //       body,
  //       RepeatInterval.daily,
  //       await notificationDetails());
  // }

  // create an instance

// final fltNotification = FlutterLocalNotificationsPlugin();

// void initMessaging() {
//   var androiInit = AndroidInitializationSettings(‘@mipmap/ic_launcher’);//for logo
//   var iosInit = IOSInitializationSettings();
//   var initSetting=InitializationSettings(android: androiInit,iOS:
//   iosInit);
//   fltNotification.initialize(initSetting);
//   var androidDetails =
//   AndroidNotificationDetails('1', 'channelName',channelDescription: 'channel Description',);
//   var iosDetails = IOSNotificationDetails();
//   var generalNotificationDetails =
//   NotificationDetails(android: androidDetails, iOS: iosDetails);
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {     RemoteNotification notification=message.notification;
//   AndroidNotification android=message.notification?.android;
//   if(notification!=null && android!=null){
//     fltNotification.show(
//         notification.hashCode, notification.title, notification.
//     body, generalNotificationDetails);
//   }
//   });
// }
}
