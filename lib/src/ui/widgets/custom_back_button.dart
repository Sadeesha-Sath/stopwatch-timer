import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.maybePop(context);
      },
      icon: Icon(
        CupertinoIcons.arrow_turn_up_left,
        color: kTextColor,
      ),
    );
  }
}
