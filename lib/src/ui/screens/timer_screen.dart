import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/timer_card.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: 65),
          Text(
            "Timer",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: kTitleColor),
          ),
          SizedBox(height: 100),
          TimerCard(),
        ],
      ),
    );
  }
}
