import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:task_manager/core/notifications/notification.services.dart';

class ScheduleNotification {
  // schedule daily notification
  static Future<void> scheduleDailyNotification(
    int id,
    int hour,
    int minute,
    String body,
  ) async {
    CreateNotification(
      id: id,
      hour: hour,
      minute: minute,
      body: body,
    ).show();
  }

//   // schedule weekly notification
// static  Future<void> scheduleWeeklyNotification(
//     int id,
//     int hour,
//     int minute,
//     int week,
//   ) async {
//     CreateNotification(
//       id: id,
//       hour: hour,
//       minute: minute,
//       weekDay: week,
//     ).show();
//   }

  // schedule monthly notification
  static Future<void> scheduleMonthlyNotification(
    int id,
    int hour,
    int minute,
    int day,
    String body,
  ) async {
    CreateNotification(
      id: id,
      hour: hour,
      minute: minute,
      day: day,
      body: body,
    ).show();
  }

  // schedule yearly notification
  static Future<void> scheduleYearlyNotification(
    int id,
    int hour,
    int minute,
    int day,
    int month,
    String body,
  ) async {
    CreateNotification(
      id: id,
      hour: hour,
      minute: minute,
      day: day,
      month: month,
      body: body,
    ).show();
  }

  // schedule once notification
  static Future<void> scheduleOnceNotification(
    int id,
    int minute,
    int hour,
    int day,
    int month,
    int year,
    String body,
  ) async {
    CreateNotification(
      id: id,
      minute: minute,
      hour: hour,
      day: day,
      month: month,
      year: year,
      body: body,
    ).show();
  }

  // cancel or delete scheduled notification
  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
