import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> requestPermissions() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (Platform.isAndroid) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            'notification_icon.png'); // Replace with your icon name
    // final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: false,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
