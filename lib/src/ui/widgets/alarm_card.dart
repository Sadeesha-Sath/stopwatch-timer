import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/alarm_model.dart';
import 'package:stopwatch_timer/src/services/database.dart';
import 'package:stopwatch_timer/src/ui/screens/edit_alarm_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class Alarmcard extends StatelessWidget {
  Alarmcard({Key? key, required this.alarmModel, required this.index}) : super(key: key);

  final AlarmModel alarmModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        color: kCardColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditAlarmScreen(
                  alarmModel: alarmModel,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
            child: Row(
              children: [
                Text(
                  "03:00",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(
                  flex: 4,
                ),
                Text(
                  "S  M  T  W  T  F  S",
                  style: TextStyle(fontSize: 14),
                ),
                Spacer(),
                Switch(
                  value: alarmModel.isActive,
                  onChanged: (value) {
                    Database.putAlarms(AlarmModel.updateState(alarmModel, value), index: index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
