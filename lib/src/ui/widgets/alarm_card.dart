import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class Alarmcard extends StatefulWidget {
  Alarmcard({Key? key, required this.value}) : super(key: key);

  final bool value;
  @override
  _AlarmcardState createState() => _AlarmcardState();
}

class _AlarmcardState extends State<Alarmcard> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      color: kCardColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
        child: Row(
          children: [
            Text(
              "03.00",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 4,
            ),
            Text(
              "S  M  T  W  T  F  S",
              style: TextStyle(fontSize: 14),
            ),
            Spacer(),
            Switch(
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
