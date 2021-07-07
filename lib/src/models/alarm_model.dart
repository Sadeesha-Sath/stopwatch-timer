import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class AlarmModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> activeDays;
  @HiveField(2)
  bool isActive;
  @HiveField(3)
  TimeOfDay alarmTime;
  @HiveField(4)
  bool isVibrate;
  @HiveField(5)
  int alarmTone;

  AlarmModel(
      {required this.alarmTime,
      this.name = "",
      this.activeDays = const [],
      this.isActive = false,
      this.isVibrate = true,
      int? alarmSound}) : alarmTone = alarmSound ?? (Platform.isAndroid ? 1 : 1001);

  AlarmModel.updateState(AlarmModel alarmModel, bool value)
      : name = alarmModel.name,
        activeDays = alarmModel.activeDays,
        alarmTime = alarmModel.alarmTime,
        isVibrate = alarmModel.isVibrate,
        alarmTone = alarmModel.alarmTone,
        isActive = value;
}
