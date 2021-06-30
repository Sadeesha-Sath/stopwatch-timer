import 'package:flutter/material.dart';

class AlarmModel {
  String? title;
  Set<int> activeDays;
  bool isActive;
  TimeOfDay alarmTime;

  AlarmModel({required this.alarmTime, this.title, this.activeDays = const {}, this.isActive = true});
}
