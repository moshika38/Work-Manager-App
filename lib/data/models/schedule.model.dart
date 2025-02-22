import 'package:flutter/material.dart';

class ScheduleModel {
  final String id;
  final String title;
  final String frequency;
  final String date;
  final TimeOfDay time;
  final int scheduleId;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.frequency,
    required this.date,
    required this.time,
    required this.scheduleId,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      title: json['title'],
      frequency: json['frequency'],
      date: json['date'],
      time: TimeOfDay(
        hour: json['time']['hour'],
        minute: json['time']['minute'],
      ),
      scheduleId: json['scheduleId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'frequency': frequency,
      'date': date,
      'time': {
        'hour': time.hour,
        'minute': time.minute,
      },
      'scheduleId': scheduleId,
    };
  }
}
