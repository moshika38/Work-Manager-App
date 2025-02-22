import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/services/schedule.notification.dart';
import 'package:task_manager/data/models/schedule.model.dart';

class ScheduleProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// add new schedule to users collection
  Future<void> createNewSchedule(
    String title,
    String frequency,
    DateTime date,
    TimeOfDay time,
    int scheduleId,
  ) async {
    final docRef = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('schedules')
        .doc();
    try {
      final schedule = ScheduleModel(
        scheduleId: scheduleId,
        id: docRef.id,
        title: title,
        frequency: frequency,
        date: date.toString().split(' ')[0],
        time: time,
      );

      await docRef.set({...schedule.toJson()});

      if (frequency == 'Once') {
        // schedule once
        await ScheduleNotification.scheduleOnceNotification(scheduleId,
            time.minute, time.hour, date.day, date.month, date.year,title);
      } else if (frequency == 'Daily') {
        // schedule daily
        await ScheduleNotification.scheduleDailyNotification(
            scheduleId, time.hour, time.minute,title);
      } else if (frequency == 'Monthly') {
        // schedule monthly
        await ScheduleNotification.scheduleMonthlyNotification(
            scheduleId, time.hour, time.minute, date.day,title);
      } else if (frequency == 'Yearly') {
        // schedule yearly
        await ScheduleNotification.scheduleYearlyNotification(
            scheduleId, time.hour, time.minute, date.day, date.month,title);
      }

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print('Error creating schedule: $e');
    }
  }

  // return schedule list from given month using a provided date
  Future<List<ScheduleModel>> getSchedulesByMonth(
    DateTime givenDate,
  ) async {
    final startDate = DateTime(givenDate.year, givenDate.month, 1);
    final endDate = DateTime(givenDate.year, givenDate.month + 1, 0);

    final snapshot = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('schedules')
        .where('date', isGreaterThanOrEqualTo: startDate.toString())
        .where('date', isLessThanOrEqualTo: endDate.toString())
        .get();

    return snapshot.docs
        .map((doc) => ScheduleModel.fromJson(doc.data()))
        .toList();
  }

// return schedule list for the given day using a provided date as a String
  Future<List<ScheduleModel>> getSchedulesByCurrentDate(
    String givenDate,
  ) async {
    // Assuming givenDate is already in "yyyy-MM-dd" format
    final snapshot = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('schedules')
        .where('date', isEqualTo: givenDate) // directly compare string dates
        .get();

    return snapshot.docs
        .map((doc) => ScheduleModel.fromJson(doc.data()))
        .toList();
  }

// delete schedule by doc id
  Future<void> deleteSchedule(String docId) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('schedules')
          .doc(docId)
          .delete();

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print('Error deleting schedule: $e');
    }
  }
}
