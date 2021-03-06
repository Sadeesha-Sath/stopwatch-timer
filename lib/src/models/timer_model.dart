import 'package:hive/hive.dart';
part 'timer_model.g.dart';

@HiveType(typeId: 1)
class TimerModel {
  @HiveField(0)
  String name;
  @HiveField(2)
  int durationInSeconds;

  TimerModel({this.name = "Timer", required this.durationInSeconds});
}
