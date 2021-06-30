import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/screens/active_timer_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      color: kCardColor,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(28, 15, 0, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "title",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        "Timer 1",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "00:03.00",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveTimerScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(color: kCardSectionGoldColor, borderRadius: BorderRadius.circular(22)),
                  // alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 30,
                        color: Color(0xFF333333),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
