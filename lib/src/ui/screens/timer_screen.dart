import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/timer_model.dart';
import 'package:stopwatch_timer/src/services/database.dart';
import 'package:stopwatch_timer/src/ui/screens/set_timer_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/timer_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: _buildListView(),
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
                      durationInMilliseconds: 0,
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

  ValueListenableBuilder _buildListView() {
    final _timers = Database.timerBox.listenable();
    return ValueListenableBuilder<Box>(
      valueListenable: _timers,
      builder: (context, value, __) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(height: 65),
            Text(
              "Timer",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: kTitleColor),
            ),
            SizedBox(height: 100),
            ...List.generate(value.length, (index) {
              TimerModel timerModel = Database.timerBox.getAt(index) as TimerModel;
              return TimerCard(
                timerModel: timerModel,
                index: index,
              );
            })
          ],
        );
      },
    );
  }
}
