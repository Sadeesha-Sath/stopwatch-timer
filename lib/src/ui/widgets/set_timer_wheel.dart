import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch_timer/src/models/picker_value_enum.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class SetTimerWheel extends StatelessWidget {
  const SetTimerWheel({
    Key? key,
    required this.initialValue,
    required this.callback,
  }) : super(key: key);
  final int initialValue;
  final void Function(int, PickerValue) callback;

  @override
  Widget build(BuildContext context) {
    int hours = (initialValue ~/ 3600000);
    int minutes = ((initialValue ~/ 60000) % 60);
    int seconds = ((initialValue ~/ 1000) % 60);
    return Row(
      children: [
        CustomPicker(
          mode: PickerValue.hours,
          value: hours,
          callback: callback,
        ),
        Spacer(),
        Seperator(),
        Spacer(),
        CustomPicker(
          mode: PickerValue.minutes,
          value: minutes,
          callback: callback,
        ),
        Spacer(),
        Seperator(),
        Spacer(),
        CustomPicker(
          mode: PickerValue.seconds,
          value: seconds,
          callback: callback,
        ),
      ],
    );
  }
}

class CustomPicker extends StatelessWidget {
  CustomPicker({
    Key? key,
    required this.mode,
    required this.value,
    required this.callback,
  }) : super(key: key);

  final PickerValue mode;
  final int value;
  final void Function(int, PickerValue) callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          mode == PickerValue.hours ? "Hours": mode == PickerValue.minutes ? "Minutes": "Seconds",
          style: TextStyle(fontSize: 20, color: kTitleColor),
        ),
        SizedBox(
          width: 100,
          height: 280,
          child: Center(
            child: CupertinoPicker(
              diameterRatio: 1.1,
              scrollController: FixedExtentScrollController(initialItem: value),
              looping: mode != PickerValue.hours,
              itemExtent: 38,
              onSelectedItemChanged: (int value) {
                //TODO Add logic
                callback(value, mode);
              },
              children: [
                for (var i = 0; i < (mode== PickerValue.hours ? 100 : 60); i += 1)
                  Text(
                    i.toString(),
                    style: TextStyle(color: kTitleColor, fontFamily: GoogleFonts.lato().fontFamily, fontSize: 25),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Seperator extends StatelessWidget {
  const Seperator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 22),
          Text(
            ":",
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: kUnselectedColor,
                fontFamily: GoogleFonts.merriweather().fontFamily),
          ),
        ],
      ),
    );
  }
}
