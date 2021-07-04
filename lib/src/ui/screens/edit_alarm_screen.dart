import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/alarm_model.dart';

class EditAlarmScreen extends StatelessWidget {
  const EditAlarmScreen({Key? key, required this.alarmModel, this.index}) : super(key: key);
  final AlarmModel alarmModel;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Edit Alarms"),
        ),
      ),
    );
  }
}
