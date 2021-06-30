import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch_timer/src/models/lap_model.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/lap_card.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _animationController;
  bool _isPlaying = false;
  Stopwatch _stopwatch = Stopwatch();
  late Timer _stopwatchHandeler;
  int elsapedMilliseconds = 0;
  List<LapModel> _lapList = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // print('building page');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Text(
            "Stopwatch",
            style: TextStyle(fontSize: 30, color: kTitleColor),
          ),
          Spacer(flex: 3),
          // StopwatchText(rawMilliseconds: elsapedMilliseconds),
          _buildText(elsapedMilliseconds),
          Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: _isPlaying
                    ? () {
                        if (_lapList.isNotEmpty) {
                          var previousLap = _lapList.last;
                          var newLap = LapModel(
                            totalElsapedMilliseconds: elsapedMilliseconds,
                            number: previousLap.number + 1,
                            lapMilliseconds: elsapedMilliseconds - previousLap.totalElsapedMilliseconds,
                          );
                          setState(() {
                            _lapList.add(newLap);
                          });
                        } else {
                          var newLap = LapModel(
                            totalElsapedMilliseconds: elsapedMilliseconds,
                            number: 1,
                            lapMilliseconds: elsapedMilliseconds,
                          );
                          setState(() {
                            _lapList.add(newLap);
                          });
                        }
                      }
                    : null,
                child: Text("Lap"),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all(CircleBorder()),
                ),
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                  if (_isPlaying) {
                    setState(() {
                      _animationController.forward();
                    });
                    _stopwatch..start();
                    _stopwatchHandeler = Timer.periodic(Duration(milliseconds: 30), (timer) {
                      _handleStopwatch();
                    });
                  } else {
                    setState(() {
                      _animationController.reverse();
                    });
                    _stopwatch..stop();
                    if (_stopwatchHandeler.isActive) _stopwatchHandeler.cancel();
                  }
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  size: 60,
                  progress: _animationController,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  _stopwatch..reset();
                  if (_stopwatchHandeler.isActive) _stopwatchHandeler.cancel();
                  setState(() {
                    elsapedMilliseconds = 0;
                    _lapList.clear();
                  });
                },
                child: Text("Reset"),
              ),
            ],
          ),
          Spacer(),
          Visibility(
            child: Expanded(
              flex: 8,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var reversedList = _lapList.reversed;
                  return LapCard(lapModel: reversedList.elementAt(index));
                },
                itemCount: _lapList.length,
              ),
            ),
            visible: _lapList.isNotEmpty,
            replacement: Spacer(flex: 8),
          ),
        ],
      ),
    );
  }

  void _handleStopwatch() {
    if (_isPlaying) {
      setState(() {
        elsapedMilliseconds = _stopwatch.elapsedMilliseconds;
      });
      // print(elsapedMilliseconds);
    }
  }

  Text _buildText(int rawMilliseconds) {
    int hours = (rawMilliseconds ~/ 3600000);
    int minutes = ((rawMilliseconds ~/ 60000) % 60);
    int seconds = ((rawMilliseconds ~/ 1000) % 60);
    int milliseconds = ((rawMilliseconds ~/ 10) % 100);
    bool hideHours = hours == 0;
    return Text.rich(
      TextSpan(children: [
        if (!hideHours) ...[
          TextSpan(text: hours.toString()),
          TextSpan(text: ":", style: TextStyle(color: kUnselectedColor)),
        ],
        TextSpan(text: minutes > 9 ? minutes.toString() : "0$minutes"),
        TextSpan(text: ".", style: TextStyle(color: kUnselectedColor)),
        TextSpan(text: seconds > 9 ? seconds.toString() : "0$seconds"),
        TextSpan(
          text: milliseconds > 9 ? ".$milliseconds" : ".0$milliseconds",
          style: TextStyle(fontSize: hideHours ? 55 : 50, color: kUnselectedColor),
        ),
      ]),
      style: TextStyle(
          fontSize: hideHours ? 80 : 72,
          fontWeight: FontWeight.w300,
          color: kPrimaryColor,
          fontFamily: GoogleFonts.lato().fontFamily),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

