import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/timer_model.dart';
import 'package:stopwatch_timer/src/ui/screens/set_timer_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/timer_card.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetTimerScreen(
                    timerModel: TimerModel(
                      duration: Duration.zero,
                    ),
                  ),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 30,
            ),
            shape: CircleBorder(),
          ),
        )
      ],
    );
  }
}
