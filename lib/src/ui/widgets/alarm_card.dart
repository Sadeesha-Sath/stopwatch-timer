import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/alarm_model.dart';
import 'package:stopwatch_timer/src/services/database.dart';
import 'package:stopwatch_timer/src/ui/screens/edit_alarm_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class Alarmcard extends StatelessWidget {
  Alarmcard({Key? key, required this.alarmModel, required this.index}) : super(key: key);
  static const List<String> _daysOfWeek = ['S  ', 'M  ', 'T  ', 'W  ', 'T  ', 'F  ', 'S  '];
  final AlarmModel alarmModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
                  index: index,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
            child: Row(
              children: [
                Visibility(
                  visible: alarmModel.name != "",
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alarmModel.alarmTime.format(context),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        alarmModel.name,
                        style: TextStyle(color: kUnselectedColor),
                      )
                    ],
                  ),
                  replacement: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      alarmModel.alarmTime.format(context),
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                RichText(
                  text: TextSpan(
                    children: List.generate(
                      7,
                      (index) => TextSpan(
                        text: _daysOfWeek[index],
                        style:
                            TextStyle(color: alarmModel.activeDays.toSet().contains(index) ? kAccentColor : kTextColor),
                      ),
                    ),
                  ),
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
