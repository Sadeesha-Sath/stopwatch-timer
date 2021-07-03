import 'package:hive/hive.dart';
import 'package:stopwatch_timer/src/models/alarm_model.dart';
import 'package:stopwatch_timer/src/models/timer_model.dart';

class Database {
  static late Box alarmBox;
  static late Box timerBox;

  static Future<void> init() async {
alarmBox = await Hive.openBox('alarms');
    timerBox = await Hive.openBox('timers');
  }

  // static Future initAlarmBox() async {
  //   alarmBox = await Hive.openBox('alarms');
  //   if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(AlarmModelAdapter());
  // }

  // static Future initTimerBox() async {
  //   timerBox = await Hive.openBox('timers');
  //   if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TimerModelAdapter());
  // }

  static putAlarms(AlarmModel alarm, {int? index}) {
    if (Hive.isBoxOpen('alarms')) {
      if (index == null)
        alarmBox.add(alarm);
      else
        alarmBox.putAt(index, alarm);
    }
  }

  static putTimers(TimerModel timer, {int? index}) {
    if (Hive.isBoxOpen('timers')) {
      if (index == null)
        timerBox.add(timer);
      else
        timerBox.putAt(index, timer);
    }
  }

  static deleteAlarm(int index) {
    if (Hive.isBoxOpen('alarm')) {
      alarmBox.deleteAt(index);
    }
  }
  static deleteTimer(int index) {
    if (Hive.isBoxOpen('timers')) {
      timerBox.deleteAt(index);
    }
  }
}
