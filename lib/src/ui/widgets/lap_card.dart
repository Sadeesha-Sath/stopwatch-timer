import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/lap_model.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class LapCard extends StatelessWidget {
  LapCard({
    Key? key,
    required this.lapModel,
  }) : super(key: key);

  final LapModel lapModel;

  @override
  Widget build(BuildContext context) {
    int rawMilliseconds = lapModel.lapMilliseconds;
    int hours = (rawMilliseconds ~/ 3600000);
    int minutes = ((rawMilliseconds ~/ 60000) % 60);
    int seconds = ((rawMilliseconds ~/ 1000) % 60);
    int milliseconds = ((rawMilliseconds ~/ 10) % 100);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Card(
        color: kCardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 18, 30, 18),
          child: Row(
            children: [
              Text(
                "Lap ${lapModel.number}",
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Text(
                hours == 0
                    ? "${minutes > 9 ? minutes : '0$minutes'}.${seconds > 9 ? seconds : '0$seconds'}.${milliseconds > 9 ? milliseconds : '0$milliseconds'}"
                    : "$hours:${minutes > 9 ? minutes : '0$minutes'}.${seconds > 9 ? seconds : '0$seconds'}.${milliseconds > 9 ? milliseconds : '0$milliseconds'}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
