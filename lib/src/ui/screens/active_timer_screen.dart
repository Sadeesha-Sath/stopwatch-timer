import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch_timer/src/models/timer_model.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class ActiveTimerScreen extends StatefulWidget {
  const ActiveTimerScreen({Key? key, required this.timerModel}) : super(key: key);
  final TimerModel timerModel;

  @override
  _ActiveTimerScreenState createState() => _ActiveTimerScreenState();
}

class _ActiveTimerScreenState extends State<ActiveTimerScreen> {
  late Stopwatch _stopwatch = Stopwatch();
  late Timer _handleTimer;
  late ValueNotifier<Duration> _textNotifier;

  @override
  void initState() {
    super.initState();
    _stopwatch..start();
    // _mainTimer = Timer(widget.timerModel.duration, () {
    // print("Done");
    // _handleTimer.cancel();
    // });
    _textNotifier = ValueNotifier<Duration>(widget.timerModel.duration);
    // To eliminate the first second gap between stopwatch starting and _handleTimer updating
    _handleCallback();
    _handleTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      _handleCallback();
    });
  }

  void _handleCallback() {
    var newValue = widget.timerModel.duration - _stopwatch.elapsed;
    _textNotifier.value = newValue;
    if (newValue <= Duration.zero) {
      // TODO Add timer complete handling
      print('done');
      _handleTimer..cancel();
      _stopwatch..stop();
      _stopwatch..reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 65),
              Hero(
                tag: "title",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "Timer 1",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: kTitleColor),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ValueListenableBuilder<Duration>(
                  valueListenable: _textNotifier,
                  builder: (context, value, __) => _buildText(value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildText(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: hours.toString()),
        TextSpan(text: ":", style: TextStyle(color: kUnselectedColor)),
        TextSpan(text: minutes > 9 ? minutes.toString() : "0$minutes"),
        TextSpan(text: ":", style: TextStyle(color: kUnselectedColor)),
        TextSpan(text: seconds > 9 ? seconds.toString() : "0$seconds"),
      ]),
      style: TextStyle(
          fontSize: 80, fontWeight: FontWeight.w300, color: kPrimaryColor, fontFamily: GoogleFonts.lato().fontFamily),
    );
  }
}
