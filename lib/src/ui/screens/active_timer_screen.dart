import 'dart:async';
import 'package:flutter/cupertino.dart';
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
  late final Duration _totalDuration;
  late Stopwatch _stopwatch = Stopwatch();
  late Timer _handleTimer;
  late ValueNotifier<Duration> _textNotifier;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    // _mainTimer = Timer(widget.timerModel.duration, () {
    // print("Done");
    // _handleTimer.cancel();
    // });
    _totalDuration = Duration(milliseconds: widget.timerModel.durationInMilliseconds);
    _textNotifier = ValueNotifier<Duration>(_totalDuration);
    // To eliminate the first second gap between stopwatch starting and _handleTimer updating
    _handleCallback();
    _handleTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) => _handleCallback());
  }

  @override
  void dispose() {
    _handleTimer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _handleCallback() {
    var newValue = _totalDuration - _stopwatch.elapsed;
    _textNotifier.value = newValue;
    if (newValue <= Duration.zero) {
      // TODO Add timer complete handling
      print('done');
      _handleTimer.cancel();
      setState(() {
        _stopwatch
          ..stop()
          ..reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.arrow_turn_up_left,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // SizedBox(height: 65),
              Hero(
                tag: "title",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.timerModel.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: kTitleColor),
                  ),
                ),
              ),
              SizedBox(height: 55),
              SizedBox(
                height: MediaQuery.of(context).size.width - 60,
                child: ValueListenableBuilder<Duration>(
                  valueListenable: _textNotifier,
                  builder: (context, value, __) => _buildWidget(value),
                ),
              ),
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: OutlinedButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.all(16),
                          ),
                        ),
                        onPressed: _stopwatch.isRunning
                            ? () {
                                _handleTimer.cancel();
                                setState(() {
                                  _stopwatch.stop();
                                });
                              }
                            : () {
                                setState(() {
                                  _stopwatch.start();
                                });
                                _handleTimer =
                                    Timer.periodic(Duration(milliseconds: 1000), (timer) => _handleCallback());
                                _handleCallback();
                              },
                        label: Text(_stopwatch.isRunning ? "Break" : "Resume"),
                        icon: Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 5,
                      child: OutlinedButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.all(16),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _stopwatch
                              ..stop()
                              ..reset();
                          });
                          _handleTimer.cancel();
                          _handleCallback();
                        },
                        label: Text(_stopwatch.isRunning ? "Stop" : "Reset"),
                        icon: Icon(_stopwatch.isRunning ? Icons.stop : Icons.restart_alt_sharp),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 9.5,
            child: CircularProgressIndicator(
              strokeWidth: 0.75,
              color: kPrimaryColor,
              value: duration.inMilliseconds / widget.timerModel.durationInMilliseconds,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: hours.toString()),
              TextSpan(text: ":", style: TextStyle(color: kUnselectedColor)),
              TextSpan(text: minutes > 9 ? minutes.toString() : "0$minutes"),
              TextSpan(text: ":", style: TextStyle(color: kUnselectedColor)),
              TextSpan(text: seconds > 9 ? seconds.toString() : "0$seconds"),
            ]),
            style: TextStyle(
                fontSize: 75,
                fontWeight: FontWeight.w300,
                color: kPrimaryColor,
                fontFamily: GoogleFonts.lato().fontFamily),
          ),
        ),
      ],
    );
  }
}
