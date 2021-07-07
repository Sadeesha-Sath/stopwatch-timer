import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stopwatch_timer/src/models/alarm_model.dart';
import 'package:stopwatch_timer/src/models/timer_model.dart';
import 'package:stopwatch_timer/src/services/database.dart';
import 'package:stopwatch_timer/src/ui/screens/home_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter<AlarmModel>(AlarmModelAdapter())
    ..registerAdapter<TimerModel>(TimerModelAdapter())
    ..registerAdapter<TimeOfDay>(TimeOfDayAdapter());
  await Database.init();
  await AndroidAlarmManager.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch Timer',
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        brightness: Brightness.dark,
        backgroundColor: kBackgroundColor,
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        switchTheme: SwitchThemeData(
          trackColor: TrackColor(),
          thumbColor: ThumbColor(),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: kBackgroundColor,
            brightness: Brightness.dark,
            centerTitle: true,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: OutlineBorderSide(),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 17.5, fontFamily: GoogleFonts.montserrat().fontFamily),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            foregroundColor: MaterialStateProperty.all(kAccentColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kBackgroundColor,
          enableFeedback: true,
        ),
      ),
      home: HomeScreen(),
    );
  }

  @override
  void dispose() async {
    await Hive.box("alarms").compact();
    await Hive.box('timers').compact();
    await Hive.close();
    super.dispose();
  }
}
