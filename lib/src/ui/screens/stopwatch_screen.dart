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
  late ValueNotifier<int> _notifier;
  late AnimationController _animationController;
  bool _isPlaying = false;
  Stopwatch _stopwatch = Stopwatch();
  late Timer _stopwatchHandeler;
  List<LapModel> _lapList = [];

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<int>(0);
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('building page');
    return Container(
      alignment: Alignment.center,
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 65),
          Text(
            "Stopwatch",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: kTitleColor,
            ),
          ),
          // Spacer(flex: 3),
          SizedBox(height: 100),
          // StopwatchText(rawMilliseconds: elsapedMilliseconds),
          Align(
              alignment: Alignment.center,
              child: ValueListenableBuilder<int>(
                valueListenable: _notifier,
                builder: (context, value, __) => _buildText(value),
              )),
          // Spacer(
          //   flex: 2,
          // ),
          SizedBox(height: 55),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: _isPlaying
                    ? () {
                        if (_lapList.isNotEmpty) {
                          var previousLap = _lapList.last;
                          var newLap = LapModel(
                            totalElsapedMilliseconds: _notifier.value,
                            number: previousLap.number + 1,
                            lapMilliseconds: _notifier.value - previousLap.totalElsapedMilliseconds,
                          );
                          setState(() {
                            _lapList.add(newLap);
                          });
                        } else {
                          var newLap = LapModel(
                            totalElsapedMilliseconds: _notifier.value,
                            number: 1,
                            lapMilliseconds: _notifier.value,
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
                    _animationController.forward();

                    _stopwatch..start();
                    _stopwatchHandeler = Timer.periodic(Duration(milliseconds: 40), (timer) {
                      _handleStopwatch();
                    });
                  } else {
                    _animationController.reverse();

                    _stopwatch..stop();
                    if (_stopwatchHandeler.isActive) _stopwatchHandeler.cancel();
                  }
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  size: 60,
                  progress: CurvedAnimation(
                    curve: Curves.easeIn,
                    parent: _animationController,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  _stopwatch..reset();
                  _notifier.value = 0;
                  setState(() {
                    _lapList.clear();
                  });
                },
                child: Text("Reset"),
              ),
            ],
          ),
          SizedBox(height: 45),
          ...List.generate(_lapList.length, (index) {
            var reversedList = _lapList.reversed;
            return LapCard(lapModel: reversedList.elementAt(index));
          }),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  void _handleStopwatch() {
    if (_isPlaying) {
      _notifier.value = _stopwatch.elapsedMilliseconds;
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
