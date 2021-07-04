import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class AlarmModel {
  @HiveField(0)
  String? title;
  @HiveField(1)
  List<int> activeDays;
  @HiveField(2)
  bool isActive;
  @HiveField(3)
  TimeOfDay alarmTime;

  AlarmModel({required this.alarmTime, this.title, this.activeDays = const [], this.isActive = true});
  AlarmModel.updateState(AlarmModel alarmModel, bool value)
      : title = alarmModel.title,
        activeDays = alarmModel.activeDays,
        alarmTime = alarmModel.alarmTime,
        isActive = value;
}
