import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch_timer/src/ui/screens/home_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        // textButtonTheme: TextButtonThemeData(
        //   style: ButtonStyle(
        //     textStyle: MaterialStateProperty.all(
        //       TextStyle(fontSize: 17.5),
        //     ),
        //     padding: MaterialStateProperty.all(
        //       EdgeInsets.symmetric(horizontal: 35, vertical: 17.5),
        //     ),
        //     foregroundColor: MaterialStateProperty.all(kAccentColor),
        //     shape: MaterialStateProperty.all(
        //       RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //     ),
        //   ),
        // ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kBackgroundColor,
          enableFeedback: true,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
