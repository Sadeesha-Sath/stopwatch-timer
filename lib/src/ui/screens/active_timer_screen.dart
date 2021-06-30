import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class ActiveTimerScreen extends StatefulWidget {
  const ActiveTimerScreen({Key? key}) : super(key: key);

  @override
  _ActiveTimerScreenState createState() => _ActiveTimerScreenState();
}

class _ActiveTimerScreenState extends State<ActiveTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 65),
              Hero(
                tag: "title",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "Timer 1",
                    style: TextStyle(fontSize: 30, color: kTitleColor),
                  ),
                ),
              ),
              Spacer(flex: 14),
            ],
          ),
        ),
      ),
    );
  }
}
