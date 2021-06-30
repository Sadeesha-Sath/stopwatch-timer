import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/widgets/timer_card.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          TimerCard(),
        ],
      ),
    );
  }
}
