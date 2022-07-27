import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/const/SecondeScreenNotifcation.dart';

 class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  initializeNotification() async
  {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    _configureLocalTimeZone();
     AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('appicon');
     IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );


     InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          selectNotification(payload: payload);
        });
  }

  Future selectNotification({String? payload, BuildContext? context}) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context!,
      MaterialPageRoute<void>(
          builder: (context) => SecondScreen(payload: payload!)),
    );
  }

  Future displayNotification(
      {required String title, required String body}) async {
     AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
     IOSNotificationDetails iosPlatformChannelSpecifics =
    IOSNotificationDetails();
     NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  scheduledNotification(
     int end, int startTime,

  ) async
  {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "title",
        'body',
        convertTime(startTime, end),
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name', channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }


  Future onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload, context) async
  {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: Text(title!),
            content: Text(body!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(payload: 'payload'),
                    ),
                  );
                },
              )
            ],
          ),
    );
  }

  tz.TZDateTime convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, now.year,now.month,now.day,hour,minutes);
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
final String timezone = await FlutterNativeTimezone.getLocalTimezone();
tz.setLocalLocation(tz.getLocation(timezone));
  }

}






