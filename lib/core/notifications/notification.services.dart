import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// service class
class NotificationServices {
  static Future<void> initNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'flutter_notification_channel',
          channelName: "Task Manager",
          channelDescription: "Task Manager Notification",
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          defaultColor: Colors.blue,
          locked: true,
          enableVibration: true,
          playSound: true,
        )
      ],
    );
  }
}

// create class
class CreateNotification {
  final int? year;
  final int? month;
  final int? day;
  final int? weekDay;
  final int? hour;
  final int? minute;
  final int id;
  final String body;

  CreateNotification({
    this.year,
    this.month,
    this.day,
    this.weekDay,
    this.hour,
    this.minute,
    required this.id,
    required this.body,
  });

  Future<void> show() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'flutter_notification_channel',
        title: 'Alert message !',
        body: body,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        wakeUpScreen: true,
        autoDismissible: true,
        fullScreenIntent: true,
        backgroundColor: Colors.blue,
        category: NotificationCategory.Message,
      ),
      schedule: NotificationCalendar(
        year: year,
        month: month,
        day: day,
        weekday: weekDay,
        hour: hour,
        minute: minute,
        second: 0,
        preciseAlarm: true,
        allowWhileIdle: true,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        repeats: true,
      ),
      actionButtons: [
         
        NotificationActionButton(
          key: "View",
          label: "View",
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: "Close",
          label: "Close",
          autoDismissible: true,
          actionType: ActionType.DisabledAction,
        ),
      ],
    );
  }
}



// await AwesomeNotifications().cancel(id);




// final randomID = int.parse(uuid
//     .v4()
//     .replaceAll(RegExp(r'[^0-9]'), '')
//     .substring(0, 4));

// CreateNotification(
//   id: randomID,
//   hour: selectedTime.hour,
//   minute: selectedTime.minute,
                            
// ).show();
