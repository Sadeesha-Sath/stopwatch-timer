import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/widgets/alarm_card.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);
  final _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          Alarmcard(value: _value),
        ],
      ),
    );
  }
}
