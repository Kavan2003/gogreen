import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz2;
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initializePlugin();
  }

  Future<void> initializePlugin() async {
    tz2.initializeTimeZones();

    // Request permissions
    requestPermission();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      await Permission.notification.request();
      await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> _scheduleNotification() async {
    var scheduledNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 1));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '2', // Replace with your unique ID
      'Important Updates',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    // Use zonedSchedule instead of schedule
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Scheduled Notification',
      'This is a scheduled notification.',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle:
          true, // Optional: Allow notification even in Doze mode (Android)
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Local Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (await Permission.notification.status.isGranted &&
                await Permission.scheduleExactAlarm.status.isGranted) {
              // Schedule notification using zonedSchedule
              await _scheduleNotification();
            } else {
              // Request permissions and schedule notification again
              await requestPermission();
              await _scheduleNotification();
            }
          },
          child: Text('Schedule Notification in 5 seconds'),
        ),
      ),
    );
  }
}
