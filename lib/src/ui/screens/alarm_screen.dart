import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stopwatch_timer/src/models/alarm_model.dart';
import 'package:stopwatch_timer/src/services/database.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/alarm_card.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(child: _buildAlarmCards()),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              Database.putAlarms(
                AlarmModel(alarmTime: TimeOfDay(hour: 3, minute: 2), title: "Alarm 2"),
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

  ValueListenableBuilder _buildAlarmCards() {
    final alarms = Database.alarmBox.listenable();
    return ValueListenableBuilder<Box>(
      valueListenable: alarms,
      builder: (context, value, __) => ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: 65),
          Text(
            "Alarms",
            style: TextStyle(fontSize: 30, color: kTitleColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 100),
          Visibility(
            visible: value.isEmpty,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "Oops, no alarms set yet. Let's create one, shall we?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ...List.generate(value.length, (index) {
            AlarmModel alarmModel = Database.alarmBox.getAt(index) as AlarmModel;
            return Alarmcard(alarmModel: alarmModel, index: index,);
          }),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
