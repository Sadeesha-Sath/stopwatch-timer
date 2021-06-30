import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/alarm_card.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);
  final _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 65),
          Text(
            "Alarms",
            style: TextStyle(fontSize: 30, color: kTitleColor),
          ),
          Spacer(flex: 3),
          Alarmcard(value: _value),
          Spacer(flex: 11),
        ],
      ),
    );
  }
}
